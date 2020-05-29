---
templateKey: blog-post
title: Configuring a WCF Service to Run Via HTTPS
path: blog-post
date: 2011-04-22T19:56:00.000Z
description: "Yesterday I wrote about how to wire up jQuery UI’s AutoComplete
  add-in to a WCF Service to create an autocomplete search/navigation control. "
featuredpost: false
featuredimage: /img/blank-color-colorful-209678-760x360.jpg
tags:
  - WCF
category:
  - Software Development
comments: true
share: true
---
Yesterday I wrote about [how to wire up jQuery UI’s AutoComplete add-in to a WCF Service to create an autocomplete search/navigation control](/creating-an-autocomplete-redirect-navigation-control-using-jquery-ui). Today I deployed the resulting code to production but initially had some trouble getting things to work. The only real difference between the two environments is that in production everything goes through HTTPS/SSL, so I figured that had to be the culprit. A bit of searching led to this blog post describing [WCF Bindings Needed for HTTPS](http://weblogs.asp.net/srkirkland/archive/2008/02/20/wcf-bindings-needed-for-https.aspx). I pretty much followed its advice exactly and things worked immediately. Here’s my code:

```
<span style="color: #606060" id="lnum1">   1:</span> 
<span style="color: #0000ff">&lt;</span>
<span style="color: #800000">system.serviceModel</span>
<span style="color: #0000ff">&gt;</span>
<span style="color: #606060" id="lnum2">   2:</span>   
<span style="color: #0000ff">&lt;</span>
<span style="color: #800000">behaviors</span>
<span style="color: #0000ff">&gt;</span>
<span style="color: #606060" id="lnum3">   3:</span>     
<span style="color: #0000ff">&lt;</span>
<span style="color: #800000">endpointBehaviors</span>
<span style="color: #0000ff">&gt;</span>
<span style="color: #606060" id="lnum4">   4:</span>       
<span style="color: #0000ff">&lt;</span>
<span style="color: #800000">behavior</span> 
<span style="color: #ff0000">name</span>
<span style="color: #0000ff">=&quot;Web.WebServices.AccountServiceAspNetAjaxBehavior&quot;</span><span style="color: #0000ff">&gt;</span>
<span style="color: #606060" id="lnum5">   5:</span>         
<span style="color: #0000ff">&lt;</span>
<span style="color: #800000">enableWebScript</span> 
<span style="color: #0000ff">/&gt;</span>
<span style="color: #606060" id="lnum6">   6:</span>       
<span style="color: #0000ff">&lt;/</span>
<span style="color: #800000">behavior</span>
<span style="color: #0000ff">&gt;</span>
<span style="color: #606060" id="lnum7">   7:</span>     
<span style="color: #0000ff">&lt;/</span>
<span style="color: #800000">endpointBehaviors</span>
<span style="color: #0000ff">&gt;</span>
<span style="color: #606060" id="lnum8">   8:</span>   
<span style="color: #0000ff">&lt;/</span>
<span style="color: #800000">behaviors</span>
<span style="color: #0000ff">&gt;</span>
<span style="color: #606060" id="lnum9">   9:</span>   
<span style="color: #0000ff">&lt;</span>
<span style="color: #800000">serviceHostingEnvironment</span> 
<span style="color: #ff0000">aspNetCompatibilityEnabled</span>
<span style="color: #0000ff">=&quot;true&quot;</span>
<span style="color: #606060" id="lnum10">  10:</span>     
<span style="color: #ff0000">multipleSiteBindingsEnabled</span>
<span style="color: #0000ff">=&quot;true&quot;</span> 
<span style="color: #0000ff">/&gt;</span>
<span style="color: #606060" id="lnum11">  11:</span>   
<span style="color: #0000ff">&lt;</span>
<span style="color: #800000">services</span>
<span style="color: #0000ff">&gt;</span>
<span style="color: #606060" id="lnum12">  12:</span>     
<span style="color: #0000ff">&lt;</span>
<span style="color: #800000">service</span> 
<span style="color: #ff0000">name</span>
<span style="color: #0000ff">=&quot;Web.WebServices.AccountService&quot;</span>
<span style="color: #0000ff">&gt;</span>
<span style="color: #606060" id="lnum13">  13:</span>       
<span style="color: #0000ff">&lt;</span>
<span style="color: #800000">endpoint</span> 
<span style="color: #ff0000">address</span>
<span style="color: #0000ff">=&quot;&quot;</span> 
<span style="color: #606060" id="lnum14">  14:</span>        
<span style="color: #ff0000">behaviorConfiguration</span>
<span style="color: #0000ff">=&quot;Web.WebServices.AccountServiceAspNetAjaxBehavior&quot;</span>
<span style="color: #606060" id="lnum15">  15:</span>         
<span style="color: #ff0000">binding</span>
<span style="color: #0000ff">=&quot;webHttpBinding&quot;</span> 
<span style="color: #606060" id="lnum16">  16:</span>         
<span style="color: #ff0000">contract</span>
<span style="color: #0000ff">=&quot;Web.WebServices.AccountService&quot;</span> 
<span style="color: #606060" id="lnum17">  17:</span>         
<span style="color: #ff0000">bindingConfiguration</span>
<span style="color: #0000ff">=&quot;webBinding&quot;</span> 
<span style="color: #0000ff">/&gt;</span>
<span style="color: #606060" id="lnum18">  18:</span>     
<span style="color: #0000ff">&lt;/</span>
<span style="color: #800000">service</span>
<span style="color: #0000ff">&gt;</span>
<span style="color: #606060" id="lnum19">  19:</span>   
<span style="color: #0000ff">&lt;/</span>
<span style="color: #800000">services</span>
<span style="color: #0000ff">&gt;</span>
<span style="color: #606060" id="lnum20">  20:</span>   
<span style="color: #0000ff">&lt;</span>
<span style="color: #800000">bindings</span>
<span style="color: #0000ff">&gt;</span>
<span style="color: #606060" id="lnum21">  21:</span>     
<span style="color: #0000ff">&lt;</span>
<span style="color: #800000">webHttpBinding</span>
<span style="color: #0000ff">&gt;</span>
<span style="color: #606060" id="lnum22">  22:</span>      
<span style="color: #0000ff">&lt;</span>
<span style="color: #800000">binding</span> 
<span style="color: #ff0000">name</span>
<span style="color: #0000ff">=&quot;webBinding&quot;</span>
<span style="color: #0000ff">&gt;</span>
<span style="color: #606060" id="lnum23">  23:</span>         
<span style="color: #0000ff">&lt;</span>
<span style="color: #800000">security</span> 
<span style="color: #ff0000">mode</span>
<span style="color: #0000ff">=&quot;Transport&quot;</span>
<span style="color: #0000ff">&gt;&lt;/</span>
<span style="color: #800000">security</span>
<span style="color: #0000ff">&gt;</span>
<span style="color: #606060" id="lnum24">  24:</span>       
<span style="color: #0000ff">&lt;/</span>
<span style="color: #800000">binding</span>
<span style="color: #0000ff">&gt;</span>
<span style="color: #606060" id="lnum25">  25:</span>     
<span style="color: #0000ff">&lt;/</span>
<span style="color: #800000">webHttpBinding</span>
<span style="color: #0000ff">&gt;</span>
<span style="color: #606060" id="lnum26">  26:</span>   
<span style="color: #0000ff">&lt;/</span>
<span style="color: #800000">bindings</span>
<span style="color: #0000ff">&gt;</span>
<span style="color: #606060" id="lnum27">  27:</span> 
<span style="color: #0000ff">&lt;/</span>
<span style="color: #800000">system.serviceModel</span>
<span style="color: #0000ff">&gt;</span>
```

The new addition is on line 17, which references the new <bindings /> section on lines 20-26. Hope this helps!