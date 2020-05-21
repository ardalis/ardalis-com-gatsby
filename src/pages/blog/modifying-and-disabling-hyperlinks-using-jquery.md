---
templateKey: blog-post
title: Modifying and Disabling Hyperlinks using jQuery
path: blog-post
date: 2012-04-13T05:05:00.000Z
description: "I have a simple menu in an ASP.NET MVC application allows a user
  to take one of several actions after first selecting a resource to work with
  from a drop down list / select box or textbox. "
featuredpost: false
featuredimage: /img/jquery.png
tags:
  - html
  - javascript
  - jquery
  - jqueryui
category:
  - Software Development
comments: true
share: true
---
I have a simple menu in an ASP.NET MVC application allows a user to take one of several actions after first selecting a resource to work with from a drop down list / select box or textbox. In the case where the user hasn’t yet selected anything (or entered any text), I want the links to be disabled, as I’d rather let the user know the issue on the current dashboard page than have them go to a page without a required parameter and **then** hit them with an error message about the missing parameter. Instead, I’d like to, in the case of the empty textbox, give the textbox focus and flash some color there so the user (usually me) knows they need to enter something there before proceeding.

You can’t just .disable() a hyperlink or anchor tag using jQuery, nor can you .enable() it. There’s also a bit of magic involved in being able to take the contents of a textbox or select list and stick them into the URL in a link, which I’ll also show here. For my menu, it’s organized inside of an unordered list (<ul>) with individual list items (<li>) and anchors (<a>). It’s pretty straightforward to select and work on each such link using a jQuery selector.

Here’s the HTML for one of the two menus I’m working with, the one that requires a textbox. The other one is set up identically except it has a drop down list.

```
<span style="color: #0000ff">&lt;</span><span style="color: #800000">h2</span><span style="color: #0000ff">&gt;</span>Email Admin Menu<span style="color: #0000ff">&lt;/</span><span style="color: #800000">h2</span><span style="color: #0000ff">&gt;</span>
<span style="color: #0000ff">&lt;</span><span style="color: #800000">fieldset</span><span style="color: #0000ff">&gt;</span>
    <span style="color: #0000ff">&lt;</span><span style="color: #800000">label</span><span style="color: #0000ff">&gt;</span>Email Address:<span style="color: #0000ff">&lt;/</span><span style="color: #800000">label</span><span style="color: #0000ff">&gt;</span>
        <span style="color: #0000ff">&lt;</span><span style="color: #800000">input</span> <span style="color: #ff0000">type</span><span style="color: #0000ff">="text"</span> <span style="color: #ff0000">id</span><span style="color: #0000ff">="email"</span><span style="color: #0000ff">/&gt;</span>
        <span style="color: #0000ff">&lt;/</span><span style="color: #800000">fieldset</span><span style="color: #0000ff">&gt;</span>
        <span style="color: #0000ff">&lt;</span><span style="color: #800000">div</span> <span style="color: #ff0000">class</span><span style="color: #0000ff">="menu"</span><span style="color: #0000ff">&gt;</span>
            <span style="color: #0000ff">&lt;</span><span style="color: #800000">ul</span> <span style="color: #ff0000">class</span><span style="color: #0000ff">="navlist"</span> <span style="color: #ff0000">id</span><span style="color: #0000ff">="email-menu"</span><span style="color: #0000ff">&gt;</span>
                <span style="color: #0000ff">&lt;</span><span style="color: #800000">li</span><span style="color: #0000ff">&gt;</span>@Html.ActionLink("Unsubscribe Email from All Lists", "UnsubAll", "EmailAdmin")<span style="color: #0000ff">&lt;/</span><span style="color: #800000">li</span><span style="color: #0000ff">&gt;</span>
                    <span style="color: #0000ff">&lt;</span><span style="color: #800000">li</span><span style="color: #0000ff">&gt;</span>@Html.ActionLink("Change Email for All Lists", "ChangeEmail", "EmailAdmin")<span style="color: #0000ff">&lt;/</span><span style="color: #800000">li</span><span style="color: #0000ff">&gt;</span>
                        <span style="color: #0000ff">&lt;/</span><span style="color: #800000">ul</span><span style="color: #0000ff">&gt;</span>
                        <span style="color: #0000ff">&lt;/</span><span style="color: #800000">div</span><span style="color: #0000ff">&gt;</span>
```

## Getting the Value from the Textbox or DropDownList

The first thing I need in either menu is the value the user has provided in the <input type=text> or <select> form field. Here are the two ways to do this – jQuery 101 stuff:

```
<span style="color: #008000">// get selected text from &lt;select&gt; list</span>
<span style="color: #0000ff">var</span> selectedList = $(<span style="color: #006080">'#SelectedListName :selected'</span>).text();
<span style="color: #008000">// get text from an &lt;input type='text'&gt; field</span>
<span style="color: #0000ff">var</span> selectedEmail = $(<span style="color: #006080">'#email'</span>).val();
```

## Appending a Value to a Link in an Anchor

Next, I’ve set up my routes in ASP.NET MVC so that the last bit of each URL is the resource being worked with – in this case an email address the user enters into a textbox. Whenever the user enters something, I want the value to be automatically tacked onto the end of all of the different links within the corresponding menu. However, I can just append the value to whatever the link is currently, because then the link would continue to grow and grow and grow if the user changed their mind and typed or selected a few different things before clicking a link. Thus, I need to only replace the last section of the link, after a certain number of ‘/’ characters. Here’s the code to update all of the links within a menu, using the .each() function:

```
$(<span style="color: #006080">'ul#list-menu &gt; li &gt; a'</span>).each(<span style="color: #0000ff">function</span> () {

    <span style="color: #0000ff">var</span> href = $(<span style="color: #0000ff">this</span>).attr(<span style="color: #006080">'href'</span>);

    <span style="color: #0000ff">var</span> parts = href.split(<span style="color: #006080">'/'</span>);

    <span style="color: #0000ff">var</span> baseUrl = parts.slice(0, 3).join(<span style="color: #006080">'/'</span>);

    $(<span style="color: #0000ff">this</span>).attr(<span style="color: #006080">'href'</span>, baseUrl + <span style="color: #006080">'/'</span> + selectedList);

});
```

## Enabling and Disabling Links using jQuery

The last step is to make sure that the links don’t work until the user has entered a value into the textbox (for the dropdownlist, it will always have some valid resource selected, so I don’t need to do this). The way you disable clicking on an anchor tag from navigating to the corresponding href URL is by binding the click() event and calling e.preventDefault(). This will prevent the default behavior of the click, namely the navigation to the URL. In my case, I’m doing this whenever the textbox has zero length – I could do more advanced validation but this is sufficient for this example – and when this occurs I’m also highlighting the textbox in red and giving it focus.

Once you’ve added a .click() event handler, you can’t simply add another one to undo the effect, as this will cause both to happen. So, you could wire up the .click() handler to call a named function, and do your validation checking in that function, or you can unbind the .click() handler when it’s not needed, which is the approach I’m showing here. The full function for adjusting the links in the email-based menu is shown below, which includes the code required to modify the URLs similarly to what was shown above.

```
<span style="color: #0000ff">function</span> updateEmailLinks() {

    <span style="color: #0000ff">var</span> selectedEmail = $(<span style="color: #006080">'#email'</span>).val();

    $(<span style="color: #006080">'ul#email-menu &gt; li &gt; a'</span>).each(<span style="color: #0000ff">function</span> () {
     <span style="color: #0000ff">var</span> href = $(<span style="color: #0000ff">this</span>).attr(<span style="color: #006080">'href'</span>);

        <span style="color: #0000ff">var</span> parts = href.split(<span style="color: #006080">'/'</span>);

        <span style="color: #0000ff">var</span> baseUrl = parts.slice(0, 3).join(<span style="color: #006080">'/'</span>);

        $(<span style="color: #0000ff">this</span>).attr(<span style="color: #006080">'href'</span>, baseUrl + <span style="color: #006080">'/'</span> + selectedEmail);

        <span style="color: #0000ff">if</span> (selectedEmail.length == 0) {

            <span style="color: #008000">// disable links</span>

            $(<span style="color: #0000ff">this</span>).click(<span style="color: #0000ff">function</span> (e) {

                e.preventDefault();

                $(<span style="color: #006080">'#email'</span>).effect(<span style="color: #006080">"highlight"</span>, { color: <span style="color: #006080">'red'</span> }, 2000);

                $(<span style="color: #006080">'#email'</span>).focus();

            });

        } <span style="color: #0000ff">else</span> {


            <span style="color: #008000">// re-enable</span>

            $(<span style="color: #0000ff">this</span>).unbind(<span style="color: #006080">'click'</span>);

        }

    });

}
```

## Wiring Things Up

Once you have these things set up, all that remains is to wire them up when the page loads. In this case, we want the updating of the links to occur any time the corresponding UI element changes. I’m also setting up the textbox to autocomplete based on emails in the system already. In addition to firing when the UI element changes, I need the functions to each run one time when the page loads, so that the URLs are set accordingly and the links are disabled if the textbox is empty. Here’s the on-page-load function:

```
$(<span style="color: #0000ff">function</span> () {

    $(<span style="color: #006080">'#SelectedListName'</span>).change(<span style="color: #0000ff">function</span> () {

        updateListLinks();

    });

    updateListLinks();


    $(<span style="color: #006080">"#email"</span>).autocomplete({

        source: <span style="color: #006080">"/Admin/Emails"</span>,

        minLength: 2,

        change: <span style="color: #0000ff">function</span> (<span style="color: #0000ff">event</span>, ui) {


            updateEmailLinks();

        }

    });

    updateEmailLinks();

});
```

## Summary

I’m far from being a jQuery expert, but I was able to get all of this working very quickly with some help from [jQueryUI.com](http://jqueryui.com/) and [StackOverflow.com](http://stackoverflow.com/), which has a ton of jQuery questions and answers. I’m not currently using an MVVM style of client-side programming, although I expect to learn to do so in the very near future using frameworks like [Knockout](http://knockoutjs.com/) and [KendoUI](http://www.kendoui.com/), which for this code wouldn’t make a huge difference, but might clean it up some by letting me bind things to a model, rather than to the selected element of some UI element. This would clean up the menu link URL logic significantly, as I could just bind the links to a model with a property for the URL that was dynamically created, for instance. This is left as an exercise for the reader, or perhaps a follow-up article in the future.