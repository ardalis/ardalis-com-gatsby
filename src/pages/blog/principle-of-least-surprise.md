---
templateKey: blog-post
title: Principle of Least Surprise
path: blog-post
date: 2009-07-08T23:52:00.000Z
description: When developing software, and especially when building user
  interfaces, it’s a good idea not to surprise the end user. This is known as
  the Principle of Least Surprise (or Astonishment if you want to go for maximum
  drama). It may seem obvious, but in practice it’s often easier said than done.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - advertisement
category:
  - Uncategorized
comments: true
share: true
---
When developing software, and especially when building user interfaces, it’s a good idea not to surprise the end user. This is known as the [Principle of Least Surprise](http://en.wikipedia.org/wiki/Principle_of_least_astonishment) (or Astonishment if you want to go for maximum drama). It may seem obvious, but in practice it’s often easier said than done. This is why user interfaces are often difficult to work with, especially if they’re built according to how the programmers think about the system with no input from actual users.

For example, in a data entry scenario where some data entered could cause an inconsistency with other data in the system, there are several options one might consider. To make this more concrete, let’s say that you can have an ad campaign spanning some time period, and within this you have individual advertisements, each with its own time period. There is an overall business rule that the campaign time period defines the ultimate boundaries of the advertisements’ periods (start and end dates).

Now, on form where the user can edit the campaign’s dates, you have to decide what to do if they change a date such that advertisements’ dates are now out of bounds. For example, the campaign’s start date was 15 July 09 and its end date was 15 August 09, and within it is an advertisement**A**that runs from 15 July 09 to 15 August 09 and another advertisement**B**that runs from 20 July 09 to 27 July 09. The user needs to update the campaign so that it starts on 16 July 09.

Some options:

1. Always set all advertisements’ dates to the new campaign dates
2. Throw a validation error and do not allow the user to save dates that would cause the advertisements’ dates to be invalid
3. Warn the user that advertisement dates are now out of range, and let them click a button to adjust them to be the new campaign dates.
4. Do nothing – let the new dates be set.
5. Allow the update to go through but set a status flag on the campaign to show that it is now in an invalid state (and hope the user corrects this)
6. Same as 5, but the update isn’t actually saved, but rather the campaign and advertisements are saved to a sandbox while their state is invalid, and the user is made aware that until the business rules are met, the whole campaign cannot be saved. The user can continue editing the sandboxed version of the campaign and its advertisements until the dates meet the criteria, and then the whole batch can be saved as one transactional unit of work.

There are certainly other options as well, but these are a good start for analysis purposes.

The first option is the simplest, and ensures that no invalid state can exist from changing campaign dates, because the advertisement dates will always be reset to match the campaign dates. However, unless the user expects this to be the behavior, they’re very likely going to be surprised to find out that when they thought they were editing campaign settings they were in fact editing all of the advertisements’ settings as well. And in this case, advertisement B which clearly was meant to run for a particular 7-day period within the campaign will now have its date range reset to match the full campaign length, which is almost certainly not what the user expects.

Option 2 is good from a PoLS standpoint, because the system doesn’t do anything that the user wasn’t expecting. Unfortunately, the system doesn’t do anything useful, either. If the user really wants to reset the campaign dates, they’re going to be stumped as to how to do it, and eventually might figure out that they need to edit each individual advertisement’s start date before they’ll be allowed to edit the campaign’s start date. Hardly a good user experience, but at least the system has protected them from causing the system to enter an invalid state.

Option 3 is excellent from a PoLS standpoint, because it informs the user of the possible issue but still lets the user accomplish the task they’ve set out to do. And it offers the them a time-saving option to set the dates on the advertisements to match the campaign, which is probably often what the user wants to do, but unlike in option 1 this behavior is now explicit and thus will not come as a surprise to the user or occur when they don’t wish it to.

Option 4 doesn’t immediately surprise the user, but is really one of the worst options because of its insidious nature. Allowing the data to become inconsistent will surprise the user at a later date if they were expecting the system to ensure that the business rules were being maintained. At some future date, when it’s discovered that the dates of the advertisements fall outside the dates of the campaign, and some unexpected system behavior results, the user is going to be puzzled as to how this could have been allowed to happen. PoLS failure.

Option 5 alone is quite reasonable from a PoLS standpoint, but could still allow inconsistent data to be saved into the production system, with the same ultimate consequences as Option 4.

Option 6 seems like the best solution. The user is made aware of the issues but is allowed to continue to make changes to the whole system (campaign + advertisements in this case) until they are in a consistent, valid state. Only then can the changes be committed to the production data store. This is an example of the[Unit of Work pattern](http://www.martinfowler.com/eaaCatalog/unitOfWork.html), and unlike most web-based applications that commit work with each request, this might require the transaction to be maintained across multiple requests before ultimately being committed to the database. No magic happens behind the scenes that the user didn’t expect, and no future consequences occur that the user doesn’t expect, either. And, bonus!, the user can actually get their job done unlike option 2 which is the usual naive approach to trying to prevent the user from hurting themselves.

A related acronym to the PoLS is [Do What I Mean](http://en.wikipedia.org/wiki/DWIM) (DWIM), which describes users’ feelings when the program they’re using does exactly what they told it to, according to its specification, but not what the user expected. The best user interfaces ensure that the user is always able to find what they need where they expect it, and when they issue commands they do what the user meant for them to do.

As a developer, even when you’re not working on user interfaces, remember that the Principle of Least Surprise (and DWIM) apply to every class and every method you create. Expecially if you’re writing a framework or an API! Try to avoid unexpected side effects in your methods, and if they must be there, ensure that the method name makes clear that they’re happening. If MarkOrderAsCancelled() also deletes all of the OrderDetail records, consider renaming it to something like CancelOrderAndDeleteDetails(), for example. And if a class has [insidious dependencies](/insidious-dependencies), try to make this more apparent by injecting them via the constructor so users of the class are explicitly aware of them. Writing software that intuitively does what’s expected, from the UI down to the individual methods, is seriously challenging but is something we as software developers should strive for every day.