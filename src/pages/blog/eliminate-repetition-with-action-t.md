---
templateKey: blog-post
title: Eliminate Repetition with Action<T>
path: blog-post
date: 2010-03-02T11:55:00.000Z
description: Yesterday I was looking at some old code and refactoring it to
  clean it up (in this case I wasn’t the original author, but I’ve written code
  just like this). The application in question was a simple process that had to
  run once per month, on demand, and so was coded up as an EXE application. As
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Action<T>
category:
  - Uncategorized
comments: true
share: true
---
Yesterday I was looking at some old code and refactoring it to clean it up (in this case I wasn’t the original author, but I’ve written code just like this). The application in question was a simple process that had to run once per month, on demand, and so was coded up as an EXE application. As it ran, it provided updates on its progress, so it looked something like this:

```
<span style="color: #0000ff">static</span> <span style="color: #0000ff">void</span> Main(<span style="color: #0000ff">string</span>[] args)
{
    Console.WriteLine(<span style="color: #006080">&quot;Starting Application @ &quot;</span> + DateTime.Now);
    var parser = <span style="color: #0000ff">new</span> ParameterParser();
    Parameters parameters = parser.Parse(args);
    Console.WriteLine(<span style="color: #006080">&quot;Finalizing Revenue for &quot;</span> + parameters.DateRange.StartDate.Month + <span style="color: #006080">&quot;/&quot;</span> + parameters.DateRange.StartDate.Year);
&#160;
    IRevenueRepository repository = <span style="color: #0000ff">new</span> LinqRevenueRepository();
&#160;
    var mostRecentFinalizedDate = repository.GetMostRecentFinalizedDate();
    <span style="color: #0000ff">if</span> (mostRecentFinalizedDate &gt;= parameters.DateRange.StartDate)
    {
        <span style="color: #0000ff">throw</span> <span style="color: #0000ff">new</span> Exception(<span style="color: #006080">&quot;Revenue already finalized for period.&quot;</span>);
    }
&#160;
    Console.WriteLine(<span style="color: #006080">&quot;Begin FinalizePublisherRevenue @ &quot;</span> + DateTime.Now);
    repository.FinalizePublisherRevenue(parameters.DateRange);
    Console.WriteLine(<span style="color: #006080">&quot;End FinalizePublisherRevenue @ &quot;</span> + DateTime.Now);
    Console.WriteLine();
    Console.WriteLine(<span style="color: #006080">&quot;Begin FinalizeAccountManagerRevenue @ &quot;</span> + DateTime.Now);
    repository.FinalizeAccountManagerRevenue(parameters.DateRange);
    Console.WriteLine(<span style="color: #006080">&quot;End FinalizeAccountManagerRevenue @ &quot;</span> + DateTime.Now);
    Console.WriteLine();
    Console.WriteLine(<span style="color: #006080">&quot;Begin FinalizeAgencyRevenue @ &quot;</span> + DateTime.Now);
    repository.FinalizeAgencyRevenue(parameters.DateRange);
    Console.WriteLine(<span style="color: #006080">&quot;End FinalizeAgencyRevenue @ &quot;</span> + DateTime.Now);
    Console.WriteLine();
    Console.WriteLine(<span style="color: #006080">&quot;Begin FinalizeAccountManagerRevenueDetail @ &quot;</span> + DateTime.Now);
    repository.FinalizeAccountManagerRevenueDetail(parameters.DateRange);
    Console.WriteLine(<span style="color: #006080">&quot;End FinalizeAccountManagerRevenueDetail @ &quot;</span> + DateTime.Now);
    Console.WriteLine();
    Console.WriteLine(<span style="color: #006080">&quot;Begin FinalizeAgencyRevenueDetail @ &quot;</span> + DateTime.Now);
    repository.FinalizeAgencyRevenueDetail(parameters.DateRange);
    Console.WriteLine(<span style="color: #006080">&quot;End FinalizeAgencyRevenueDetail @ &quot;</span> + DateTime.Now);
    Console.WriteLine();
&#160;
&#160;
    Console.WriteLine(<span style="color: #006080">&quot;Begin SaveAccountManagerRevenueSummary @ &quot;</span> + DateTime.Now);
    repository.SaveAccountManagerRevenueSummary(parameters.DateRange);
    Console.WriteLine(<span style="color: #006080">&quot;End SaveAccountManagerRevenueSummary @ &quot;</span> + DateTime.Now);
    Console.WriteLine();
    Console.WriteLine(<span style="color: #006080">&quot;Begin SavePublisherRevenueSummary @ &quot;</span> + DateTime.Now);
    repository.SavePublisherRevenueSummary(parameters.DateRange);
    Console.WriteLine(<span style="color: #006080">&quot;End SavePublisherRevenueSummary @ &quot;</span> + DateTime.Now);
}
```

In reviewing this simple application, I noticed a few areas where it could benefit from obvious improvement that wouldn’t take long at all to implement. I refactored the core logic into a separate service class, which took in an ILogger rather than writing directly to the console and also created a custom exception to take care of the case where the program was being re-run for a period that had already been finalized. But the significant improvement came in the area of logging the start/end of each method call, which I did by using an Action<T> method. You can see in the original code there was a lot of repetition – every method call requires 3 lines that are virtually identical except for the name of the method being called. Clearly a violation of [Don’t Repeat Yourself](http://stevesmithblog.com/blog/don-rsquo-t-repeat-yourself). I replaced each 3-line call with a single line method call that took in an Action<DateRange> parameter representing the method to invoke. The result is that all of the magic strings for the method names disappeared, and the code is much more compact and easily understood:

```
<span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> FinalizeMonth(DateRange dateRange)
{
    DateTime mostRecentFinalizedDate = _revenueRepository.GetMostRecentFinalizedDate();
    <span style="color: #0000ff">if</span> (mostRecentFinalizedDate &gt;= dateRange.StartDate)
    {
        <span style="color: #0000ff">throw</span> <span style="color: #0000ff">new</span> RevenuePreviouslyFinalizedException(<span style="color: #006080">&quot;Revenue already finalized for period: &quot;</span> + dateRange);
    }
&#160;
    ExecuteStep(dateRange, _revenueRepository.FinalizePublisherRevenue);
    ExecuteStep(dateRange, _revenueRepository.FinalizeAccountManagerRevenue);
    ExecuteStep(dateRange, _revenueRepository.FinalizeAgencyRevenue);
    ExecuteStep(dateRange,
                _revenueRepository.FinalizeAccountManagerRevenueDetail);
    ExecuteStep(dateRange, _revenueRepository.FinalizeAgencyRevenueDetail);
&#160;
    ExecuteStep(dateRange,
                _revenueRepository.SaveAccountManagerRevenueSummary);
    ExecuteStep(dateRange, _revenueRepository.SavePublisherRevenueSummary);
}
&#160;
<span style="color: #0000ff">private</span> <span style="color: #0000ff">void</span> ExecuteStep(DateRange dateRange, Action&lt;DateRange&gt; stepMethod)
{
    _logger.Info(<span style="color: #006080">&quot;Begin &quot;</span> + stepMethod.Method.Name + <span style="color: #006080">&quot; @ &quot;</span> + DateTime.Now);
    stepMethod.Invoke(dateRange);
    _logger.Info(<span style="color: #006080">&quot;End &quot;</span> + stepMethod.Method.Name + <span style="color: #006080">&quot; @ &quot;</span> + DateTime.Now);
}
```

Note that within ExecuteStep(), I’m able to extract the name of the method being called by referring to the **Action<T>.Method.Name**property. This is something I wasn’t previously aware of, but it helped clean up my code significantly in this case (the FinalizeMonth method is now only about 10 lines of code, instead of the original main() method which was over 30 lines of code. The new version is also testable, and in fact I added unit tests to confirm everything works as expected, since these also were lacking from the original code. The result, after about an hour, is something much cleaner that I or another developer will be able to maintain with a greatly reduced learning curve and risk of breakage.