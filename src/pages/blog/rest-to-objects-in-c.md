---
templateKey: blog-post
title: REST to Objects in C#
path: blog-post
date: 2010-05-06T04:51:00.000Z
description: RESTful interfaces for web services are all the rage for many Web
  2.0 sites. If you want to consume these in a very simple fashion, LINQ to XML
  can do the job pretty easily in C#. If you go searching for help on this,
  you’ll find a lot of incomplete solutions and fairly large toolkits
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - C#
category:
  - Uncategorized
comments: true
share: true
---
RESTful interfaces for web services are all the rage for many Web 2.0 sites. If you want to consume these in a very simple fashion, LINQ to XML can do the job pretty easily in C#. If you go searching for help on this, you’ll find a lot of incomplete solutions and fairly large toolkits and frameworks (guess how I know this) – this quick article is meant to be a no fluff just stuff approach to making this work.

**POCO Objects**

Let’s assume you have a Model that you want to suck data into from a RESTful web service. Ideally this is a Plain Old CLR Object, meaning it isn’t infected with any persistence or serialization goop. It might look something like this:

```
<span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> Entry
{
   <span style="color: #0000ff">public</span> <span style="color: #0000ff">int</span> Id;
<span style="color: #0000ff">public</span> <span style="color: #0000ff">int</span> UserId;
    <span style="color: #0000ff">public</span> DateTime Date;
    <span style="color: #0000ff">public</span> <span style="color: #0000ff">float</span> Hours;
    <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> Notes;
    <span style="color: #0000ff">public</span> <span style="color: #0000ff">bool</span> Billable;
&#160;
    <span style="color: #0000ff">public</span> <span style="color: #0000ff">override</span> <span style="color: #0000ff">string</span> ToString()
    {
        <span style="color: #0000ff">return</span> String.Format(<span style="color: #006080">&quot;[{0}] User: {1} Date: {2} Hours: {3} Notes: {4} Billable {5}&quot;</span>, Id, UserId, Date, Hours,
                             Notes, Billable);
    }
}
```

Not that this isn’t a completely trivial object. Let’s look at the API for the service.

**RESTful HTTP Service**

In this case, it’s [TickSpot’s API](http://tickspot.com/api), with the following sample output:

```
<span style="color: #0000ff">&lt;?</span><span style="color: #800000">xml</span> <span style="color: #ff0000">version</span><span style="color: #0000ff">=&quot;1.0&quot;</span> <span style="color: #ff0000">encoding</span><span style="color: #0000ff">=&quot;UTF-8&quot;</span>?<span style="color: #0000ff">&gt;</span>
<span style="color: #0000ff">&lt;</span><span style="color: #800000">entries</span> <span style="color: #ff0000">type</span><span style="color: #0000ff">=&quot;array&quot;</span><span style="color: #0000ff">&gt;</span>
  <span style="color: #0000ff">&lt;</span><span style="color: #800000">entry</span><span style="color: #0000ff">&gt;</span>
    <span style="color: #0000ff">&lt;</span><span style="color: #800000">id</span> <span style="color: #ff0000">type</span><span style="color: #0000ff">=&quot;integer&quot;</span><span style="color: #0000ff">&gt;</span>24<span style="color: #0000ff">&lt;/</span><span style="color: #800000">id</span><span style="color: #0000ff">&gt;</span>
    <span style="color: #0000ff">&lt;</span><span style="color: #800000">task_id</span> <span style="color: #ff0000">type</span><span style="color: #0000ff">=&quot;integer&quot;</span><span style="color: #0000ff">&gt;</span>14<span style="color: #0000ff">&lt;/</span><span style="color: #800000">task_id</span><span style="color: #0000ff">&gt;</span>
    <span style="color: #0000ff">&lt;</span><span style="color: #800000">user_id</span> <span style="color: #ff0000">type</span><span style="color: #0000ff">=&quot;integer&quot;</span><span style="color: #0000ff">&gt;</span>3<span style="color: #0000ff">&lt;/</span><span style="color: #800000">user_id</span><span style="color: #0000ff">&gt;</span>
    <span style="color: #0000ff">&lt;</span><span style="color: #800000">date</span> <span style="color: #ff0000">type</span><span style="color: #0000ff">=&quot;date&quot;</span><span style="color: #0000ff">&gt;</span>2008-03-08<span style="color: #0000ff">&lt;/</span><span style="color: #800000">date</span><span style="color: #0000ff">&gt;</span>
    <span style="color: #0000ff">&lt;</span><span style="color: #800000">hours</span> <span style="color: #ff0000">type</span><span style="color: #0000ff">=&quot;float&quot;</span><span style="color: #0000ff">&gt;</span>1.00<span style="color: #0000ff">&lt;/</span><span style="color: #800000">hours</span><span style="color: #0000ff">&gt;</span>
    <span style="color: #0000ff">&lt;</span><span style="color: #800000">notes</span><span style="color: #0000ff">&gt;</span>Had trouble with tribbles.<span style="color: #0000ff">&lt;/</span><span style="color: #800000">notes</span><span style="color: #0000ff">&gt;</span>
    <span style="color: #0000ff">&lt;</span><span style="color: #800000">billable</span><span style="color: #0000ff">&gt;</span>true<span style="color: #0000ff">&lt;/</span><span style="color: #800000">billable</span><span style="color: #0000ff">&gt;</span> # Billable is an attribute inherited from the task
    <span style="color: #0000ff">&lt;</span><span style="color: #800000">billed</span><span style="color: #0000ff">&gt;</span>true<span style="color: #0000ff">&lt;/</span><span style="color: #800000">billed</span><span style="color: #0000ff">&gt;</span>     # Billed is an attribute to track whether the entry has been invoiced
    <span style="color: #0000ff">&lt;</span><span style="color: #800000">created_at</span> <span style="color: #ff0000">type</span><span style="color: #0000ff">=&quot;datetime&quot;</span><span style="color: #0000ff">&gt;</span>Tue, 07 Oct 2008 14:46:16 -0400<span style="color: #0000ff">&lt;/</span><span style="color: #800000">created_at</span><span style="color: #0000ff">&gt;</span>
    <span style="color: #0000ff">&lt;</span><span style="color: #800000">updated_at</span> <span style="color: #ff0000">type</span><span style="color: #0000ff">=&quot;datetime&quot;</span><span style="color: #0000ff">&gt;</span>Tue, 07 Oct 2008 14:46:16 -0400<span style="color: #0000ff">&lt;/</span><span style="color: #800000">updated_at</span><span style="color: #0000ff">&gt;</span>
   # The following attributes are derived and provided for informational purposes:
    <span style="color: #0000ff">&lt;</span><span style="color: #800000">user_email</span><span style="color: #0000ff">&gt;</span>scotty@enterprise.com<span style="color: #0000ff">&lt;/</span><span style="color: #800000">user_email</span><span style="color: #0000ff">&gt;</span>
    <span style="color: #0000ff">&lt;</span><span style="color: #800000">task_name</span><span style="color: #0000ff">&gt;</span>Remove converter assembly<span style="color: #0000ff">&lt;/</span><span style="color: #800000">task_name</span><span style="color: #0000ff">&gt;</span>
    <span style="color: #0000ff">&lt;</span><span style="color: #800000">sum_hours</span> <span style="color: #ff0000">type</span><span style="color: #0000ff">=&quot;float&quot;</span><span style="color: #0000ff">&gt;</span>2.00<span style="color: #0000ff">&lt;/</span><span style="color: #800000">sum_hours</span><span style="color: #0000ff">&gt;</span>
    <span style="color: #0000ff">&lt;</span><span style="color: #800000">budget</span> <span style="color: #ff0000">type</span><span style="color: #0000ff">=&quot;float&quot;</span><span style="color: #0000ff">&gt;</span>10.00<span style="color: #0000ff">&lt;/</span><span style="color: #800000">budget</span><span style="color: #0000ff">&gt;</span>
    <span style="color: #0000ff">&lt;</span><span style="color: #800000">project_name</span><span style="color: #0000ff">&gt;</span>Realign dilithium crystals<span style="color: #0000ff">&lt;/</span><span style="color: #800000">project_name</span><span style="color: #0000ff">&gt;</span>
    <span style="color: #0000ff">&lt;</span><span style="color: #800000">client_name</span><span style="color: #0000ff">&gt;</span>Starfleet Command<span style="color: #0000ff">&lt;/</span><span style="color: #800000">client_name</span><span style="color: #0000ff">&gt;</span>
  <span style="color: #0000ff">&lt;/</span><span style="color: #800000">entry</span><span style="color: #0000ff">&gt;</span>
<span style="color: #0000ff">&lt;/</span><span style="color: #800000">entries</span><span style="color: #0000ff">&gt;</span>

```

I’m assuming in this case that I don’t necessarily care about **all** of the data fields the service is returning – I just need some of them for my application’s purposes. Thus, you can see there are more elements in the <entry> XML than I have in my Entry class.



**Get The XML with C#**

The next step is to get the XML. The following snippet does the heavy lifting once you pass it the appropriate URL:

```
<span style="color: #0000ff">protected</span> XElement GetResponse(<span style="color: #0000ff">string</span> uri)
{
    var request = WebRequest.Create(uri) <span style="color: #0000ff">as</span> HttpWebRequest;
    request.UserAgent = <span style="color: #006080">&quot;.NET Sample&quot;</span>;
    request.KeepAlive = <span style="color: #0000ff">false</span>;
&#160;
    request.Timeout = 15 * 1000;
&#160;
    var response = request.GetResponse() <span style="color: #0000ff">as</span> HttpWebResponse;
&#160;
    <span style="color: #0000ff">if</span> (request.HaveResponse == <span style="color: #0000ff">true</span> && response != <span style="color: #0000ff">null</span>)
    {
        var reader = <span style="color: #0000ff">new</span> StreamReader(response.GetResponseStream());
        <span style="color: #0000ff">return</span> XElement.Parse(reader.ReadToEnd());
    }
    <span style="color: #0000ff">throw</span> <span style="color: #0000ff">new</span> Exception(<span style="color: #006080">&quot;Error fetching data.&quot;</span>);
}
```

This is adapted from the [Yahoo Developer article on Web Service REST calls](http://developer.yahoo.com/dotnet/howto-rest_cs.html). Once you have the XML, the last step is to get the data back as your POCO.

**Use LINQ-To-XML to Deserialize POCOs from XML**

This is done via the following code:

```
<span style="color: #0000ff">public</span> IEnumerable&lt;Entry&gt; List(DateTime startDate, DateTime endDate)
{
    <span style="color: #0000ff">string</span> additionalParameters =
        String.Format(<span style="color: #006080">&quot;start_date={0}&end_date={1}&quot;</span>,
        startDate.ToShortDateString(),
        endDate.ToShortDateString());
    <span style="color: #0000ff">string</span> uri = BuildUrl(<span style="color: #006080">&quot;entries&quot;</span>, additionalParameters);
&#160;
    XElement elements = GetResponse(uri);
&#160;
    var entries = from e <span style="color: #0000ff">in</span> elements.Elements()
                  <span style="color: #0000ff">where</span> e.Name.LocalName == <span style="color: #006080">&quot;entry&quot;</span>
                  select <span style="color: #0000ff">new</span> Entry
                             {
                                 Id = <span style="color: #0000ff">int</span>.Parse(e.Element(<span style="color: #006080">&quot;id&quot;</span>).Value),
                                 UserId = <span style="color: #0000ff">int</span>.Parse(e.Element(<span style="color: #006080">&quot;user_id&quot;</span>).Value),
                                 Date = DateTime.Parse(e.Element(<span style="color: #006080">&quot;date&quot;</span>).Value),
                                 Hours = <span style="color: #0000ff">float</span>.Parse(e.Element(<span style="color: #006080">&quot;hours&quot;</span>).Value),
                                 Notes = e.Element(<span style="color: #006080">&quot;notes&quot;</span>).Value,
                                 Billable = <span style="color: #0000ff">bool</span>.Parse(e.Element(<span style="color: #006080">&quot;billable&quot;</span>).Value)
                             };
    <span style="color: #0000ff">return</span> entries;
}
```

For completeness, here’s the Build Url method for my TickSpot API wrapper:

```
<span style="color: #008000">// Change these to your settings</span>
<span style="color: #0000ff">protected</span> <span style="color: #0000ff">const</span> <span style="color: #0000ff">string</span> projectDomain = <span style="color: #006080">&quot;DOMAIN.tickspot.com&quot;</span>;
<span style="color: #0000ff">private</span> <span style="color: #0000ff">const</span> <span style="color: #0000ff">string</span> authParams = <span style="color: #006080">&quot;email=johndoe@domain.com&password=MyTickSpotPassword&quot;</span>;
&#160;
<span style="color: #0000ff">protected</span> <span style="color: #0000ff">string</span> BuildUrl(<span style="color: #0000ff">string</span> apiMethod, <span style="color: #0000ff">string</span> additionalParams)
{
    <span style="color: #0000ff">if</span> (projectDomain.Contains(<span style="color: #006080">&quot;DOMAIN&quot;</span>))
    {
        <span style="color: #0000ff">throw</span> <span style="color: #0000ff">new</span> ApplicationException(<span style="color: #006080">&quot;You must update your domain in ProjectRepository.cs.&quot;</span>);
    }
    <span style="color: #0000ff">if</span> (authParams.Contains(<span style="color: #006080">&quot;MyTickSpotPassword&quot;</span>))
    {
        <span style="color: #0000ff">throw</span> <span style="color: #0000ff">new</span> ApplicationException(<span style="color: #006080">&quot;You must update your email and password in ProjectRepository.cs.&quot;</span>);
    }
    <span style="color: #0000ff">return</span> <span style="color: #0000ff">string</span>.Format(<span style="color: #006080">&quot;https://{0}/api/{1}?{2}&{3}&quot;</span>, projectDomain, apiMethod, authParams, additionalParams);
}
```