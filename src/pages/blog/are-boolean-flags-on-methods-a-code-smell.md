---
templateKey: blog-post
title: Are Boolean Flags on Methods a Code Smell?
date: 2020-04-15
path: /are-boolean-flags-on-methods-a-code-smell
featuredpost: false
featuredimage: /img/are-boolean-flags-on-methods-a-code-smell.png
tags:
  - .net
  - C#
  - clean code
  - code smell
  - refactoring
  - visual studio
category:
  - Software Development
comments: true
share: true
---

Recently I had one of my [newsletter](/tips) subscribers ask me a question about whether it was a good practice to use a boolean parameter to alter the behavior of a method. Martin Fowler describes (many of\*) these as [Flag Arguments](https://martinfowler.com/bliki/FlagArgument.html). The topic is also covered in [this StackExchange question](https://softwareengineering.stackexchange.com/questions/147977/is-it-wrong-to-use-a-boolean-parameter-to-determine-behavior). [Clean Code](https://amzn.to/3bc18tJ) also discusses it. On a slightly related note, the [Flags Over Objects antipattern](https://deviq.com/flags-over-objects/) describes this same problem but as object properties rather than function parameters.

\*Sometimes an argument can be made that a bool being passed into a function isn't itself a flag that modifies its behavior, but instead is part of the state that is set by or passed on by the function.

The usual argument against using a flag argument is that it results in messier function code, couples different concerns, and is harder to understand and maintain. Let's look at some examples real quick, in pseudo code.

```csharp
public void Render(Data data, bool successLoading)
{
    // display header

    // if (successLoading)

        // loop over data and display

    // else

        // display error
  
    // display footer
}
```

In the above example, which is similar to one [described here](https://medium.com/@amlcurran/clean-code-the-curse-of-a-boolean-parameter-c237a830b7a3), the render method is responsible for knowing about whether the data was loaded successfully, and thus the method is more complex. It has common logic - the header and footer - as well as unique logic to run depending on whether the data is there. Often how we deal with errors is a cross-cutting concern, but here this behavior is hard-coded inside of this method, making it more difficult to generalize. Also, what if other modifications in behavior are required? How does this approach scale as new requirements come in? Maybe the error details we wish to display vary based on whether the user is a developer and the environment is development (not production). How does the method look then?

```csharp
public void Render(Data data, bool successLoading, bool isUserDeveloper, bool isDevelopmentEnvironment)
{
// display header

// if (successLoading)

    // loop over data and display

// else
    if (isUserDeveloper && isDevelopmentEnvironment)
        // display detailed error info
    else
        // display error

// display footer
}
```

The complexity of the code grows, often dramatically, as we add additional flags to it. One boolean offers 2 possibilities, while three can have 8 different combinations.

The question I was asked related to a calculation method:

> Hi steve,  
> Lets say i have an existing  method calculate( int a, int b)  
> which calculates a value based on unique formula which involves a and b and some constants C1 and C2. 
> Now if i get a new requirement that for this particular case the Calculate(a,b) method must use another formula which involves a, b and some constants C1 and C5. Is it ok if i refactor it like this   
> Calculate( int a, int b, bool newFormula)  
> where the bool newFormula will decide if it should use the old formula or new formula)  
> or do you think overloading with a bool like this is a bad idea.

I obviously have no idea what the method is calculating, but let's just make something up. Let's say it's for GamerRank which is calculated based on wins and losses and some constants C1 and C2:

```csharp
public double CalculateGamerRank(int wins, int losses)
{
    return (wins+C1) / (losses+C2);
}
```

Ok, so this works great for our basic needs, but we need a different way of ranking gamers during tournaments, so we could do something like this:

```csharp
public double CalculateGamerRank(int wins, int losses, bool isTournament)
{
    if(isTournament)
        return wins+C1 / (wins + losses + C5);
    
    return (wins+C1) / (losses +C2);
}
```

(ignore the fact that these formulas make no sense)

So, the question: is this "overload" of the method a good design, or is there a better way?

If I saw this code during a code review, I probably wouldn't think too much about it. It's pretty simple, it's easy to follow, it's probably fine. But that's in large part because the whole thing is just a single conditional with two possibilities, each of which is just one line of code. If the two blocks were each long enough that you needed to scroll to see them all, I'd be much more likely to say this needs to be refactored.

Flag arguments are a kind of code smell. I talk about these at length in my [refactoring fundamentals](https://www.pluralsight.com/courses/refactoring-fundamentals) course on Pluralsight, as well as in its revised (but much shorter) version, [Refactoring for C# Developers](https://www.pluralsight.com/courses/refactoring-csharp-developers). Code smells are not always _problems_, but they do indicate areas in your code that stand out and deserve some investigation (to see if, in fact, they are problems). In the above example, depending on the complexity and length of the two blocks, I might decide whether it was worth refactoring to split it up, for instance.

There are another couple of principles to keep in mind when thinking about whether the presence of this code smell is worth refactoring. The first is the [Single Responsibility Principle](https://www.pluralsight.com/courses/csharp-solid-principles). If you can easily see that the function is doing different things based on the flag, and these things are likely to change at different times for different reasons, then you're violating SRP and should think about refactoring. The other principle is called [Tell, Don't Ask](https://deviq.com/tell-dont-ask/). Rather than having the method ask, either directly or indirectly, for the flag to determine what its behavior should be, you can just call the appropriate (dedicated, focused, well-named) method in the first place.

Assuming I wanted to refactor this approach, what are the options?

The simplest refactoring if it were quite long would be to take each side of the if statement and Extract Method on it. You'd end up with something that reduced to what you see above - two single line statements, one for each side of the conditional. A benefit of this refactoring is that you would also need to come up with good names for the different conditional behaviors. You might end up with something like this:

```csharp
if (isTournament)
    return CalculateTournamentGamerRank(wins,losses);
return CalculateNormalGamerRank(wins,losses);
```

Once you have this, you might look at your calling code and think about inlining this method. Let's look at another reason why boolean flags are a code smell - what they look like from calling code - and then we'll come back to the inlining idea.

The calling code might look something like this:

```csharp
var score = CalculateGamerRank(wins, losses, false);
```

If you're new to this codebase and are working in this code, you don't have much choice but to investigate what that false parameter is doing there. By itself it doesn't tell you anything. In some languages (including C# since version 4), you can use named arguments to make this more clear:

```csharp
var score = CalculateGamerRank(wins, losses, isTournament: false);
```

But this is optional and tends to make calls to functions much longer. In practice I only rarely see them used.

The reverse refactoring of Extract Method is Inline Method. You do this when a method doesn't really add any value, and its contents can simply be put into the location where the method is called. Once we've turned CalculateGamerRank into a single if statement that either calls CalculateNormalGamerRank or CalculateTournamentGamerRank, it should be obvious that we can simply call the appropriate specific method directly rather than going through the generic one with the flag.

It's certainly more readable in client code to see:

```csharp
var rank = CalculateNormalGamerRank(wins, losses);
// than
var rank = CalculateGamerRank(wins, losses, false);
```

## Summary

Flags tend to be code smells that, like a lot of technical debt, start out small and innocuous but then grow over time. They add conditional complexity at the expense of simplicity and clarity. It's easy to tolerate them when things are simple but as soon as they start to grow out of hand you should consider refactoring to alleviate the problems they cause. I describe a host of refactoring techniques and other code smells in [my several Pluralsight courses on refactoring](https://www.pluralsight.com/authors/steve-smith), which are all free this month.
