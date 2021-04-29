---
templateKey: blog-post
title: Represent Behavior with Classes not Flags
date: 2011-11-11
path: blog-post
description: When designing your software systems, favor the use of classes to model behavior within the system over the overuse of flags in your data model. The resulting design will be more flexible, less tightly coupled, and easier to maintain.
featuredpost: false
featuredimage: /img/represent-behavior-with-classes.png
tags:
  - Architecture
category:
  - Productivity
  - Software Development
comments: true
share: true
---


In any non-trivial software applications, there will be different kinds of behavior attributed to different kinds of objects.  For instance, maybe a discount is only applied to some products, but not others.  Or a validation rule is applied in most cases, but not for this particular class of item.  Perhaps an email-sending application should perform some checks to insure it has certain elements set, but which elements are required depends on the email template in use.  In all of these cases, the temptation from the data-centric perspective is to deal with the problem through the use of flags in the data model (read: database schema).  If you go this route, you can often end up with a big set of flags or ***TypeId columns in your schema, and then anywhere in your code where the behavior needs to vary based on these differences, you end up with branching logic.  The result, over time, is a convoluted mess of if-then or switch statements that makes it very difficult to sort out the actual behavior of a given type of model object in your design, not to mention that any new kinds of behavior may result in additional flags on your tables until you have a bunch of flags that only ever make sense in certain magical combinations.

## An Example

The solution to this problem is to put the behavior you’re trying to model where it belongs – in code.  Consider these business rules and the designs that apply to them for validation purposes.  Each item in question is a particular kind of email publication.

1. A *Newsletter* that includes the Editor’s Comments must have Editor’s Comments in order to be valid for sending.
2. A *Newsletter* or *News* mailing that is tailored to the recipient’s preferences should not send to a recipient if it includes nothing they are interested in.
3. A *Special Offer* mailing should not be sent if it doesn’t include an advertisement (as this is its sole content).
4. The *Acme Newsletter* should never be sent unless it includes at least one advertisement.
5. The *Special Offer* mailing should email the admin a warning if they have no ads 24 hours before they are scheduled to go out.
6. All mailings except for *Special Offers* and the *Acme Newsletter* should email the admin a warning if they have no content 24 hours before they are scheduled to go out.

## Using Flags in the Database

Now consider this model for the database schema that would model this behavior:

![table](/img/represent-behavior-with-classes-db-table.png)

If we adopt this design, then we have 5 flags we need to set for every publication, and then we need to check them in our code.  So, if we have some code that decides whether to send out the emails for this particular publication, we might do a check like this:

```csharp
public bool ShouldSend(Publication publication)
{
  if(publication.RequiresEditorCommentsToSend &&
   String.IsNullOrEmpty(publication.EditorComments)
  {
    return false;
  }
  if(publication.RequiresContentToSend &&
     !publication.Content.Any())
  {
    return false;
  }
  if(publication.RequiresAdsToSend() &&
    !publication.Ads.Any())
  {
    return false;
  }
}
```

This isn’t *too* awful, but then you start adding in weird combinations of conditions, like a publication that can send as long as it contains either content or ads.  How do you model that?  Add another bit flag for RequiresContentOrAdsToSend and then ignore the other two flags?  And how is this design taking advantage of the fact that you’re using an object-oriented programming language?  The issues with sending warnings are similar and grow worse as the real-world complexity creeps into your model.  Sometimes you can deal with this complexity using the approach shown here, and sometimes (often better) you can eliminate this complexity at its source by simplifying your business rules.  But other times that’s outside of your control, and your task is to build the system to model the rules, not the other way around.

## Using Classes and OOP

What about this schema?

![table](/img/represent-behavior-with-classes-db-simple-table.png)

Now imagine that we create a simple interface for our publications, like this one:

```csharp
public interface IPublicationBehavior
{
  bool ShouldSend();
  bool ShouldWarn()
}
```

We can implement this class easily enough like so:

```csharp
public class SpecialOfferPublicationBehavior : IPublicationBehavior
{
  private Publication _publication;
  public SpecialOfferPublicationBehavior(Publication publication)
  {
    _publication = publication;
  }
 
  public bool ShouldSend()
  {
    return _publication.Ads().Any();
  }
 
  public bool ShouldWarn()
  {
    return !ShouldSend();
  }
}
```

Note that this behavior doesn’t include anything that the Special Offer publication doesn’t care about, like Editor Comments.  It is focused purely on the issues of concern to the Special Offer publication type.  Alternately we could have used inheritance, but this design favors composition over inheritance and is more flexible, as well as being less likely to lead to a [Single Responsibility Principle](https://deviq.com/principles/single-responsibility-principle) violation.  But how do we link the actual Publication object with this particular type, and how do we store the type in the database?

The answer is to use an IOC container or simply write our own reflection-based code.  For the user-interface where we edit the the Behavior Model of the publication, we would have a DropDownList populated with all of the types (or a FriendlyName property supported by the type, if you prefer).  You can generate such a list using pure reflection with code [like this](http://stackoverflow.com/questions/26733/getting-all-types-that-implement-an-interface-with-c-sharp-3-5):

```csharp
var type = typeof(IMyInteraface);
var types = AppDomain.CurrentDomain.GetAssemblies().ToList()
    .SelectMany(s => s.GetTypes())
    .Where(p => type.IsAssignableFrom(p));
```

If you’re using an IOC Container like StructureMap, you can do the same kind of thing like this:

```csharp
// Create a Friendly Name interface
public interface IHaveFriendlyName
{
    string FriendlyName { get; } 
}
 
// List the friendly names of all instances of interface
StructureMap.ObjectFactory.Container.GetAllInstances<IPublicationBehavior>()
  .Select(r => r.FriendlyName).ToList();
 
// Instantiate a type via its Friendly Name
public static T ResolveByFriendlyName<T>(string friendlyName) 
  where T : IHaveFriendlyName
{
    var list = ObjectFactory.Container.GetAllInstances<T>();
    var obj = list.Where(l => l.FriendlyName == friendlyName).FirstOrDefault();
    if (obj == null)
    {
        throw new ApplicationException("No instance found with friendly name " 
+ friendlyName);
    }
    return obj;
}
```

## Summary

By keeping behavior in classes rather than trying to model it through flags and conditionals, we’re able to achieve a more flexible, simpler design that is easier to maintain as the design evolves and additional behaviors are required.  It’s much easier to decouple and test such an application, and much easier to maintain and debug it as well.

Originally published on [ASPAlliance.com](http://aspalliance.com/2087_Represent_Behavior_with_Classes_not_Flags)
