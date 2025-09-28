---
title: Improve Tests with the Builder Pattern for Test Data
date: "2018-02-02T00:00:00.0000000"
featuredImage: /img/improve-tests-with-the-builder-pattern-for-test-data.png
---

Note: **UPDATED: October 2022**

I recently wrote about an example where I was able to apply the [Builder Design Pattern](http://deviq.com/builder-design-pattern/) to an [Angular/TypeScript service](https://ardalis.com/applying-the-builder-pattern-to-improve-an-angular-service). Another area where I've been finding the pattern helpful is in unit tests. Last year, I learned about this technique from [Kenneth Truyers' blog post](https://www.kenneth-truyers.net/2013/07/15/flexible-and-expressive-unit-tests-with-the-builder-pattern/), and I've been using it to good effect for several months now on a few different projects. Check out his article for a good introduction - below I'll describe my own experience applying the pattern.

## The Problem

The problem in this case was that an app I was working on and testing had a bunch of fairly large entities that needed to be validated. The validations ranged from complex business rules to simple "required" checks. Address was a common one, which was validated at the Web API level by ASP.NET Core model validation. There tests to confirm that if any given property were null, the API would respond with the appropriate error message. But since many entities had addresses, there were many different API endpoints that had this logic, along with other behavior associated with addresses, so that the test code had a lot of instantiations of test addresses, like this one:

```csharp
_addressDto = new AddressDTO
{
 Description ="Test Address",
 AttentionTo ="Steve Smith",
 Line1 ="123 Main Street",
 Line2 =",
 Line3 =",
 City ="Gotham City",
 State ="OH",
 Country ="US",
 ZipCode ="43210"
};
```

Why is this a problem? First, you want to follow the [DRY principle](http://deviq.com/don-t-repeat-yourself/) even in your test code, to reduce technical debt (and total size of the code). This especially means being careful with how many places you're instantiating types you're testing (or testing with). The more duplication you have in this area, the more expensive it will be (in terms of time and effort) for a change to be made to the type you're instantiating. In the simplest case, you should replace many instance of 'new' with a helper method like GetTestAddress(). However, if you need to have more fine-grained control over the instance, the Builder Pattern can be helpful.

In this particular case, since the DTO is not encapsulated at all, it's easy to modify the instance in each test, like this:

```csharp
[Fact]
public async Task ReturnBadRequestOnStateValidationFailure()
{
 _addressDto.State =";
 await AssertBadRequestOnPost(_address);
}
```

Note that the repetitive code involved in POSTing the address to the web API has been encapsulated into a method as well, further reducing repetition in these tests (I'm [building out some helpers for this here](https://www.nuget.org/packages/Ardalis.HttpClientTestExtensions/)). However, it's not always that easy, especially with well-designed entities, to modify types post-creation. And in any case, every test file related to addresses will have to have 10+ lines of code dedicated to setting up the test Address/AddressDTO instance.

## One Approach - Static Helpers

Instead of the builder pattern, you can just go with a static helper method, like this:

```csharp
public static class TestDataHelpers
{
 public static GetTestAddress()
 {
 return new AddressDTO
 {
 Description ="Test Address",
 AttentionTo ="Steve Smith",
 Line1 ="123 Main Street",
 Line2 =",
 Line3 =",
 City ="Gotham City",
 State ="OH",
 Country ="US",
 ZipCode ="43210"
 };
 }
}
```

This is definitely an improvement, and may be all that's necessary in many scenarios. However, I find that I prefer in most cases the flexibility of having this kind of default (static) constructor combined with a Builder type.

## The Unit Test Data Builder Pattern

One reason why I preferred the builder pattern in this particular application was that there were many different entities that often needed to have one or more (unique) addresses associated with them. I didn't want to have to create several different hard-coded GetTestAddress() methods, or to have to call the one method several times and then manipulate the resulting instances. I wanted something simple, reusable, and easy to follow and the builder pattern seemed an elegant approach.

Here's an example of an AddressDTOBuilder:

```csharp
public class AddressDTOBuilder
{
 private AddressDTO _entity = new AddressDTO(); // expedient but a bit hacky

 public AddressDTOBuilder WithId(int id)
 {
 _entity.Id = id;
 return this;
 }

 public AddressDTOBuilder WithLine1(string line1)
 {
 _entity.Line1 = line1;
 return this;
 }

 public AddressDTOBuilder WithLine2(string line2)
 {
 _entity.Line2 = line2;
 return this;
 }

 public AddressDTOBuilder WithLine3(string line3)
 {
 _entity.Line3 = line3;
 return this;
 }

 public AddressDTOBuilder WithAttentionTo(string attn)
 {
 _entity.AttentionTo = attn;
 return this;
 }

 // more methods omitted

 public AddressDTO Build()
 {
 return _entity;
 }

 // This approach allows easy modification of test values
 // Another approach would just have a static method returning AddressDTO
 public AddressDTOBuilder WithTestValues()
 {
 _entity = new AddressDTO
 {
 Line1 ="12345 Test Street",
 Line2 ="3rd Floor",
 Line3 ="Suite 300",
 AttentionTo ="Test Person",
 City ="Test City",
 State ="OH",
 ZipCode ="43210",
 Country ="US",
 Description ="Test Description",
 Id = Constants.TEST_ADDRESS_ID
 }
 return this;
 }
}
```

With this builder in place, and once the test code has been refactored to use it consistently, the only place AddressDTO is instantiated is inside the AddressDTOBuilder class. Thus, any future changes to AddressDTO and how it's constructed should primarily only impact AddressDTOBuilder, not dozens of test method implementations.

**NOTE:** This implementation is not a *pure* builder implementation, because it instantiates the AddressDTO in a field when the builder is created. This works fine for DTOs, generally, but if you have a restricted constructor you'll want to use the more proper (but more code) builder pattern approach shown later in this article. Also, note that you shouldn't reuse builder instances since trying to build a second instance will typically just give you the same instance again. For most unit tests, you only need one instance, so this all works fine.

Working with the builder looks like this (note separate builder instance per type being created):

```csharp
_testAddress = new AddressDTOBuilder()
.WithTestValues()
.WithId(TEST\_ADDRESS\_ID1)
.Build();
_testAddress2 = new AddressDTOBuilder()
.WithTestValues()
.WithId(TEST\_ADDRESS\_ID2)
.WithLine1("A Different Test Street")
.WithCity("Columbus")
.WithZipCode("43200")
.WithDescription("Another test Address")
.Build();
```

Starting with the `WithTestValues()` method ensures that the instance will be fully instantiated, but you can still override any properties you need to for a particular test scenario. **Common values like entity IDs used in tests should be defined using constants, and ideally should be unique across all types, so that you don't accidentally have a test pass despite using the wrong entity ID (but when the wrong ID coincidentally has a valid value, so your test doesn't catch the issue).** This means, don't have three different IDs in a test (customer, product, order IDs for example) and set each one to `1`. [Make every value of every ID unique in each unit test](https://ardalis.com/never-use-the-same-value-for-two-ids-or-other-values-in-your-tests/).

**Update August 2018**

I've created a coding sample and kata to help you practice using the Builder pattern. [Fork or clone this repository](https://github.com/ardalis/BuilderTestSample) and write tests using the Builder pattern for the features described by TODO comments in the OrderService.cs file. Once you've gone through this exercise and you're comfortable creating and using Builders yourself, check out [Autofixture](https://autofixture.github.io/docs/fixture-creation/#), a free open source tool you can use that will provide most of this functionality for you without the need for you to hand write builder classes yourself.

**Update January 2021**

I've updated the naming convention here to reflect one I've been using for a while, which is to have every property-setting method on the builder be named `With{PropertyName}`.

**Update October 2022**

## Using a Proper Builder Pattern

The builder code shown above works but has some caveats noted above. It's a little bit of a hack. If you want to properly apply the pattern, you should store the various values needed for the instance to be created, and only actually instantiate the type in the Build method using these stored values. This has several benefits:

- Parameterized constructors are properly supported
- A single builder instance can be used to build multiple separate instances
- Instantiation (new) only occurs in one place (above it's also done in WithTestValues)

Imagine you need to build a Customer instance, but customers have the following constraints:

- Customer must have an int ID > 0
- Customer must have a non-null Address

To enforce these rules, you have the following code:

```csharp
public class Address {} // details not important

public class Customer
{
 public Customer(int id, Address homeAddress)
 {
 if(id <= 0) throw new ArgumentException(nameof(id),"id must be positive");
 if(homeAddress is null) throw new ArgumentNullException(nameof(homeAddress),"homeAddress is required");
 Id = id;
 HomeAddress = homeAddress;
 }

 public int Id {get; private set;}
 public Address HomeAddress {get; private set;}
 // other methods omitted
}
```

Ok, so if we wanted to use our hacky builder pattern from above, we'd just have something like this:

```csharp
public class CustomerBuilder
{
 private Customer _entity = new Customer(); // doesn't compile

 public CustomerBuilder WithId(int id)
 {
 _entity.Id = id; // doesn't compile
 return this;
 }
}
```

However, because of business logic and proper encapsulation (which entities should have and DTOs should not), we can no longer use the shortcut approach. We need to write a fair bit more code to do it properly. Specifically, we're not going to have a field representing the created entity. Instead, we're going to have fields to store the values that will be used when the entity is created in the Build method.

```csharp
public class CustomerBuilder
{
 public const int TEST_CUSTOMER_ID = 123; // builder can also store test values

 private int _id;
 private Address _homeAddress;

 public CustomerBuilder WithId(int id)
 {
 _id = id;
 }

 public CustomerBuilder WithHomeAddress(Address homeAddress)
 {
 _homeAddress = homeAddress;
 }

 public Customer Build()
 {
 return new Customer(_id, _homeAddress);
 }

 public CustomerBuilder WithTestValues()
 {
 _id = TEST_CUSTOMER_ID; // use a constant
 _homeAddress = new Address(); // can use an AddressBuilder here to get one with TestValues
 }
}
```

Now if you want to use this, it looks like this:

```csharp
public class TestClass
{
 private CustomerBuilder _customerBuilder = new();

 public void SomeTest()
 {
 var customer1 = _customerBuilder
.WithTestValues()
.Build();
 var customer2 = _customerBuilder
.WithTestValues()
.WithId(999)
.Build();

 Assert.NotSame(customer1,customer2);
 }
}
```

## Summary

Even in your tests - *especially* in your tests - remember [new is glue](/new-is-glue). The more places you have new in your test code, the most places you're going to need to touch any time you modify a constructor to take in a dependency or restrict how that type can be created. Since constructors play a huge role in performing proper encapsulation in OO designs, you don't want to add friction that makes it harder to modify them. By keeping your use of **new** to a minimum in your tests (and ideally in your production code as well), you make it easier to modify your types' constructors whenever the design's needs require it. The Builder design pattern is a great way to make creating types more intuitive, easier to read later (the interface is very clear), and less repetitive.

