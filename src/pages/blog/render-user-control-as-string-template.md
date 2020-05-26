---
templateKey: blog-post
title: Render User Control as String Template
path: blog-post
date: 2007-10-19T11:23:56.876Z
description: "Scott Guthrie has a great example of how to use an ASP.NET user
  control as a template which one can dynamically bind to data and then pull the
  results out as a string. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - ajax
  - asp.net
  - C#
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

[Scott Guthrie](http://weblogs.asp.net/scottgu)has a great example of[how to use an ASP.NET user control as a template which one can dynamically bind to data and then pull the results out as a string](http://weblogs.asp.net/scottgu/archive/2006/10/22/Tip_2F00_Trick_3A00_-Cool-UI-Templating-Technique-to-use-with-ASP.NET-AJAX-for-non_2D00_UpdatePanel-scenarios.aspx). One place this is useful is in AJAX scenarios in which you want to replace the contents of a region of the page with the rendered output of a user control. I’m using this very successfully in[Lake Quincy Media AdSignia](http://lakequincy.com/adsignia)for our dashboard pages, to enable me to load the page instantly and then dynamically fetch the individual charts and dashboard controls asynchronously via ASP.NET AJAX. I’ll be writing up a full article on this whole process soon, but for now I just want to show my version of ScottGu’s ViewManager class, which has been modified to use generics and interfaces to make it a bit more cohesive (it also no longer uses reflection). The user control must now implement a generic interface, IRenderable<T>, where T is the data it expects to be passed in.

<!--EndFragment-->

```
<span class="kwrd">public</span> <span class="kwrd">class</span> ViewManager

    {

        <span class="kwrd">public</span> <span class="kwrd">static</span> <span class="kwrd">string</span> RenderView&lt;D&gt;(<span class="kwrd">string</span> path, D dataToBind)

        {

            Page pageHolder = <span class="kwrd">new</span> Page();

            UserControl viewControl = (UserControl) pageHolder.LoadControl(path);

            <span class="kwrd">if</span>(viewControl <span class="kwrd">is</span> IRenderable&lt;D&gt;)

            {

                <span class="kwrd">if</span> (dataToBind != <span class="kwrd">null</span>)

                {

                    ((IRenderable&lt;D&gt;) viewControl).PopulateData(dataToBind);

                }

            }

            pageHolder.Controls.Add(viewControl);

            StringWriter output = <span class="kwrd">new</span> StringWriter();

            HttpContext.Current.Server.Execute(pageHolder, output, <span class="kwrd">false</span>);



            <span class="kwrd">return</span> output.ToString();

        }

    }



    <span class="kwrd">public</span> <span class="kwrd">interface</span> IRenderable&lt;T&gt;

    {

        <span class="kwrd">void</span> PopulateData(T data);

    }
```

A user control implementing this interface might look like this:

```
<span class="kwrd">public</span> <span class="kwrd">partial</span> <span class="kwrd">class</span> View_PublisherEarningsChart : System.Web.UI.UserControl, IRenderable&lt;DataSet&gt;

    {

        <span class="kwrd">protected</span> DataSet <strong>chartData</strong>;

        <span class="kwrd">protected</span> <span class="kwrd">void</span> Page_Load(<span class="kwrd">object</span> sender, EventArgs e)

        {

            BindPublisherEarningsChart();

        }

        <span class="kwrd">public</span> <span class="kwrd">void</span> BindPublisherEarningsChart()

        {
        // Bind chart here

        }



        <span class="preproc">#region</span> IRenderable&lt;DataTable&gt; Members

        <span class="kwrd">public</span> <span class="kwrd">void</span> PopulateData(DataSet data)

        {

            <strong>chartData</strong> = data;

        }

        <span class="preproc">#endregion</span>

    }
```

<!--StartFragment-->

With this approach, it’s easy to separate the data access from the rendering, and is very similar to the Model-View-Controller (MVC) approach that is getting a lot of press time lately in the ASP.NET world. Again, I’ll show the full dynamic loading async stuff very soon in a full article.

<!--EndFragment-->