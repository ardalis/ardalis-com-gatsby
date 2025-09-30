---
title: Abstract to Privileges rather than to Roles in ASP.NET Applications
date: "2010-12-14T00:00:00.0000000"
description: It's very common to check whether the current requesting user is in a particular role in order to determine whether they are authorized to do or see something within an ASP.NET application. This approach can break down over time as the number of roles and business rules for determining authorization increase. By creating an abstraction for privileges, this issue can be easily managed.
featuredImage: /img/privileges-not-roles.png
---

## The Problem

If you've written much ASP.NET code since 2005, you've probably used the built-in role provider, or rolled your own, and written code that checks whether the current user belongs to a particular role. For instance, for an article site like ASPAlliance.com, you might choose to show an Edit link to editors with some code like this:

```csharp
if(currentUser.IsInRole(Roles.Editor))
{
 editLink.Visible = true;
}
```

Of course, it might also be true that authors should be able to edit their own articles, too.

```csharp
if(currentUser.IsInRole(Roles.Editor) ||
 (currentUser.IsInRole(Roles.Author) && article.AuthorId = new Author(currentUser.userId).Id))
{
 editLink.Visible = true;
}
```

Oh, but we don't want authors to be able to edit content once it's been published, only while it's still in draft or submitted status.

```csharp
if(currentUser.IsInRole(Roles.Editor) ||
 (currentUser.IsInRole(Roles.Author) &&
 article.AuthorId = new Author(currentUser.userId).Id &&
 article.Status!= ArticleStatus.Approved &&
 article.Status!= ArticleStatus.Published))
{
 editLink.Visible = true;
}
```

Now of course, this link goes to some page like EditArticle.aspx, and that page is going to also need to ensure that only authorized users can access it. Otherwise, even though the Edit link might not be visible to unauthorized users on the article page, a clever user might construct the link on their own and still gain access to the edit page. So in your Page_Load or similar you would end up doing another big ugly if check to see if the current user is authorized to edit the article. And at this point the code is extremely ugly and already starting to duplicate itself in your system - it's starting to smell. The [Don't Repeat Yourself principle](https://deviq.com/principles/dont-repeat-yourself) bears following, and you can combat repetition in your logic with abstraction.

## The Solution

Represent the notion of access to a particular operation as a Privilege. For example, in this case we want to be able to say whether the current user is authorized to edit a particular article. That's all that's involved here. So we need an abstraction that allows us to refer to a user, an article, and a place to store the logic to say whether or not the operation is authorized. Something like this:

```csharp
public abstract class Privilege<T>
{
 public abstract bool AuthorizedToEdit(T item, User user);
}
public class ArticlePrivilege: Privilege<Article>
{
 public override bool AuthorizedToEdit(Article item, User user)
 {
 if(user.IsInRole(Roles.Editor)) return true;
 if(user.IsInRole(Roles.Author))
 {
 return UserIsArticleAuthor(item,user) && ArticleNotSubmitted(item);
 }
 return false;
}
 // implement UserIsArticleAuthor() and ArticleNotSubmitted() here
}
```

Now within our page, if we want to determine whether the user is authorized to edit the article, we simply create a new privilege object and check its AuthorizedToEdit() method. This could easily be made into an extension method on User, Article, or both, if desired for convenience.

```csharp
var articlePrivilege = new ArticlePrivilege();
if(articlePrivilege.AuthorizedToEdit(article, currentUser))
{
 editLink.Visible = true;
}
```

## Conclusion

You can read more about this approach and download sample code from my related blog post on this subject, [Favor Privileges over Role Checks](https://ardalis.com/favor-privileges-over-role-checks/). You can [follow me on BlueSky](https://bsky.app/profile/ardalis.com) or subscribe to my blog feed to be notified about additional articles and discussions on related topics.

Originally published on [ASPAlliance.com](http://aspalliance.com/2031_Abstract_to_Privileges_rather_than_to_Roles_in_ASPNET_Applications)

