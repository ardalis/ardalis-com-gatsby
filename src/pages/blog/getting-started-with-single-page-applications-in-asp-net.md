---
templateKey: blog-post
title: Getting Started with Single Page Applications in ASP.NET
path: blog-post
date: 2012-03-16T03:44:00.000Z
description: "One of the new features in ASP.NET MVC 4 (Beta) is a new project
  template for Single Page Applications (SPA). "
featuredpost: false
featuredimage: /img/single-page-1.png
tags:
  - asp.net
  - knockout
  - mvc
  - spa
  - visual studio
category:
  - Software Development
comments: true
share: true
---
One of the new features in ASP.NET MVC 4 (Beta) is a new project template for Single Page Applications (SPA). You can download the latest version of MVC4 from <http://asp.net/mvc/mvc4>. Once you have that installed, get started by creating a new ASP.NET MVC 4 project:

![](/img/single-page-1.png)

You’ll immediately be asked another question about exactly what kind of project you’re looking to create. This is only asked on project creation, but it’s possible in the future you’ll be able to mix and match these kinds of templates and the resources they provide in a more ad hoc manner, after projects are created, in the future. For now, though, to check out Single Page Applications, choose that template.

![](/img/single-page-2.png)

Ok, so now we have our new project and in a few seconds our project is fully set up. We see a solution explorer window that looks something like this:

![](/img/single-page-3.png)

So of course the next step is to hit F5 (or ctrl-F5) so we can check this thing out, right? Doing so yields a pretty standard home page:

![](/img/single-page-4.png)

Unfortunately, there’s no SPA goodness going on here.*Yet*. Unlike most of the other project templates, this one **actually expects you to do some work** to get things going. The nerve, right? In fact, if you’d actually read the first page that came up in the solution before quickly hitting F5, you might have noticed these comments:

![](/img/single-page-5.png)

But admit it, you didn’t read that, you just hit F5, right?

So, let’s go ahead and actually RTFM a bit and see how this SPA stuff works. We’re basically going to follow the instructions shown above. If you \*didn’t\* hit F5 yet, make sure you do so or Build the project before you try to do the Add –> Controller step. Otherwise, you won’t see the TodoItem as an option for the Model Class. The dialog should look something like this:

![](/img/single-page-6.png)

**Now** you can hit F5. And then manually change the URL to /Tasks to see the page in action.

![](/img/single-page-7.png)

Pretty exciting, eh? At this point, you can perform standard CRUD (Create-Read-Update-Delete) operations on your TodoItems without ever going to a new page. Watch the address bar and open up F12 developer tools in IE (or Chrome, or Firebug in Firefox) and watch the network activity as you manipulate the data in the list. You should see something like this:

![](/img/single-page-8.png)

You’ll also notice that you get full back/forward button support in your browser, which is pretty cool considering this is a single web page. So how does this work? Let’s look back at Visual Studio and see how this is all put together, starting with our controller. If this were a traditional ASP.NET MVC application, we would expect our TasksController to include a bunch of methods for things like Index, Update, Delete, etc. Here’s the one we created for the Single Page Application:

![](/img/single-page-9.png)

Now let’s look at the View. It’s probably a massive mess of indecipherable JavaScript to make all of this stuff work. Or is it? Here’s the Tasks’ Index.cshtml file:

![](/img/single-page-10.png)

Ok, so, 27 lines of text with 4 lines of JavaScript – not bad. I’ve circled the areas that make the magic happen. The two divs on lines 6 and 10 have a data-bind attribute set which is linking their visibility to the state of the page. That is, when the page’s state is not editingTodoItem, the grid is shown. Otherwise, the editor is shown. These bindings will be triggered instantly if the state of the page changes.

Likewise, the su

ccess and error divs on lines 14-15 are also making use of the data-bind attribute, in this case to bind the text of the div and specify the duration (in milliseconds) that the div should flash and remain visible.

Finally, there are two script blocks. The first one pulls in the viewmodel for the TodoItems, which was created for us when we created the controller using the Visual Studio tooling. This script file contains about 100 lines of JavaScript code that provides the client-side viewmodel the user will interact with. The constructor for this ViewModel class takes in some parameters, one of which is the URL to the web service/API that will be used for persisting changes to and from the data source. You can see in the code above that we’re passing in a URL of ~/api/GettingStartedWithSPA which is the name of my project. The /api convention is used by Web API by default.

Looking back at our list of Controllers, we now see that one that was added is named the same as our project, and another one for the model class we’re working with (TodoItem). These provide the Web API for performing CRUD operations on our model class, by default using Entity Framework. In addition, the /api/ path is specified in an AreaRegistration class in the first of these controllers:

![](/img/single-page-11.png)

The heavy lifting is all done by the base class, but by default it won’t actually expose any services until you create the methods yourself. That’s why the other controller file is there – it exposes the four methods we need to work with the data. Note that it’s part of the same class as in the other file, not a separate class.

![](/img/single-page-12.png)

That’s pretty much all of the server-side code required for the simple TodoList management application that we have at this point. Let’s look back at the client-side script from the Index.cshtml view. The last bit of script was:

![](/img/single-page-13.png)

Line 19 simply uses jQuery to run this script when the page has completed loading. Line 20 uses a helper method to define the shape of the data. At runtime, the code emitted by this helper looks like this:

![](/img/single-page-14.png)

The reference to upshot is referring to a JavaScript library included in the project, upshot.js. Upshot’s main task is to link your client-side code and the changes you make to the client-side model with the backend server-side persistence via web API calls.

Next we create the viewModel, and finally we apply the bindings on line 25 by calling another JavaScript library, [knockout.js](http://knockoutjs.com/). Knockout provides the support for data binding, observable properties, and the structure for creating client-side ViewModels that we can interact with at a higher level of abstraction than DOM elements.

## Even Better Updated Templates

Even better than the default item templates that come with the MVC 4 beta bits, there are [some updated examples that Steven Sanderson posted about last week that you can get via NuGet](http://blog.stevensanderson.com/2012/03/06/single-page-application-packages-and-samples). Start with a new MVC 4 project, and then install the package from the Package Manager Console by running this comment:

**Install-Package SinglePageApplication.CSharp**

assuming you’re using C# (.VisualBasic for VB). You should see a bunch of stuff in the console window and perhaps a few security warnings, and maybe even an error referring to a T4 template (SpaIndex.tt). Ignore all of these things and dismiss the various security windows.

When you install this package, it does the following:

![](/img/single-page-15.png)

**Note**: If you run this after already adding a controller using the original MVC4 Beta templates, your _SpaLayout.cshtml file will be messed up. It should look like this (you’re best to start from a new project):

![](/img/single-page-16.png)

You’ll note that both knockout and upshot were upgraded, along with EF and jQuery. Looking at the new default view, we can see it’s a bit shorter and cleaner now:

![](/img/single-page-17.png)

The latest version moves the <div> tags and their data-bind attributes into the partials, and uses a new helper method to configure upshot, leaving just one line of raw javascript in the file now. Running the revised template results in this:

![](/img/single-page-18.png)

Notice how this version behav

es differently. As you add each item, nothing happens on the network. Now click Save all, and you’ll see that all of the values are persisted at once, and the CSS styling of the items goes away (Green was indicating they weren’t yet saved). You can also click Revert all to throw away any unsaved changes you’ve accumulated.

![](/img/single-page-19.png)

This is some pretty cool stuff, and the coolest part is how easy it is for you to set up and work with. If you find this technique interesting, I strongly recommend you check out [Steven Sanderson’s talk on Knockout and Upshot](http://channel9.msdn.com/Events/TechDays/Techdays-2012-the-Netherlands/2159) and also look at [John Papa’s MVVM and Knockout course on Pluralsight](http://www.pluralsight-training.net/microsoft/Courses/TableOfContents?courseName=knockout-mvvm).

You can [view and download the source code shown here (both projects) here](https://bitbucket.org/ardalis/blogsamples/src/541a87671128/GettingStartedWithSPA).