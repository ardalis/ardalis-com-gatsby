---
templateKey: blog-post
title: Logging Method Counts and Durations
path: blog-post
date: 2016-03-31T11:49:00.000Z
description: "Remember the rules of optimization: Don’t do it! Don’t do it, yet.
  Avoid premature optmization. Profile before optimizing."
featuredpost: false
featuredimage: /img/countloggeroutput.jpg
tags:
  - diagnostics
  - logging
  - optimization
  - performance
  - tuning
category:
  - Software Development
comments: true
share: true
---
Remember the [rules of optimization](http://c2.com/cgi/wiki?RulesOfOptimization):

* Don’t do it!
* Don’t do it, *yet*. Avoid premature optmization.
* Profile before optimizing

So, assuming you believe some optimization is warranted and you want to identify where it makes sense to do so, the important thing is to profile the current performance behavior of the application before you make any attempts at optimizing it. There are many tools available that can do this profiling, including Visual Studio, but if you are unable or unwilling to use a tool, you can add your own profiling code fairly easily.

Because I’ve had to do this more than a few times, I’ve created a small library that will keep track of method calls, counts, and total elapsed time. You can grab the code from my[Ardalis.Logging GitHub repository](https://github.com/ardalis/Logging). Eventually the library will include additional logging-related utilities, but for now it includes a CountLogger class that tracks method heuristics.

The simplest way to use the library is to wrap the code you’re trying to count in a using statement, like so:

```
public static bool IsDivisibleBy(int candidate, int divisor) {
    using (new CountLogger.DisposableStopwatch(nameof(IsDivisibleBy), CountLogger.AddDuration))
    {
        return candidate % divisor == 0;
    }
}
```

Alternately, you can wrap your code in a try…finally block:

```
public bool IsPrimeOptimized(int number) {
    var timer = Stopwatch.StartNew();
    try
    {
        if (number < 2) return false;
        for (int i = 2; i <= Math.Sqrt(number); i++)
        {
            if (IsDivisibleBy(number, i)) return false;
        }
        return true;
    }
    finally
    {
        timer.Stop();
        CountLogger.AddDuration(nameof(IsPrimeOptimized), timer.ElapsedMilliseconds);
    }
}
```

In either case, the AddDuration method will track the name of the method, how long it took to execute, and will increment the total call count.

When your program is done running, you can dump the results to the console or your logging system by calling CountLogger.DumpResults, which takes a lamba expression. You can call it like so:

`CountLogger.DumpResults(Console.WriteLine);`

The results of a sample run are shown here:

![](/img/countloggeroutput.jpg)

Currently the library is built on DNX using dnx451. It’s not in Nuget yet but I’m sure I’ll add it some time soon. Feedback is welcome either here or on GitHub.