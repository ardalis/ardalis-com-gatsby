---
templateKey: blog-post
title: Encapsulated Collections in Entity Framework Core
path: blog-post
date: 2017-01-18T04:16:00.000Z
description: "Starting with Entity Framework Core 1.1, you can now have properly
  encapsulated collections in your classes that rely on EF for persistence. "
featuredpost: false
featuredimage: /img/entity-framework-logo_2colors_square_rgb-591x360.png
tags:
  - .net core
  - ddd
  - ef core
  - entity framework
  - entity framework core
category:
  - Software Development
comments: true
share: true
---
Starting with Entity Framework Core 1.1, you can now have properly encapsulated collections in your classes that rely on EF for persistence. Previous versions of EF have required collection properties to support ICollection<T>, which means any user of the class can add or remove items from its properties (or even Clear it). If you’re writing good code that encapsulates business behavior in an entity model, you don’t want to allow this. Instead you want to expose an interface that controls how and when your property can be manipulated, and what kinds of behavior should occur when it is. This isn’t just good [domain-driven design](https://www.pluralsight.com/courses/domain-driven-design-fundamentals); it’s good [object-oriented design](https://www.pluralsight.com/courses/principles-oo-design) as well.

I have an example I use in my DDD with ASP.NET Core workshops that uses a simple Guestbook entity, which has a collection of GuestbookEntry Entries. Initially, this is modeled as a simple List<GuestbookEntry> property. However, when a new entry is added, notifications need to be sent to authors of previous entries. With proper encapsulation, this can easily be achieved by putting an AddEntry() method on Guestbook and making it responsible for adding the entry and firing off the notification (or raising a domain event that can be handled elsewhere to perform the notification).

Unfortunately, exposing a List means that there are two ways to add an entry:

`// the preferred way `\
`guestbook.AddEntry(entry);
// the back door way - bypasses logic in AddEntry()
guestbook.Entries.Add(entry);`

I’ve written previously about[how to protect collections in EF6](http://ardalis.com/exposing-private-collection-properties-to-entity-framework)– it’s a bit of a pain to achieve. EF Core 1.1 makes it much easier. For one thing, it supports mapping to fields, not just properties, without any hacks. This means you can use a private backing collection while exposing something with less functionality, like IEnumerable<T>. Note that even if you expose your private collection as an IEnumerable, client code can still cast it back to an ICollection or IList, and manipulate it (if the underlying type matches). To protect against this, make a copy of the list when you provide the enumerable:

`public class Guestbook : BaseEntity {
    public string Name { get; set; }
    private readonly List<GuestbookEntry> _entries = 
        new List<GuestbookEntry>();
    public IEnumerable<GuestbookEntry> Entries => _entries.ToList();

    public void AddEntry(GuestbookEntry entry)
    {
        _entries.Add(entry);
        Events.Add(new EntryAddedEvent(this.Id, entry));
    }
}`

In the above example, BaseEntity includes the Id property and Events collection. Note that the Entries property doesn’t simply return the _entries field, but rather creates a copy of it. This is safer from an encapsulation perspective, but does use some resources with every access. A slight improvement to it would be to use the AsReadOnly() extension, which doesn’t make a copy of the list’s contents:

`public class Guestbook : BaseEntity {
    public string Name { get; set; }
    private readonly List<GuestbookEntry> _entries = 
        new List<GuestbookEntry>();
    public IEnumerable<GuestbookEntry> Entries => _entries.AsReadOnly();

    public void AddEntry(GuestbookEntry entry)
    {
        _entries.Add(entry);
        Events.Add(new EntryAddedEvent(this.Id, entry));
    }
}`

With that one small change, we now have a solid pattern for encapsulating collection properties in our domain entities when working with Entity Framework Core 1.1 (and above). **I recommend the following combination**, as shown in the code above, for collection properties:

* Define a private readonly List<T> as a backing field. This is the entity’s private state store.
* Define a public IEnumerable<T> property as the readonly access to this store.
* Specify the value of this property as the private backing field.AsReadOnly();
* Configure EF to use the private backing field (see below)

All by itself, EF Core 1.1 won’t properly map the private _entries field to the data store. You need to configure it in OnModelCreating:

`protected override void OnModelCreating(ModelBuilder modelBuilder) {
    var navigation = modelBuilder.Entity<Guestbook>()
        .Metadata.FindNavigation(nameof(Guestbook.Entries));

    navigation.SetPropertyAccessMode(PropertyAccessMode.Field);
}`

The above code tells EF Core to access the Entries property through its field, which it finds because I’m following a standard naming convention. With this in place, the Guestbook entity is persisted just as if it had a List<GuestbookEntry> property, but now it exposes a single interface for adding new entries, so behavior tied to this activity will be consistent throughout the application.

[Learn more about this feature from Arthur Vickers’ article](https://blog.oneunicorn.com/2016/10/28/collection-navigation-properties-and-fields-in-ef-core-1-1/#comment-14597) on the subject.