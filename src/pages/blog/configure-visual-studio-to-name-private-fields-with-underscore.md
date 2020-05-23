---
templateKey: blog-post
title: Configure Visual Studio to Name Private Fields with Underscore
date: 2019-08-20
path: /configure-visual-studio-to-name-private-fields-with-underscore
featuredpost: false
featuredimage: /img/configure-visual-studio-name-private-fields-underscore.png
tags:
  - clean code
  - dependency injection
  - refactoring
  - visual studio
category:
  - Software Development
comments: true
share: true
---

Most C# coding standards recommend using camelCase for local variables and \_camelCase for private or internal (and I also say for protected, but that's just me) fields. Unfortunately, out of the box Visual Studio just uses camelCase for these fields, which makes typical dependency injection scenarios annoying in constructors:

```
// ctor
public SomeClass(ISomeService someService)
{
    this.someService = someService; // annoying same name format usage
}
```

I much prefer this version:

```
// ctor
public SomeClass(ISomeService someService)
{
    _someService = someService; // obvious intent; no need for 'this'
}
```

Fortunately, you can modify Visual Studio to do the right thing pretty easily, albeit not in a hugely discoverable manner (it's a bit buried in the options). Here's how to find what you need:

1. Click on Tools in the menu.
2. Click on Options.
3. Click on Text Editor.
4. Click on C#.
5. Click on Code Style.
6. Click on Naming.
7. Click on Manage naming styles.

Still with me? Now you should see a Naming Style dialog. Specify the following (see image below):

- Naming Style: \_fieldName
- Required Prefix: \_
- Capitalization: camel Case Name

If you did it right your Sample Identifier will be **\_exampleIdentifier**.

![](/img/image-underscore.png)

Naming Style dialog in Visual Studio 2019 C# Code Style - Naming - Manage naming styles.

Once you have this in place, you're almost done. Now click the green plus (+) sign to add a new specification and choose the following from the 3 dropdown lists:

- Private or Internal Fields
- \_fieldName
- Suggestion

Your final list should look something like this:

![Thumbnail](https://uploads.disquscdn.com//img/e8a022cdd60fe0e542e3868a1c2cc388fed2fa6acb4d92673da24dbff065ad6d.png?w=800&h=136)

Now if you use the extremely common refactoring of assigning a constructor parameter to a newly initialized field, Visual Studio will name it using the \_fieldName naming rule:

![](/img/image-3-underscore.png)

Visual Studio 2019 Refactoring to Create and initialize field \_fieldName.

Thanks to [this StackOverflow answer](https://stackoverflow.com/a/52603580/13729) which has helped me (and several clients) out with this a few times. Posting here so I'm sure to be able to find it again in the future, and to help readers like you!

You can also achieve this using a [.editorconfig file](https://github.com/StevenTCramer/EditorConfig). An example of this can be found in the [Roslyn codebase](https://github.com/dotnet/roslyn/blob/master/.editorconfig#L106-L114) (thanks, [Rhodri](https://ardalis.com/configure-visual-studio-to-name-private-fields-with-underscore#comment-4586486298)!):

```
# Instance fields are camelCase and start with _
dotnet_naming_rule.instance_fields_should_be_camel_case.severity = suggestion
dotnet_naming_rule.instance_fields_should_be_camel_case.symbols = instance_fields
dotnet_naming_rule.instance_fields_should_be_camel_case.style = instance_field_style

dotnet_naming_symbols.instance_fields.applicable_kinds = field

dotnet_naming_style.instance_field_style.capitalization = camel_case
dotnet_naming_style.instance_field_style.required_prefix = _
```
