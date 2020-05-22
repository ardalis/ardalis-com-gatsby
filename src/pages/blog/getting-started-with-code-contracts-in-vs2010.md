---
templateKey: blog-post
title: Getting Started with Code Contracts in VS2010
path: blog-post
date: 2010-08-17T12:57:00.000Z
description: The idea of [Design By Contract] has been around for quite a while,
  and Microsoft Research has had a project focused on this topic for several
  years now, called [Spec#.]
featuredpost: false
featuredimage: /img/snaghtml85dce90_thumb.png
tags:
  - code contracts
  - visual studio
category:
  - Software Development
comments: true
share: true
---
The idea of [Design By Contract](http://en.wikipedia.org/wiki/Design_by_contract) has been around for quite a while, and Microsoft Research has had a project focused on this topic for several years now, called [Spec#.](http://research.microsoft.com/en-us/projects/specsharp) With Visual Studio 2010, there is now support for Code Contracts which are a DevLabs project based on the Spec# project. You can [read more about and download Code Contracts for VS2010 here](http://msdn.microsoft.com/en-us/devlabs/dd491992.aspx).

Once you’ve downloaded and installed Code Contracts, you’ll have a new tab in your VS2010 projects:

![](/img/snaghtml85dce90_thumb.png)

With the Code Contracts installed, you can start to use them in your code in place of things like guard clauses to ensure that a parameter is not null. The benefit of this approach is that you get a richer experience at design/development time and you can also ensure, via compilation errors, that certain things simply cannot occur in your application.

Code Contracts uses the notion of PreCondition and PostCondition (among other things) to define what a method expects, and what it claims will be the state of things once it has completed. As a simple example, consider this method that formats a Customer object and returns a string:

```
public class TextRenderer
{    
    public string RenderCustomer(Customer customer)    
    {        
        Contract.Requires(customer != null, "customer must not be null");
        return String.Format("{0} - {1}", customer.FirstName, customer.LastName);     }
}
```

Note the first line of the method is using Code Contracts (found in System.Diagnostics.Contracts) to state the requirement that the Customer parameter not be null. With my current settings, this requirement doesn’t cause a compilation error, so I’m able to still build and run my tests that demonstrate that I expect a NullReferenceException from such behavior:

```
[TestClass]
public class TextRendererShould
{
    [TestMethod]
    public void RenderCustomerWithName()
    {
        var customer = new Customer() { 
                 FirstName = "Steve", 
                 LastName = "Smith" };
        var renderer = new TextRenderer();
        var result = renderer.RenderCustomer(customer);
        Assert.AreEqual("Steve - Smith", result);
    }

    [TestMethod]
    [ExpectedException(typeof(NullReferenceException))]
    public void BlowUpWithNull()
    {
        var renderer = new TextRenderer();
        var result = renderer.RenderCustomer(null);
        Assert.AreEqual("Steve - Smith", result);
    }
}
```

However, in Visual Studio since I’ve set the project to show squigglies for contract violations, I do see this:

![](/img/customer-render.png)

These same warnings are also present in the compiler output, and of course we can choose to treat warnings as errors if we want the build to fail when these rules are violated:

![](/img/code-constraints.png)

Code Contracts are pretty easy to get started with, and there is support for VS2008 as well as VS2010 so even if you don’t have the latest Visual Studio you may want to check them out. The documentation is pretty good, too. [Read the User Doc PDF](http://download.microsoft.com/download/C/2/7/C2715F76-F56C-4D37-9231-EF8076B7EC13/userdoc.pdf)to see more examples of how to get started with Code Contracts to improve the quality of your code today.