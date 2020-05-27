---
templateKey: blog-post
title: Beyond Role Based Authorization in ASPNET MVC
path: blog-post
date: 2012-04-11T01:20:00.000Z
description: A fairly frequent requirement in applications is to check for
  authorization to perform an action. At the most basic level, this might just
  involve seeing if the user is authenticated (at all) or checking a flag to see
  if they are an Admin.
featuredpost: false
featuredimage: /img/asp-mvc_grande.png
tags:
  - asp.net
  - mvc
  - security
category:
  - Software Development
comments: true
share: true
---
A fairly frequent requirement in applications is to check for authorization to perform an action. At the most basic level, this might just involve seeing if the user is authenticated (at all) or checking a flag to see if they are an Admin. However, more complex requirements frequently include a variety of roles, and it’s quite common for the notion of ownership to be involved as well, with some actions being allowed if you own the item being worked on, and otherwise not. I’ve written about using the notion of [Privileges over Role Checks](https://ardalis.com/favor-privileges-over-role-checks) for this exact purpose in the past, as a way to ensure the logic of such decisions is properly encapsulated so that you can follow the [Don’t Repeat Yourself](http://deviq.com/don-t-repeat-yourself/) principle. In that article, I describe how you can test privileges, but I don’t get into how to use them at the UI level, specifically in an ASP.NET MVC application.

## ASP.NET MVC Authorization

You can do basic authorization in ASP.NET MVC by using attributes. Specifically, the Authorize attribute will let you mark a controller or action as requiring authorization, and you can optionally specify certain roles and/or users who are authorized to perform this action. However, this is as far as the attribute will take you, so by itself it won’t handle the case of letting users perform certain actions on things they own, but not on others’ things.

It’s also worth noting that you can apply filters like Authorize to an entire site by using GlobalFilters (in MVC 3+). For instance, in your global.asax you can add a call to RegisterGlobalFilters(GlobalFilters.Filters) in your Application_Start() and then implement this method like so:

```
public static void RegisterGlobalFilters(GlobalFilterCollection filters)
{
	filters.Add(new HandleErrorAttribute());
	filters.Add(new AuthorizeAttribute());
}
```

Then if you have only a few actions that don’t require, for instance, authorization (e.g. home page, login page), you can mark these with the AllowAnonymous attribute (in MVC 4+):

```
[System.Web.Mvc.AllowAnonymous]
public ActionResult Login()
{
    return View();
}
```

## Authorizing Owners

In my case, I’m globally authorizing the users as shown, but then within each action I need to verify that the user is either an administrator or they are the owner of the resource they are managing. Originally, each action had some code in it that looked like this:

```
var person = _personRepository.Get(_currentUser.UserId);
if (!_authorizationService.CanAdministerResource(resourceId, person))
{    
    return View("NotAuthorized");
}
```

The problem, of course, is that this is boilerplate code that would need to be added to every action. Not very [DRY](http://deviq.com/don-t-repeat-yourself/). At first I thought I might just extract this into its own method, but since it involves a return statement, that doesn’t work well and the best I could do is write a boolean method and keep the if statements in every action method.

After a bit of research, I found out that OnActionExecuting is the best way to ensure every action within a controller runs a particular bit of code, and further, [how to return a particular view from this method](http://stackoverflow.com/questions/2271346/how-to-return-different-view-but-presererve-viewmodel-in-onactionexecuting). With this, I was able to override OnActionExecuting in my controller in question (every action of which will include the resource being worked with) like so:

```
protected override void OnActionExecuting(ActionExecutingContext filterContext)
{
    string resourceId = filterContext.ActionParameters["resourceId"] as string;
    var person = _personRepository.Get(_currentUser.UserId);
    if (!_authorizationService.CanAdministerResource(resourceId, person))
    {
        filterContext.Result = View("NotAuthorized");
    }
    base.OnActionExecuting(filterContext);
}
```

What do you think of this approach? In my case, I only have one controller that needs to do this, but if I had several I could always create a common base controller and push up this code into the base class. I’m sure I could also go the custom action filter route but that seemed like overkill for what I’m looking at doing (and you can’t actually change the behavior of the action from within the filter itself, so there would need to be more moving parts). Any suggestions on how to do this better, or does this seem like a good approach?

The _currentUser class used here is one I picked up somewhere online (not sure where at this point or I would add a link) that makes it easy to avoid a dependency on HttpContext. It looks like this:

```
public class CurrentUser
{        
	public CurrentUser(IIdentity identity)
	{            
		try
		{
			IsAuthenticated = identity.IsAuthenticated;                
                        UserId = Guid.Parse(identity.Name);
                }
		catch (Exception ex)
		{                
			Debug.Print(ex.ToString());
                }        
	}         
	
	public bool IsAuthenticated { get; private set; }
	public Guid UserId { get; private set; }
}
```

I inject it into the class using my IOC container, in this case StructureMap. I don’t need to tell StructureMap anything about CurrentUser itself, provided it knows what to do with the constructor parameters. Thus, I include one line to tell it how to get an IIdentity:

```
x.For<IIdentity>().Use(() => HttpContext.Current.User.Identity);
```

Of course, in my tests I can simply pass in a new CurrentUser() and pass in a mock IIdentity if I care about its settings within the context of a given test. These last bits are separate from the main topic of the post, but I’m including them so the code shown is clear and not missing key ingredients, which I know can be frustrating.