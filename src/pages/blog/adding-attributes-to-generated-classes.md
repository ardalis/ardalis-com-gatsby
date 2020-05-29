---
templateKey: blog-post
title: Adding Attributes to Generated Classes
path: blog-post
date: 2010-04-16T08:56:00.000Z
description: ASP.NET MVC 2 adds support for data annotations, implemented via
  attributes on your model classes. Depending on your design, you may be using
  an OR/M tool like Entity Framework or LINQ-to-SQL to generate your entity
  classes, and you may further be using these entities directly as your Model.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - ASP.NET
category:
  - Uncategorized
comments: true
share: true
---
ASP.NET MVC 2 adds support for data annotations, implemented via attributes on your model classes. Depending on your design, you may be using an OR/M tool like Entity Framework or LINQ-to-SQL to generate your entity classes, and you may further be using these entities directly as your Model. This is fairly common, and alleviates the need to do mapping between POCO domain objects and such entities (though there are certainly pros and cons to using such entities directly).

As an example, the current version of the [NerdDinner](http://nerddinner.com/) application (available on CodePlex at [nerddinner.codeplex.com](http://nerddinner.codeplex.com/)) uses Entity Framework for its model. Thus, there is a NerdDinner.edmx file in the project, and a generated NerdDinner.Models.Dinner class. Fortunately, these generated classes are marked as partial, so you can extend their behavior via your own partial class in a separate file. However, if for instance the generated Dinner class has a property Title of type string, you can’t then add your own Title of type string for the purpose of adding data annotations to it, like this:

```csharp
public partial class Dinner
{
    [Required]
    public string Title { get; set; }
}
```

This will result in a compilation error, because the generated Dinner class already contains a definition of Title. How then can we add attributes to this generated code? Do we need to go into the T4 template and add a special case that says if we’re generated a Dinner class and it has a Title property, add this attribute? Ick.

**Metadata Type to the Rescue**

The Metadata Type attribute can be used to define a type which contains attributes (metadata) for a given class. It is applied to the class you want to add metadata to (Dinner), and it refers to a totally separate class to which you’re free to add whatever methods and properties you like. Using this attribute, our partial Dinner class might look like this:

```csharp
[MetadataType(typeof(Dinner_Validation))]
public partial class Dinner
{}

public class Dinner_Validation
{
    [Required]
    public string Title { get; set; }
}
```

In this case the Dinner_Validation class is public, but if you were concerned about muddying your API with such classes, it could instead have been created as a private class within Dinner. Having the validation attributes specified in their own class (with no other responsibilities) complies with the Single Responsibility Principle and makes it easy for you to test that the validation rules you expect are in place via these annotations/attributes.

Thanks to [Julie Lerman](http://thedatafarm.com/blog) for her help with this. Right after she showed me how to do this, I realized it was also [already being done in the project I was working on](http://nerddinner.codeplex.com/sourcecontrol/network/Show?projectName=nerddinner&changeSetId=46831#439965).