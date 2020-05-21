---
templateKey: blog-post
title: Working with SimpleMembership outside of ASP.NET
path: blog-post
date: 2011-08-24T12:19:00.000Z
description: "I’m using SimpleMembership, from WebMatrix’s
  distribution(WebMatrix.WebData), with an ASP.NET MVC 3 application. "
featuredpost: false
featuredimage: /img/asp-net-mvc-logo.jpg
tags:
  - asp.net mvc
  - auth
  - membership
  - security
category:
  - Software Development
comments: true
share: true
---
I’m using SimpleMembership, from WebMatrix’s distribution(WebMatrix.WebData), with an ASP.NET MVC 3 application. You can find the [NuGet Package for SimpleMembership.Mvc3 here](http://nuget.org/List/Packages/SimpleMembership.Mvc3), and installing it is just a matter of running “Install-Package SimpleMembership.Mvc3” from the Package Manager Console in Visual Studio. Unlike the built-in Membership and Role providers for ASP.NET, SimpleMembership doesn’t require huge swaths of XML to be added to your web.config file, or much in the way of database initialization using tools like aspnet_regsql.exe. Instead, it does pretty much all of its work in code, in a static class SimpleMembershipMvc3 that gets placed in your App_Start folder. The class is run using [WebActivator (another NuGet Package)](http://nuget.org/List/Packages/WebActivator) and you simply provide it a few bits of information in its Initialize() method such as the name of the ConnectionString it should use to talk to the database, and what the name of your users table and some of its columns are. By default, it will automatically create the tables it needs, though of course this is easily disabled.

In the SimpleMemberMvc3 class’s Start() method, you’ll find code that looks like this:

```
<span style="color: #0000ff">public</span> <span style="color: #0000ff">static</span> <span style="color: #0000ff">void</span> Start()
{

    <span style="color: #0000ff">if</span> (SimpleMembershipEnabled)

    {

        MembershipProvider provider = Membership.Providers[<span style="color: #006080">"AspNetSqlMembershipProvider"</span>];

        <span style="color: #0000ff">if</span> (provider != <span style="color: #0000ff">null</span>)

        {

            MembershipProvider currentDefault = provider;

            SimpleMembershipProvider provider2 =
            CreateDefaultSimpleMembershipProvider(<span style="color: #006080">"AspNetSqlMembershipProvider"</span>, currentDefault);

            Membership.Providers.Remove(<span style="color: #006080">"AspNetSqlMembershipProvider"</span>);

            Membership.Providers.Add(provider2);
        }

        Roles.Enabled = <span style="color: #0000ff">true</span>;

      RoleProvider provider3 = Roles.Providers[<span style="color: #006080">"AspNetSqlRoleProvider"</span>];
      <span style="color: #0000ff">if</span> (provider3 != <span style="color: #0000ff">null</span>)

        {

            RoleProvider provider6 = provider3;

            SimpleRoleProvider provider4 =

  CreateDefaultSimpleRoleProvider(<span style="color: #006080">"AspNetSqlRoleProvider"</span>, provider6);

            Roles.Providers.Remove(<span style="color: #006080">"AspNetSqlRoleProvider"</span>);

            Roles.Providers.Add(provider4);

        }

    }

}
```

Unfortunately, if you try and work with this code in an integration test using, for instance, NUnit and some code like this:

```
[TestFixture]

<span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> MembershipProviderShould

{

    [SetUp]

    <span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> SetUp()

    {

        SimpleMembershipMvc3.Start();

        SimpleMembershipMvc3.Initialize();

    }

    <span style="color: #008000">// tests go here</span>

}
```

You’ll get an exception when SimpleMembership makes a call to Membership.Providers.Remove(“AspNetSqlMembershipProvider”) claiming that the **collection is read-only**. You’ll encounter a similar error when you make a call to Roles.Providers.Remove(“AspNetSqlRoleProvider”). And finally, the call to Roles.Enabled will blow up as well, claiming that it cannot be called outside of App_Start or something like that.

The solution, ugly though it is, to these issues that I’ve found is to simply use some reflection to circumvent the “must only run inside a web application” goo that is embedded within these Membership providers. Specifically, there is a private read-only field that must be set to false in the ProviderCollections that hold the Membership and Role providers, and the call to Roles.Enabled can be replaced by directly setting the private static flag that this setter ultimately refers to. The updated code for Start() looks like this:

```
<span style="color: #0000ff">public</span> <span style="color: #0000ff">static</span> <span style="color: #0000ff">void</span> Start()
{

    <span style="color: #0000ff">if</span> (SimpleMembershipEnabled)

    {

        MembershipProvider provider = Membership.Providers[<span style="color: #006080">"AspNetSqlMembershipProvider"</span>];
  <span style="color: #0000ff">if</span> (provider != <span style="color: #0000ff">null</span>)

        {

            MembershipProvider currentDefault = provider;

            SimpleMembershipProvider provider2 =

                CreateDefaultSimpleMembershipProvider(<span style="color: #006080">"AspNetSqlMembershipProvider"</span>, currentDefault);

            <span style="color: #008000">// turn off read-only on Membership Providers collection</span>

            FieldInfo field = <span style="color: #0000ff">typeof</span>(ProviderCollection).GetField(<span style="color: #006080">"_ReadOnly"</span>,

                BindingFlags.Instance | BindingFlags.NonPublic);

            field.SetValue(Membership.Providers, <span style="color: #0000ff">false</span>);
  Membership.Providers.Remove(<span style="color: #006080">"AspNetSqlMembershipProvider"</span>);
          Membership.Providers.Add(provider2);
      }

        <span style="color: #008000">//Roles.Enabled = true; does not work outside of a web application - use reflection instead</span>

        FieldInfo enabledField = <span style="color: #0000ff">typeof</span> (Roles).GetField(<span style="color: #006080">"s_Enabled"</span>,

            BindingFlags.Static | BindingFlags.NonPublic);

        enabledField.SetValue(<span style="color: #0000ff">null</span>, <span style="color: #0000ff">true</span>);

        RoleProvider provider3 = Roles.Providers[<span style="color: #006080">"AspNetSqlRoleProvider"</span>];

        <span style="color: #0000ff">if</span> (provider3 != <span style="color: #0000ff">null</span>)

        {

            RoleProvider provider6 = provider3;

            SimpleRoleProvider provider4 =

                CreateDefaultSimpleRoleProvider(<span style="color: #006080">"AspNetSqlRoleProvider"</span>, provider6);

            <span style="color: #008000">// turn off read-only on Role Providers collection</span>

            FieldInfo field = <span style="color: #0000ff">typeof</span>(ProviderCollection).GetField(<span style="color: #006080">"_ReadOnly"</span>,

                BindingFlags.Instance | BindingFlags.NonPublic);

            field.SetValue(Roles.Providers, <span style="color: #0000ff">false</span>);


            Roles.Providers.Remove(<span style="color: #006080">"AspNetSqlRoleProvider"</span>);

            Roles.Providers.Add(provider4);

        }

    }

}
```

Now, this code could easily break with a later version of .NET, so ***use it at your own risk***. It’s also going to be a slight bit slower than the non-reflection-based code, but since this is only run once when your application starts up, that shouldn’t be a major concern. If you want to mitigate that, you can use #ifdef statements or something similar to only perform these actions in your Debug build configuration, and allow your Release build to continue using the non-reflection-based code (alternately, you could detect if you have an HttpContext.Current and if so, go with the original version. I haven’t tried this approach, but it should work as well).