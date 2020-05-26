---
templateKey: blog-post
title: IDisposable and WCF
path: blog-post
date: 2009-02-09T01:44:00.000Z
description: Recently we’ve been separating our monolithic application into
  smaller systems which communicate via services. We’re using WCF for this
  communication, and one of the things that we’ve quickly noticed is that WCF
  is, for whatever reason, not compatible with the usual best practice of
  wrapping IDisposable objects with a using() {…} block.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - WCF
category:
  - Uncategorized
comments: true
share: true
---
Recently we’ve been separating our monolithic application into smaller systems which communicate via services. We’re using WCF for this communication, and one of the things that we’ve quickly noticed is that WCF is, for whatever reason, not compatible with the usual best practice of wrapping IDisposable objects with a using() {…} block. Personally, I don’t think resources should be marked IDisposable if you can’t simply use the using() statement. The issue with the case of WCF’s client’s is that the call to Close() may throw an exception (a network error). I have to believe that other disposable resources might also run into problems when cleaning up their connections, but somehow they’re still compatible with using().

Here’s an MSDN article showing the problem quite well:

> [Avoiding Problems with the Using Statement](http://msdn.microsoft.com/en-us/library/aa355056.aspx)

If you do go the using() route, and errors occur, they end up throwing from the closing brace of the using() block, and being rather difficult to diagnose. [Here’s an example of such a WCF error with a using() statement](http://blog.genom-e.com/PermaLink,guid,b9e3019d-0d68-4344-9c7a-407774323d0f.aspx).

It also includes the code for how to clean up after services correctly in light of the fact that they may blow up due to network errors. Here’s the code that you shouldn’t use because WCF doesn’t work with it:

```
<span style="color: #0000ff">using</span> (var myClient = <span style="color: #0000ff">new</span> ServiceClient())
{
  <span style="color: #0000ff">int</span> <span style="color: #0000ff">value</span> = myClient.GetSomeValue();
}
```

Here’s the code that you’re forced to use instead:

```
var myClient = <span style="color: #0000ff">new</span> ServiceClient();
<span style="color: #0000ff">try</span>
{
  <span style="color: #0000ff">int</span> <span style="color: #0000ff">value</span> = myClient.GetSomeValue();
  <span style="color: #008000">// ...</span>
  myClient.Close();
}
<span style="color: #0000ff">catch</span> (CommunicationException e)
{
  <span style="color: #008000">// ...</span>
  client.Abort();
}
<span style="color: #0000ff">catch</span> (TimeoutException e)
{
  <span style="color: #008000">// ...</span>
  client.Abort();
}
<span style="color: #0000ff">catch</span> (Exception e)
{
  <span style="color: #008000">// ...</span>
  client.Abort();
  <span style="color: #0000ff">throw</span>;
}
```

Isn’t that nice and clean? Of course you can add it as an Extension Method to your ServiceClient. If you do that, then you simply need to remember to use a finally block to call the code. I’m not sure at that point that you’re any further ahead than if you just used the using() statement to begin with, but at least it eliminates the problem of having an exception thrown on the closing brace of the using block and keeps the total amount of plumbing code that needs written to a minimum. Your code then might look like this:

```
var myClient = <span style="color: #0000ff">new</span> ServiceClient();
<span style="color: #0000ff">try</span>
{
  <span style="color: #0000ff">int</span> someValue = myClient.GetSomeValue();
}
<span style="color: #0000ff">finally</span>
{
  myClient.CloseConnection(); <span style="color: #008000">// extension method</span>
}
```



And here’s the extension method:



```
<span style="color: #0000ff">public</span> <span style="color: #0000ff">static</span> <span style="color: #0000ff">class</span> Extensions
    {
        <span style="color: #008000">/// &lt;summary&gt;</span>
        <span style="color: #008000">/// Safely closes a service client connection.</span>
        <span style="color: #008000">/// &lt;/summary&gt;</span>
        <span style="color: #008000">/// &lt;param name=&quot;myServiceClient&quot;&gt;The client connection to close.&lt;/param&gt;</span>
        <span style="color: #0000ff">public</span> <span style="color: #0000ff">static</span> <span style="color: #0000ff">void</span> CloseConnection(<span style="color: #0000ff">this</span> ICommunicationObject myServiceClient)
        {
            <span style="color: #0000ff">if</span> (myServiceClient.State != CommunicationState.Opened)
1
            <span style="color: #0000ff">if</span> (myServiceClient.State != CommunicationState.Opened)
            {
1
            {
                <span style="color: #0000ff">return</span>;
            }
&#160;
            <span style="color: #0000ff">try</span>
            {
                myServiceClient.Close();
            }
            <span style="color: #0000ff">catch</span> (CommunicationException ex)
            {
                Debug.Print(ex.ToString());
                myServiceClient.Abort();
            }
            <span style="color: #0000ff">catch</span> (TimeoutException ex)
            {
                Debug.Print(ex.ToString());
                myServiceClient.Abort();
            }
            <span style="color: #0000ff">catch</span> (Exception ex)
            {
                Debug.Print(ex.ToString());
                myServiceClient.Abort();
                <span style="color: #0000ff">throw</span>;
            }
        }
    }
```

This method simply logs any exceptions via Debug. Print, but obviously you can adjust that to suit your exception handling procedures.

Note that if you \*don’t\* clean up these connections, they will come back to bite you. One of our developers ran into an issue with our suite of integration tests for these services where they would work fine individually, but if you ran more than 10 of them, it would get real slow and start failing. Turns out they weren’t being closed so after enough of them were opened, the rest would time out waiting for an open connection. Yet another reason why testing pays off; I’m sure it would have been much harder for us to diagnose why our application was randomly slowing down and not working periodically (especially as this is for an unattended batch process).