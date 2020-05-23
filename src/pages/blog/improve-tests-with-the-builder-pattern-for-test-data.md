---
templateKey: blog-post
title: Improve Tests with the Builder Pattern for Test Data
date: 2018-02-02
path: blog-post
featuredpost: false
featuredimage: /img/improve-tests-with-the-builder-pattern-for-test-data.png
tags:
  - design patterns
  - patterns
  - testing
category:
  - Software Development
comments: true
share: true
---

I recently wrote about an example where I was able to apply the [Builder Design Pattern](http://deviq.com/builder-design-pattern/) to an [Angular/TypeScript service](https://ardalis.com/applying-the-builder-pattern-to-improve-an-angular-service). Another area where I've been finding the pattern helpful is in unit tests. Last year, I learned about this technique from [Kenneth Truyers' blog post](https://www.kenneth-truyers.net/2013/07/15/flexible-and-expressive-unit-tests-with-the-builder-pattern/), and I've been using it to good effect for several months now on a few different projects. Check out his article for a good introduction - below I'll describe my own experience applying the pattern.

## The Problem

The problem in this case was that an app I was working on and testing had a bunch of fairly large entities that needed to be validated. The validations ranged from complex business rules to simple "required" checks. Address was a common one, which was validated at the Web API level by ASP.NET Core model validation. There tests to confirm that if any given property were null, the API would respond with the appropriate error message. But since many entities had addresses, there were many different API endpoints that had this logic, along with other behavior associated with addresses, so that the test code had a lot of instantiations of test addresses, like this one:

\_addressDto = new AddressDTO
{
    Description = "Test Address",
    AttentionTo = "Steve Smith",
    Line1 = "123 Main Street",
    Line2 = "",
    Line3 = "",
    City = "Gotham City",
    State = "OH",
    Country = "US",
    ZipCode = "43210"
};

Why is this a problem? First, you want to follow the [DRY principle](http://deviq.com/don-t-repeat-yourself/) even in your test code, to reduce technical debt (and total size of the code). This especially means being careful with how many places you're instantiating types you're testing (or testing with). The more duplication you have in this area, the more expensive it will be (in terms of time and effort) for a change to be made to the type you're instantiating. In the simplest case, you should replace many instance of 'new' with a helper method like GetTestAddress(). However, if you need to have more fine-grained control over the instance, the Builder Pattern can be helpful.

In this particular case, since the DTO is not encapsulated at all, it's easy to modify the instance in each test, like this:

\[Fact\]
public async Task ReturnBadRequestOnStateValidationFailure()
{
  \_addressDto.State = "";
  await AssertBadRequestOnPost(\_address);
}

Note that the repetitive code involved in POSTing the address to the web API has been encapsulated into a method as well, further reducing repetition in these tests. However, it's not always that easy, especially with well-designed entities, to modify types post-creation. And in any case, every test file related to addresses will have to have 10+ lines of code dedicated to setting up the test Address/AddresDTO instance.

## One Approach - Static Helpers

Instead of the builder pattern, you can just go with a static helper method, like this:

public static class TestDataHelpers
{
  public static GetTestAddress()
  {
    return new AddressDTO
    {
      Description = "Test Address",
      AttentionTo = "Steve Smith",
      Line1 = "123 Main Street",
      Line2 = "",
      Line3 = "",
      City = "Gotham City",
      State = "OH",
      Country = "US",
      ZipCode = "43210"
    };
  }
}

This is definitely an improvement, and may be all that's necessary in many scenarios. However, I find that I prefer in most cases the flexibility of having this kind of default (static) constructor combined with a Builder type.

## The Unit Test Data Builder Pattern

One reason why I preferred the builder pattern in this particular application was that there were many different entities that often needed to have one or more (unique) addresses associated with them. I didn't want to have to create several different hard-coded GetTestAddress() methods, or to have to call the one method several times and then manipulate the resulting instances. I wanted something simple, reusable, and easy to follow and the builder pattern seemed an elegant approach.

Here's an example of an AddressBuilder:

public class AddressDTOBuilder
{
    private AddressDTO \_entity = new Address;
    public AddressBuilder Id(int id)
    {
        \_entity.Id = id;
        return this;
    }

    public AddressBuilder Line1(string line1)
    {
        \_entity.Line1 = line1;
        return this;
    }

    public AddressBuilder Line2(string line2)
    {
        \_entity.Line2 = line2;
        return this;
    }

    public AddressBuilder Line3(string line3)
    {
        \_entity.Line3 = line3;
        return this;
    }

    public AddressBuilder AttentionTo(string attn)
    {
        \_entity.AttentionTo = attn;
        return this;
    }

    // more methods omitted

    public AddressDTO Build()
    {
        return \_entity;
    }

    // This approach allows easy modification of test values
    // Another approach would just have a static method returning AddressDTO
    public AddressBuilder WithTestValues()
    {
        \_entity = new AddressDTO
        {
            Line1 = "12345 Test Street",
            Line2 = "3rd Floor",
            Line3 = "Suite 300",
            AttentionTo = "Test Person",
            City = "Test City",
            State = "OH",
            ZipCode = "43210",
            Country = "US",
            Description = "Test Description",
            Id = Constants.TEST\_ADDRESS\_ID
        }
        return this;
    }
}

With this builder in place, and once the test code has been refactored to use it consistently, the only place AddressDTO is instantiated is inside the AddressDTOBuilder class. Thus, any future changes to AddressDTO and how it's constructed should primarily only impact AddressDTOBuilder, not dozens of test method implementations.

Working with the builder looks like this:

\_testAddress = new AddressDTOBuilder()
    .WithTestValues()
    .Id(TEST\_ADDRESS\_ID1)
    .Build();
\_testAddress2 = new AddressDTOBuilder()
    .WithTestValues()
    .Id(TEST\_ADDRESS\_ID2)
    .Line1("A Different Test Street")
    .City("Columbus")
    .ZipCode("43200")
    .Description("Another test Address")
    .Build();

Starting with the WithTestValues() method ensures that the instance will be fully instantiated, but you can still override any properties you need to for a particular test scenario. Common values like entity IDs used in tests should be defined using constants, and ideally should be unique across all types, so that you don't accidentally have a test pass despite using the wrong entity ID (but when the wrong ID coincidentally has a valid value, so your test doesn't catch the issue).

**Update August 2018**

I've created a coding sample and kata to help you practice using the Builder pattern. [Fork or clone this repository](https://github.com/ardalis/BuilderTestSample) and write tests using the Builder pattern for the features described by TODO comments in the OrderService.cs file.
