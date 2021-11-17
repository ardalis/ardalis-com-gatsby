---
templateKey: blog-post
title: Avoid Using Exceptions to Determine API Status Codes and Responses
date: 2021-11-16
description: It's typical for API endpoints to call application or domain services. In the case of success, the API can simply return Ok and the result of the service call. But for non-success cases, should you use exceptions to communicate from the service to the endpoint, so that it can return an appropriate status code and response?
path: blog-post
featuredpost: false
featuredimage: /img/avoid-using-exceptions-determine-api-status.png
tags:
  - software development
  - apis
  - web apis
  - asp.net
  - asp.net core
category:
  - Software Development
  - Productivity
comments: true
share: true
---

It's typical for API endpoints to call application or domain services. In the case of success, the API can simply return Ok and the result of the service call. But for non-success cases, should you use exceptions to communicate from the service to the endpoint, so that it can return an appropriate status code and response?

Assuming you read the title of this article, you probably already know the answer I'm going to give. But first let's look at a (bad) example. Consider the following method found in a service that will be called by an [API endpoint](https://github.com/ardalis/ApiEndpoints) (controller action):

```csharp
public IEnumerable<WeatherForecast> GetForecast(ForecastRequestDto model)
{
  // hard-coded not found case
  if (model.PostalCode == "NotFound") throw new ForecastNotFoundException();

  // validate model
  if (model.PostalCode.Length > 10)
  {
    throw new ForecastRequestInvalidException(new Dictionary<string, string>()
    {
      { nameof(model.PostalCode), "PostalCode cannot exceed 10 characters." }
    });
  }

  var result = // get the result here
  return result;
}
```

This method might then be called in an action method / endpoint using try-catch logic to determine what response should be returned, like so:

```csharp
[HttpPost("Create")]
public async Task<ActionResult<IEnumerable<WeatherForecast>>> CreateForecast([FromBody] ForecastRequestDto model)
{
  _logger.LogInformation($"Starting {nameof(CreateForecast)}");
  try
  {
    var result = await _weatherService.GetForecastAsync(model);
    return Ok(result);
  }
  catch (ForecastNotFoundException ex) // avoid using exceptions for control flow
  {
    return NotFound();
  }
  catch (ForecastRequestInvalidException ex) // avoid using exceptions for control flow
  {
    var dict = new ModelStateDictionary();
    foreach(var key in ex.ValidationErrors.Keys)
    {
        dict.AddModelError(key, ex.ValidationErrors[key]);
    }
    return BadRequest(dict);
  }
  finally
  {
    _logger.LogInformation($"Starting {nameof(CreateForecast)}");
  }
}
```

So, what's the problem with this approach?

## Why Not Use Exceptions for Flow Control

First, it violates a well-accepted principle in C# (and similar languages like Java), which suggests that you should avoid using exceptions for flow control. There are many good reasons for not using exceptions for flow control, many of which are covered in this Stack Overflow exchange, [Why not use exceptions as regular flow of control](https://stackoverflow.com/questions/729379/why-not-use-exceptions-as-regular-flow-of-control). Some excerpts:

> If you use exceptions for normal situations, how will you locate things that are *really* exception?

Debugging with "break on all exceptions" stops working if the program uses exceptions all over the place for "normal" flow.

> Exceptions violate the principle of least astonishment and make programs hard to read.

> Throwing exceptions is one of the most expensive operations in .NET

> If the error is a common one (e.g. user tried to log in with wrong password), use return values

> Use return values for input validation

> You can use a hammer's claw to turn a screw, just like you can use exceptions for control flow. That doesn't mean it is the intended usage of the feature. The if statement expresses conditions, whose intended usage is controlling flow.

Ok, so *in general* you should avoid using exceptions for control flow. But why is it bad in the case of the service shown above?

The consumer of the service is forced to be much more complex because of the way in which the control flow was implemented. Non-exceptional cases like simple input validation problems or cases where a resource wasn't found are being treated like things that should never occur in a healthy-running system. There are performance impacts in addition to tons of repetition across actions/endpoints if every one is structured using this same approach.

So, what other options are there? How *could* we make this work?

## Practice Thinking about Various Ways to Achieve a Design Goal

Too often I see developers myopically choosing some a poor or suboptimal approach to a design because it's the most convenient, or it's their [golden hammer](https://deviq.com/antipatterns/golden-hammer), or it's "the it's always been done here". Sometimes if you stop for a moment and try to consider all the ways you might alternately be able to achieve the same outcome, you may be surprised by what you find.

First, what is our desired outcome? Defining that explicitly can go a long way toward helping us identify potential solutions. What do we need?

> A method that either returns a (created) instance, or informs the caller why it couldn't do so.

This is the basic requirement for the functionality we require. And none of this behavior is *exceptional* - it's the expected behavior of the method under normal conditions.

In our case, there are 3 possible results of calling the method:

1. Success. It returns an instance of the expected type.
1. Validation failure. It returns a list of validation problems and some indication that validation failed.
1. Required resource not found. The instance could not be created because it or some dependency it has could not be found.

How can we achieve this in C# code?

### Exceptions

See above. Throw exceptions for the non-success paths, otherwise return the instance. We've covered why this probably isn't the best option.

If you already have a lot of code using the try-catch approach in every action/endpoint, one incremental improvement you can make is to refactor the exceptions to use common base types for each expected case (NotFound, Invalid, etc.). Then create an Exception Filter that has the try-catch logic in it, using the base types, and returning the appropriate NotFound or BadRequest result. You can add this globally when you set up MVC in your app's services and it should clean up your actions substantially. I'd still seek to avoid using exceptions for expected behavior and consequent control flow, but it may be good enough for some.

### Conventions

You could use a convention based on the return type. For instance, you could assume that if it returns null, the associated resource wasn't found. This would work for some cases of resource lookups, but wouldn't help with handling validation errors.

### out Params

You could structure the method so that it had one or more `out` params representing non-success (or success) cases. For instance, you could return a `bool` representing success and use out params for the actual value as well as not found and validation errors. Calling the method might look like this:

```csharp
// note C# 7 lets you declare inline
var success = await _weatherService.GetForecastAsync(model, out IEnumerable<WeatherForecast> result, out bool notFound, out Dictionary<string,string> validationErrors);

if(success) return result;
if(notFound) return NotFound();
if(validationErrors.Keys.Any())
{
  var dict = new ModelStateDictionary();
  foreach(var key in ex.ValidationErrors.Keys)
  {
    dict.AddModelError(key, ex.ValidationErrors[key]);
  }
  return BadRequest(dict);
}
```

### Return an MVC type

You could just have your service return the actual `ActionResult` types that your controller action will ultimately return. At that point your service is tightly coupled to MVC types, though, and your controller action probably isn't doing anything at that point aside from returning the service. I prefer to follow [separation of concerns](https://deviq.com/principles/separation-of-concerns), and the specific HTTP responses an API might return are a UI concern and a responsibility of the API endpoint, not the service.

### Use callbacks

You could take a page from JavaScript and have the method use OnSuccess and OnError callbacks. You'll find an example of [using delegates and callbacks in a C# method in this Stack Overflow answer](https://stackoverflow.com/a/45602027/13729). Generally it's not recommended in C# apps, but it would provide another possible approach.

### Return a Result type

In C# when your type doesn't communicate everything you need, your go-to solution should typically be to use another type. For instance, we could return a `ForecastListResult` that might look like this:

```csharp
public class ForecastListResult
{
  public IEnumerable<WeatherForecast> Forecasts { get; } = null;
  public ResultStatus Status { get; private set; };
  public Dictionary<string,string> ValidationErrors { get; } = new();
  
  public ForecastListResult(IEnumerable<WeatherForecast> successResult)
  {
    Forecasts = successResult;
    Status = ResultStatus.Success;
  }

  public ForecastListResult(Dictionary<string,string> validationErrors)
  {
    ValidationErrors = validationErrors;
    Status = ResultStatus.InvalidRequest;
  }

  private ForecastListResult()
  {
    Status = ResultStatus.NotFound;
  }

  public static ForecastListResult NotFound() => new FoecastListResult();  
}
```

It should be easy to see how the original service method could be adjusted to return either a success result, a set of validation errors, or a not found result. In this example the three possible statuses are represented by an enum (not shown).

The biggest problem with this approach is that you end up having to write a lot of code to get there. Once you have the above `Result` type, it works well and does a good job of communicating intent. The calling code also gets a lot simpler because it can just use standard `if` conditionals to handle the `NotFound()` and `BadRequest()` cases.

Looking more at this solution, you might notice that there's not really anything in the `ForecastListResult` class that's specific to a `ForecastList`. If you were to create additional `FooResult` types for other resources, you would probably find that they were very similar with the exception of the `Forecasts` property. This is a perfect case for [using generics in C#](https://www.pluralsight.com/courses/working-c-sharp-generics-best-practices). You can replace any specific `FooResult` type with a generic `Result<T>` where `T` is the type of a successful response.

I have an open source package available on NuGet, [Ardalis.Result](https://www.nuget.org/packages/Ardalis.Result/), which does just this. You can see an example of how it works here. Of course, once you have a common abstraction for these kinds of results, you can also get rid of all of the conditional logic in your actions/endpoints, replacing them with extension methods or filters. These are included in [a separate NuGet package since they're optional and coupled with ASP.NET Core](https://www.nuget.org/packages/Ardalis.Result.AspNetCore/).

An example of using an extension method would look like this:

```csharp
[HttpPost("/Forecast/New")]
public override ActionResult<IEnumerable<WeatherForecast>> Handle(ForecastRequestDto request)
{
  return this.ToActionResult(_weatherService.GetForecast(request));

  // alternately
  // return _weatherService.GetForecast(request).ToActionResult(this);
}
```

Doing the same thing with a filter would look like this:

```csharp
/// <summary>
/// This uses a filter to convert an Ardalis.Result return type to an ActionResult.
/// This filter could be used per controller or globally!
/// </summary>
/// <param name="model"></param>
/// <returns></returns>
[TranslateResultToActionResult]
[HttpPost("Create")]
public Result<IEnumerable<WeatherForecast>> CreateForecast([FromBody] ForecastRequestDto model)
{
    return _weatherService.GetForecast(model);
}
```

Note that in the case of the filter (`[TranslateResultToActionResult]`) the actual return type of the action is `Result<T>` not an `ActionResult<T>`. The filter handles the translation.

You'll find [the source for the filter and the associated extensions methods on GitHub](https://github.com/ardalis/Result/tree/main/src/Ardalis.Result.AspNetCore).

## Summary

There are probably more options than the ones I listed above. The one I've had the best success with is the generic Result pattern. Using this pattern works in the vast majority of cases, produces clear code, and keeps logic to a minimum in controllers while allowing standard API policies to be employed globally.

What's your preferred strategy for dealing with non-exceptional results of services and translating these into appropriate HTTP responses in your ASP.NET Core apps? Leave a comment below or post on twitter and be mention @ardalis and this article.
