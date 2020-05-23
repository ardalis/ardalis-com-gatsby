---
templateKey: blog-post
title: Refactoring Static Config Access
path: blog-post
date: 2016-08-03T05:47:00.000Z
description: "A common but insidious dependency in many .NET applications is
  their use of configuration, including appSettings. "
featuredpost: false
featuredimage: /img/configuration.png
tags:
  - clean code
  - code smell
  - configuration
  - dependencies
  - refactoring
  - solid
  - static cling
category:
  - Software Development
comments: true
share: true
---
A common but [insidious dependency](http://ardalis.com/insidious-dependencies) in many .NET applications is their use of configuration, including appSettings. The main issue is static access to config for values that affect the behavior of the application (values that are simply displayed, or used for things like email servers or addresses, aren’t usually an issue). Imagine you have some code like this:

`public class CheckoutService {
    public void AnalyzeCustomer()
    {
        bool useGeolocation = false;
        bool.TryParse(ConfigurationManager.AppSettings["UseGeolocation"], out useGeolocation);
        if (useGeolocation)
        {
            // call geolocation service
        }

        // do other stuff
    }
}`

Imagine this method is used to gather information about a customer before accepting their order. One option that may or may not be configured for the product is to use a geolocation service. If it’s enabled in configuration, it should be called (and its results should be used by the method); otherwise it should be ignored. Now suppose you’d like to be able to test that this method behaves correctly, for both possible settings of the useGeolocation value (and it would probably be good to test that it works correctly when the value isn’t set, too). This is difficult because test projects, while they can have an app.config file, they can only have one such file. So if your test project defines the UseGeolocation value in its app.config, that’s the value all of your tests will use. The static access to configuration settings is an example of the [static cling anti-pattern](http://deviq.com/static-cling/) (or code smell).

To be able to refactor away from this design, allowing for better testability, the first step is to replace the static configuration access with an interface:

`public interface ICheckoutConfig {
    bool UseGeolocation { get; }
}`

Next, implement the interface with the default behavior, which is to read it from configuration. It’s fine to have the static access in this instance type, since the interface provides a means of replacing the implementation for client code that uses it.

`public class CheckoutConfig : ICheckoutConfig {
    static CheckoutConfig()
    {
        bool.TryParse(ConfigurationManager.AppSettings["UseGeolocation"], out _useGeolocation);
    }
    private static bool _useGeolocation;
    public bool UseGeolocation
    {
        get { return _useGeolocation; }
    }
}`

In this case, I’m only reading the value the first time and storing it in a static field, and then returning the static field from the property.

Now, in the original code, you can replace access to configuration with use of the interface and its property:

`public class CheckoutService {
    private readonly ICheckoutConfig _config;

    public CheckoutService(ICheckoutConfig config)
    {
        _config = config;
    }

    public void AnalyzeCustomer()
    {
        if (_config.UseGeolocation)
        {
            // call geolocation service
        }

        // do other stuff
    }
}`

At this point, writing tests that ensure CheckoutService does the right thing based on configured settings is trivial – simply pass in a new instance of an ICheckoutConfig (using a fake or a mock) with the appropriate value set. You can also, separately, test that the CheckoutConfig class does the right thing. In addition to making the code more testable, the low-level “how do I safely read a value from a configuration file, cast it, and do the right thing when it’s not there” logic is no longer in the CheckoutService type. It can remain at a higher level of abstraction, and be more focused on its problem domain (rather than plumbing code). I cover the static cling code smell, and many others, in my [Refactoring Fundamentals](https://www.pluralsight.com/courses/refactoring-fundamentals) course, if you’re interested in learning more about ways to improve your code and eliminate [technical debt](http://deviq.com/technical-debt/).