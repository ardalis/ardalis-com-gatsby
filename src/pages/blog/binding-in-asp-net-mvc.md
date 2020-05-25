---
templateKey: blog-post
title: Binding in ASP.NET MVC
path: blog-post
date: 2009-06-10T05:56:00.000Z
description: "At my ASP.NET MVC + SOLID Principles talk in Cleveland last night,
  I had a couple of questions about binding in ASP.NET MVC. For instance:"
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - ASP.NET MVC
category:
  - Uncategorized
comments: true
share: true
---
At my ASP.NET MVC + SOLID Principles talk in Cleveland last night, I had a couple of questions about binding in ASP.NET MVC. For instance:

![](/img/asp-net.jpg)

* Can you still do something like <%= Bind(“Foo”) %> in your form?
* How does the controller that receives a POST get back the Model that was used in the form that was posted?
* Does it have to be serializable?
* What if I need to bind custom types to my Model class?
* Doesn’t having the Model referenced in the View eliminate the need for the Controller?

I answered these last night but I thought they were common enough as a theme that they deserved their own answers here as well.

**Does ASP.NET MVC Support Two Way Binding via the Bind() Syntax?**

No, not directly. Rather, you can use HTML Helpers to create your UI (if you like – you can also just hand code the HTML if that’s your preference – ASP.NET MVC is all about you being in control), and then use either the built-in or a custom ModelBinder to convert the POSTed data into your class/Model. More on ModelBinders below. The HTML helper syntax might look like this:

```
&lt;%= Html.TextBox(<span style="color: #006080">&quot;Title&quot;</span>, Model.Title) %&gt;
```

If you don’t like the “magic string” used in this, you might look at [Eric Hexter’s Input Builders project](http://www.lostechies.com/blogs/hex/archive/2009/06/09/opinionated-input-builders-for-asp-net-mvc-using-partials-part-i.aspx).



**How does the controller that handles the POST get back the Model?**

In my example last night, I had some code that looked like this (except it used a blog not a customer):

```
[AcceptVerbs(HttpVerbs.Post)]
<span style="color: #0000ff">public</span> ActionResult Create(Customer customer)
{
   <span style="color: #008000">// work with Customer here</span>
}
```

This kind of looks like it’s using Magic, because nowhere am I having to deal with Request.Form\[“CustomerName”] or CustomerTextBox.CustomerName as I would typically need to do. It raises the question for some as to whether there is some kind of passing around of the serialized model (Customer) between the client and the server. In fact this is not the case. All that is happening here is standard HTTP, doing a POST, with the fields that were specified in the <form> on the client. If our form had an <intput type=”text” name=”CustomerName” /> then the POST would include the CustomerName field and whatever value was stored in the TextBox.

The “magic” takes place in the form of a ModelBinder. ModelBinders are responsible for the fairly common task of converting between a collection of Form values and a strongly typed Model class that should be created from these values. First, let’s look at the equivalent code that doesn’t use a ModelBinder. If I wanted to create my customer object more explicitly in the controller, I could do it like this:

```
[AcceptVerbs(HttpVerbs.Post)]
<span style="color: #0000ff">public</span> ActionResult Create(FormCollection formValues)
{
  var customer = <span style="color: #0000ff">new</span> Customer();
  customer.FirstName = Request.Form[<span style="color: #006080">&quot;FirstName&quot;</span>];
  customer.LastName = Request.Form[<span style="color: #006080">&quot;LastName&quot;</span>];
}
```

This gets old fast. A better method that is one step closer to the ModelBinder approach would be:

```
[AcceptVerbs(HttpVerbs.Post)]
<span style="color: #0000ff">public</span> ActionResult Create(FormCollection formValues)
{
  var customer = <span style="color: #0000ff">new</span> Customer();
  UpdateModel(customer);
}
```

This helper method automatically updates the properties of the object we pass into it with the values from incoming form parameters (using reflection to match up the property names with the form names). If we want to avoid dealing directly with the FormCollection in our controller, we can simply use the original signature I showed above, and have the controller take in as its parameter the model object (Customer in this case) that we want to have populated from the form.

If there are problems with the population of the model object, the **ModelState.IsValid** property will be false, and the ModelState will include details about the rule violations (such as a type mismatch). You can find more detail on this [here](http://nerddinnerbook.s3.amazonaws.com/Part5.htm).



**Does the Model used for a controller that handles a POST need to be serializable?**

No, it simply needs to have properties that can be mapped to the fields coming in from the POST. The class itself is never serialized or deserialized or sent over the wire. It’s simply mapped from the POSTed fields by a ModelBinder.



**What if I need to bind custom types to my Model class?**

In this case, you’ll want to write your own ModelBinder and register it so that ASP.NET MVC knows to use it when faced with a given type in your application. Writing a ModelBinder simply requires that you inherit from **DefaultModelBinder** and override the ConvertType() method. In order to register your type with its custom ModelBinder, you would do this:



```
<span style="color: #008000">// In Global.asax Application Start or an HttpModule</span>
ModelBinders.Binders.Add(<span style="color: #0000ff">typeof</span>(Customer), <span style="color: #0000ff">new</span> CustomerBinder());
```

Here is a[good example of writing a custom ModelBinder class](http://www.singingeels.com/Articles/Model_Binders_in_ASPNET_MVC.aspx).



**Doesn’t having the Model referenced in the View eliminate the need for the Controller?**

In response to seeing code in the View like this:

```
&lt;%= ViewData.Model.FirstName %&gt;
```

Someone asked if this was stepping on the responsibilities of the Controller, since the View was talking directly to the Model. Here there can be differing opinions. It’s not strictly required that you pass your Model classes to the View. You can simply pass in collections of strings via ViewData. Another common approach is to use a **DTO**(Data Transfer Object) or **ViewModel** (the “VM” in the MVVM palindrome pattern) which typically is a subset of one or more Model classes in your application that contains only the information necessary for a given View. It’s also not uncommon to pass your Model into the View. It’s a matter of preference and there are pros and cons to these approaches.

What is not recommended is for your Model (the Customer in my example here, which has a FirstName property) to be persistence aware and to magically go and fetch itself from the database when it is referenced by the View. The above code should only work if the Controller has explicitly passed in the Model to the View, using code like this:

```
<span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> View(<span style="color: #0000ff">int</span> id)
{
  Customer customer = customerRepository.GetCustomer(id);
  <span style="color: #0000ff">return</span> View(customer);
}
```

It is still the responsibility of the Controller to pass in whatever data the view needs. The view should not have this responsibility. Nor should the model know how to persist itself. This [separation of concerns](http://en.wikipedia.org/wiki/Separation_of_concerns) ensures loose coupling, testability, and a more flexible design.

An example of using a ViewModel/DTO would be something like this:

```
<span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> CustomerSummaryViewModel
{
  <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> FirstName { get; set; }
  <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> LastName { get; set; }
  <span style="color: #0000ff">public</span> DateTime DateOfLastPurchase { get; set; }
  publi DateTiem AmountOfLastPurchase { get; set; }
}
...
<span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> Summary(<span style="color: #0000ff">int</span> id)
{
  Customer customer = customerRepository.GetCustomer(id);
  Order order = orderRepository.List(id).Take(1); <span style="color: #008000">// gets most recent order</span>
  var summary = <span style="color: #0000ff">new</span> CustomerSummaryViewModel() {
    FirstName = customer.FirstName,
    LastName = customer.LastName,
    DateOfLastPurchase = order.DatePurchased,
    AmountOfLastPurchase = order.Amount };
&#160;
  <span style="color: #0000ff">return</span> View(summary);
}
```

Using this approach, the View will have access only to the exact pieces of data that it requires, and no more. If you want to ensure that the View never calls methods on your Model objects or you want to verify with tests that your View is receiving exactly the data that it needs, then using this ViewModel/DTO approach can be valuable.