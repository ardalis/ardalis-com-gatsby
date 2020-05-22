---
templateKey: blog-post
title: Bidirectional Entity Foreign Key Names in EF Code First
path: blog-post
date: 2011-09-22T05:25:00.000Z
description: "Ran into a small problem today, where I had two classes referring
  to one another using EF 4.1 Code First.  Let’s say I had a class Item and
  another class ItemHistory. "
featuredpost: false
featuredimage: /img/arrows-1834859_1280.jpg
tags:
  - entity framework
category:
  - Software Development
comments: true
share: true
---
Ran into a small problem today, where I had two classes referring to one another using EF 4.1 Code First. Let’s say I had a class Item and another class ItemHistory. ItemHistory has a property of type Item that refers to the Item class. Item, in turn, has an ICollection<ItemHistory> Histories property:

```
<span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> Item

{

  <span style="color: #0000ff">public</span> <span style="color: #0000ff">int</span> Id { get; set; }

  <span style="color: #0000ff">public</span> <span style="color: #0000ff">virtual</span> ICollection&lt;ItemHistory&gt; Histories { get; set; }

}


<span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> ItemHistory

{

  <span style="color: #0000ff">public</span> <span style="color: #0000ff">int</span> Id { get; set; }

  <span style="color: #0000ff">public</span> <span style="color: #0000ff">virtual</span> Item Item { get; set; }

}
```

In my DbContext OnModelCreating() I have some code like this to set the foreign key names according to the company standard (capitalize ID, no underscores):

```
modelBuilder.Entity&lt;ItemHistory&gt;()
  .HasRequired(m =&gt; m.Item)

 .WithMany()

 .Map(p =&gt; p.MapKey(<span style="color: #006080">"ItemID"</span>));
```

Likewise, I specified the primary keys like this:

```
modelBuilder.Entity&lt;Item&gt;().Property(p =&gt; p.Id).HasColumnName(<span style="color: #006080">"ItemID"</span>);
modelBuilder.Entity&lt;ItemHistory&gt;().Property(p =&gt; p.Id).HasColumnName(<span style="color: #006080">"ItemHistoryID"</span>);
```



In this way, I can use the C# convention of simply specifying the Id (in PascalCase) but still keep the database police happy with their standards. All of this is great except that as it stands now when the database is generated, the ItemHistory table has two foreign key columns:

ItemID

Item_Id1

Do you see what the problem is? I struggled for a bit trying to search for now to name the foreign key in entity framework code first, but of course everything says to either use MapKey() or if you are actually including the column IDs as properties on your entities, then you can [use .HasForeignKey() as shown here](http://stackoverflow.com/questions/5656159/entity-framework-4-1-code-first-foreign-key-ids). However, what I didn’t immediately realize because I wasn’t providing it any parameters anywhere else in my code is that .WithMany() takes an (optional) expression. So, if you want to specify the relationship on the other entity, you do it in .WithMany() like so:

```
modelBuilder.Entity&lt;ItemHistory&gt;()
             .HasRequired(m =&gt; m.Item)

                .WithMany(i =&gt; i.Histories)

                .Map(p =&gt; p.MapKey(<span style="color: #006080">"ItemID"</span>));

```

Once that’s done, you should have only a single FK column generated in your database, and it should be the correct one (with ID not _Id1 suffix).