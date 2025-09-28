---
title: Review - Locate Web Visitors With CountryHawk
date: "2006-10-05T00:00:00.0000000"
description: In this review, Steve provides a walkthrough of some common uses of CountryHawk, a component that quickly identifies the geographic location of web requests.
featuredImage: /img/countryhawk.png
---

## Bottom Line Up Front

I've been using [CountryHawk](http://www.cyscape.com/products/chawk/) for almost a year now and have been very pleased with its accuracy and performance for my needs. I had previously evaluated some free geotargeting software I found via searching the 'net, but I was not impressed with the results, and there was still a charge for updated data files. With CountryHawk, I receive monthly updates which require one step to apply to my server (and which can be configured to occur automatically if you prefer), and these updates are included in the cost of my subscription, making the cost comparable to the "free" options I had considered.

CountryHawk is not a complicated product to set up and use. It is very well designed, in that it does basically one thing, and does it very well. If you need to know where your web site's visitors are coming from, this is the tool you should use.

## CountryHawk Features and Possible Scenarios

CountryHawk is a useful component for any web application that needs to verify its visitors' country or region. Possible reasons for this might be to limit restrict access from countries known to be security threats (such as the [U.S. list of state sponsors of terrorism](http://en.wikipedia.org/wiki/U.S._list_of_state_sponsors_of_international_terrorism)). It can also be an effective way to reduce fraud and chargebacks on e-commerce sites, or to add localization capabilities. In addition to a.NET version, CountryHawk also supports ASP/COM, CFMX, and JSP server architectures, and is used by a [huge list of well-known customers](http://countryhawk.com/company/customers.aspx).

Another useful feature of CountryHawk is in providing demographic figures for your site's traffic. Done either in realtime or after-the-fact on your logs, CountryHawk can be used to determine what percentage of your site's traffic is coming from individual countries (or regions within countries). This can be valuable information that can be used to help market your products and services more effectively.

## My Scenario and Experiences

I run an advertising network for Microsoft community sites (Lake Quincy Media), which typically servers 60 Million impressions per month these days. I'm been using CountryHawk to provide geotargeting as a service to advertisers who want to avoid showing their ads to users from certain countries, or who wish to limit their ads to a particular subset of countries. Since implementing CountryHawk (and BrowserHawk - see my [BrowserHawk review](http://aspalliance.com/772)), I have not seen any noticeable performance degradation on my system, and the advertisers who have taken advantage of geotargeting have been very satisfied. What else can I say? It just works. In addition to the product's features and usefulness, I can also attest that [cyScape's](http://www.cyscape.com/) support is very responsive and helpful, as I did have some questions for them regarding a unique application configuration I was using.

## Typical Setup and Usage

CountryHawk comes with several sample files which you can use to confirm it is working properly. Getting these set up and working is pretty straightforward. There is an installer that is recommended, and makes setup more-or-less brainless, but in my case I went the less-recommended but still effective manual setup route. Setting up manually for an ASP.NET site involves dropping the assembly in your application's /bin folder along with your license file, countries data file (countries.cdd), and CountryHawk.properties file. Set a couple of self-explanatory (and well-documented) values in the.properties file and things pretty much just work.

Figure 1 below shows some sample CountryHawk code. First, the component is created using the `CountryObj.GetCountry()` static method. Then, the instance is used to pull back the user's country code, country name (not available in Standard Edition), and IP Address. Enterprise edition customers can also pull back a count of hits for this particular country, which can of course be logged to a database for statistical analysis.

#### Figure 1 - Sample CountryHawk Usage

```csharp
CountryObj chObj = null;
chObj = CountryObj.GetCountry();

string userIP = CountryObj.IPAddr;
string userCountryCode = chObj.CountryCode;
string userCountryName = chObj.CountryName;
long hitCount = chObj.HitCount; // always 0 for non-Enterprise editions
```

Once these variables are populated, it is of course a simple matter to log them to a database or use them to customize the application based on the user's geographic location.

Another very common requirement on web sites is the capture of the user's country (and often, state). I don't know how many times I have to fill in a dropdownlist with my country every week, but it's quite a few. It would be a nice user interface feature if more sites could automatically"guess" my country based on information coming from my computer so that, at least most of the time, it would be pre-filled correctly. CountryHawk allows this scenario to be accomplished quite easily.

Let's assume as part of a web form for user registration or part of your checkout process you ask for the user's country, as in Figure 2 below. Rather than having to hard code the countries or better, create a database call to fetch the countries, you can simply use CountryHawk to populate the list of countries in the DropDownList. But better still, CountryHawk will automatically set the user's country as the default selected item. This requires all of two lines of code, shown in Figure 3.

#### Figure 2 - Sample CountryDropDownList on ASPX Page

```html
Select Country:
<asp:DropDownList runat="server" ID="CountryDropDownList" />
```

#### Figure 3 - CountryHawk Populating DropDownList Values

```csharp
private void Page_Load(object sender, System.EventArgs e)
{
 CountryObj chObj = CountryObj.GetCountry();
 chObj.GetSelectList(false, null, null, null,
 CountryDropDownList.Items);
}
```

The `GetSelectList()` method accepts several parameters to control how the DropDownList is populated, making it very flexible. Naturally this simply affects the default selection - the user is still free to choose whatever option is appropriate. This just saves them some effort (in my case, hitting the"u" key as many times as it takes to find"United States").

CountryHawk can also be configured to provide reporting on where your site's visitors are coming from. The CountryStats class which comes with the product will let easily enumerate through all of the country/region combinations that have visited your site and see the number of visitors you've received from each.

## Summary

CountryHawk is a simple, high performance, well designed component that makes customizing web application behavior based on user location a breeze. If your application will benefit from knowing where your visitors are coming from in the world, I would certainly recommend CountryHawk for your needs. You can download a free, fully functional evaluation of [CountryHawk from the product website](http://www.cyscape.com/products/chawk).

Originally published on [ASPAlliance.com](http://aspalliance.com/1039_Review_Locate_Web_Visitors_With_CountryHawk)

