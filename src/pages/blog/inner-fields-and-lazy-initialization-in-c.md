---
templateKey: blog-post
title: Inner Fields and Lazy Initialization in C#
path: blog-post
date: 2011-10-29T04:48:00.000Z
description: "Using lazy initialization in C#, a class’s state is set up such
  that each property’s get method performs a check to see if the underlying
  field is null. "
featuredpost: false
featuredimage: /img/csharp-760x360.png
tags:
  - C#
category:
  - Software Development
comments: true
share: true
---
Using lazy initialization in C#, a class’s state is set up such that each property’s get method performs a check to see if the underlying field is null. If it is, then it calculates or populates the field before returning it. This is a very simple and common approach, but it requires that the class follows a convention of only accessing the field via the property. Unfortunately, there are no language features that can enforce this, so it’s possible for errors to creep in. Here’s an example of this approach working correctly:

```
<span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> Order

{

    <span style="color: #008000">// other properties</span>


    <span style="color: #0000ff">private</span> Customer _customer;

    <span style="color: #0000ff">public</span> Customer Customer

    {

        get

        {

            <span style="color: #0000ff">if</span> (_customer == <span style="color: #0000ff">null</span>)

            {

                _customer = <span style="color: #0000ff">new</span> Customer();

            }

            <span style="color: #0000ff">return</span> _customer;

        }

    }


    <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> PrintLabel()

    {

        <span style="color: #0000ff">return</span> Customer.CompanyName + <span style="color: #006080">"n"</span> + Customer.Address;

    }

}
```

Now here’s where this approach can break down. Consider the same class as above, but with a rewritten PrintLabel() method:

```
<span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> PrintLabel()
{
  <span style="color: #0000ff">return</span> _customer.CompanyName + <span style="color: #006080">"n"</span> + _customer.Address;

}
```

This code will still compile just fine, but now will very likely result in a NullReferenceException when it attempts to access properties of the _customer, which may not yet be initialized. The solution to this would be to control access to the _customer member. We’ve already set its access to*private*, though, which is as restrictive as we can make it. We could force it to be initialized by moving the work into the class’s constructor, but then we’re losing the benefits of lazy initialization. I wonder if it wouldn’t be useful to do something like this instead:

```
<span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> Order

{

    <span style="color: #008000">// other properties</span>


    <span style="color: #0000ff">private</span> Customer _customer;

    <span style="color: #0000ff">public</span> Customer Customer

    {
     get

        {
          <span style="color: #0000ff">if</span> (_customer == <span style="color: #0000ff">null</span>)

            {

                _customer = <span style="color: #0000ff">new</span> Customer();
          }

            <span style="color: #0000ff">return</span> _customer;
       }

    }


    <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> PrintLabel()


    {

        <span style="color: #0000ff">string</span> result = _customer.CompanyName; <span style="color: #008000">// probably results in a NullReferenceException</span>

        <span style="color: #0000ff">return</span> result + <span style="color: #006080">"n"</span> + Customer.Address; <span style="color: #008000">// ok to access Customer</span>

    }

}
```

We already have auto-properties in C# that avoid the need for having backing fields in the default case. I think being able to protect access to backing fields so that they can be configured to only be accessible by their property would be quite useful in a number of cases, including this very common one. I also don’t believe this would break any existing code or change the language in a way that would make it less easy to understand. What do you think, is this something the C# team should consider adding in a future version of the language?

One approach that can be used with the relatively new Lazy<T> type is this one (thanks to Jose Romanie for pointing this out):

```
<span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> Order
{

    <span style="color: #0000ff">public</span> Order()

   {
      _customerInitializer = <span style="color: #0000ff">new</span> Lazy&lt;Customer&gt;(() =&gt; <span style="color: #0000ff">new</span> Customer());

    }

    <span style="color: #008000">// other properties</span>

    <span style="color: #0000ff">private</span> Lazy&lt;Customer&gt; _customerInitializer;

    <span style="color: #0000ff">public</span> Customer Customer

    {


      get

        {
         <span style="color: #0000ff">return</span> _customerInitializer.Value;

        }

    }

    <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> PrintLabel()

    {


        <span style="color: #0000ff">string</span> result = Customer.CompanyName; <span style="color: #008000">// ok to access Customer</span>

        <span style="color: #0000ff">return</span> result + <span style="color: #006080">"n"</span> + _customerInitializer.Value.Address; <span style="color: #008000">// ok to access via .Value</span>

    }

}
```

I like this approach, and I’m generally a fan of Lazy<T>. It might eliminate the need for the private backing field idea for properties, as it does provide a means of enforcing the initialization even if the backing field is accessed from within the class. The only downside is that you need to work with a Lazy<T> instead of a T, but within the class it’s probably not a bad thing for this detail to be exposed. Thoughts?