---
templateKey: blog-post
title: Writing a Days of the Week Selector Control
date: 2004-09-13
path: blog-post
description: In this article I'll describe the process I went through to create a control for choosing days of the week. The need driving this is the creation of an admin program that allows certain tasks to be scheduled for certain days of the week, a la Windows Scheduled Tasks.
featuredpost: false
featuredimage: /img/days-week-selector.png
tags:
  - Whidbey
category:
  - Software Development
comments: true
share: true
---

## No Control Required

[Download Code](http://aspalliance.com/download/521/code.zip)

My first stab at this, keeping things as simple as possible, was just to do it on a web form without the added complication of creating a custom control.  I'm storing the resulting selection in a database as in integer bitmask, where Sunday is 1 and Saturday is 64 (so values between 0000000 and 1111111 binary or 0 and 127 decimal are allowed).  To do this, all that's required is a simple CheckBoxList, with everything declared declaratively:

```markup
<asp:CheckBoxList ID="CheckBoxList1" Runat="server">
    <asp:ListItem Value="1">Sunday</asp:ListItem>
    <asp:ListItem Value="2">Monday</asp:ListItem>
    <asp:ListItem Value="4">Tuesday</asp:ListItem>
    <asp:ListItem Value="8">Wednesday</asp:ListItem>
    <asp:ListItem Value="16">Thursday</asp:ListItem>
    <asp:ListItem Value="32">Friday</asp:ListItem>
    <asp:ListItem Value="64">Saturday</asp:ListItem>
</asp:CheckBoxList>
<asp:Button ID="Button1" Runat="server" Text="Button" OnClick="Button1_Click" />
<br />
<asp:Label ID="Label1" Runat="server"></asp:Label>
```

Combine that with a bit of code to extract the bitmask and display it:

```csharp
int DaysOfWeekBitMask = 0;

void Button1_Click(object sender, EventArgs e)
{
    Label1.Text = "";
    foreach (ListItem item in CheckBoxList1.Items)
    {
        if (item.Selected)
        {
            DaysOfWeekBitMask += Int32.Parse(item.Value);
            Label1.Text += item.Text + ", ";
        }
    }
    Label1.Text += "Bitmask: " + DaysOfWeekBitMask + " (" + System.Convert.ToString(DaysOfWeekBitMask, 2).PadLeft(7, '0') + ")";
}
```

The result will look something like this:

![No Control Result](/img/DaysOfWeekNoControl.gif)

Simple.  However, I intend to use this functionality on several different pages, and potentially in different applications, so I want to make it a custom control so that I can just drag and drop it wherever I need it.  We'll look at how to do that next, with just a bare-bones simple example.

In a later article, I hope to take this a step further and make the control more flexible, so that a variety of listing options are supported (e.g. single vs. multi select using dropdown, ListBox, RadioButtonList, or CheckBoxList display modes).  For now, I'm simply extending the CheckBoxList, as you'll see on the next page.

## In Control - Extending the CheckBoxList

[Download Code](http://aspalliance.com/download/521/code.zip)

For the simplest case, we are just taking a CheckBoxList and hard-coding its contents.  We also want to add a couple of properties to save us some work with getting the bitmask data out of it, since that's the whole intent of the control (without that piece, it would hardly be worth writing a control to do this -- even with it it is barely worth it...).

So the first thing we need to do is inherit from the CheckBoxList control:

```csharp
public class DaysOfWeekSelector : System.Web.UI.WebControls.CheckBoxList
{
 ...
}
```

Next, we need to populate the control with the values we want.  However, we don't want to blow away the Items collection every time the control is rendered, since this would cause the control to lose its ViewState (if any).  The simplest way to do this is to only populate the control when it has no items, which we do in the OnLoad event (overriding and calling the CheckBoxList version of this method):

```csharp
protected override void OnLoad(EventArgs e)
{
    base.OnLoad(e);
    if (this.Items.Count == 0)
    {
        this.Items.Add(new ListItem("Sunday", "1"));
        this.Items.Add(new ListItem("Monday", "2"));
        this.Items.Add(new ListItem("Tuesday", "4"));
        this.Items.Add(new ListItem("Wednesday", "8"));
        this.Items.Add(new ListItem("Thursday", "16"));
        this.Items.Add(new ListItem("Friday", "32"));
        this.Items.Add(new ListItem("Saturday", "64"));
    }
}
```

Now we have the basic functionality.  Let's add our properties, which will do the only real work involved.  I want the bitmask, either as an integer or as a 7-digit 0-padded binary string.  So, we'll create two properties, DaysOfWeekBitMask and DaysOfWeekBitMaskString, and include functionality to get or set each of them:

```csharp
public int DaysOfWeekBitMask
{
    get
    {
        int daysOfWeekBitMask = 0;
        foreach (ListItem item in this.Items)
        {
            if (item.Selected)
            {
                daysOfWeekBitMask += Int32.Parse(item.Value);
            }
        }
        return daysOfWeekBitMask;
    }
    set
    {
        int daysOfWeekBitMask = value;
        foreach (ListItem item in this.Items)
        {
            if (IsBitSet(daysOfWeekBitMask, Int32.Parse(item.Value)))
            {
                item.Selected = true;
            }
            else
            {
                item.Selected = false;
            }
        }
    }
}

public string DaysOfWeekBitMaskString
{
    get
    {
        return System.Convert.ToString(DaysOfWeekBitMask, 2).PadLeft(7, '0');
    }
    set
    {
        DaysOfWeekBitMask = System.Convert.ToInt32(value, 2);
    }
}
```

One helper function worth noting is IsBitSet, which simply does a bitwise **AND** to determine if a particular position in the bitmask is set.  It's shown here:

```csharp
private bool IsBitSet(int bitmask, int bitpositionvalue)
{
    return (bitmask & bitpositionvalue) > 0;
}
```

I'm sure at some point I'll want to list out a comma separated list of which days were chosen, and overriding the ToString() method seems like the best place to put this:

```csharp
public override string ToString()
{
    System.Text.StringBuilder sb = new System.Text.StringBuilder(100);
    foreach (ListItem item in this.Items)
    {
        if (item.Selected)
        {
            sb.Append(item.Text);
            sb.Append(", ");
        }
    }
    if (sb.Length > 0)
    {
        return sb.ToString(0, sb.Length - 2);
    }
    return "";
}
```

Now, at this point, all that really remains is to try and keep the user from doing anything stupid.  Since this isn't a commercial control, I'm not going to go overboard here.  I expect the primary user to be me, or at least somebody who can figure out that this control's contents are not to be messed with (via DataBinding or manipulating the Items collection, for instance), but we'll add a couple checks just for good measure:

```csharp
public override void DataBind()
{
    throw new NotImplementedException();
}

protected override void OnPreRender(EventArgs e)
{
    base.OnPreRender(e);
    if (this.Items.Count != 7)
    {
        throw new InvalidOperationException("Days of Week Items cannot be manipulated.");
    }
}
```

To put this on a page, you would compile it into a DLL and then reference the DLL using the <%@ Register %> directive, specifying the tag prefix, assembly name (minus .dll extension), and namespace.  For example, if my namespace were AspAlliance.Web.Controls and my assembly were AspAlliance.Web.Controls.dll, then to use this control on a page I would add this directive to the top of the page:

```aspnet
<%@Register TagPrefix="AA" Namespace="AspAlliance.Web.Controls" 
Assembly="AspAlliance.Web.Controls" %>
```

Then, to place the control on the page, I would just use this code:

```aspnet
<AA:DaysOfWeekSelector ID="WeekDays" Runat="server" />
```

And finally, if I want to display the same text as I did on my no controls version, I would just need this code in my Page_Load:

```csharp
void Button1_Click(object sender, EventArgs e)
{
    Label1.Text = "Bitmask: " + WeekDays.DaysOfWeekBitMask + " (" + WeekDays.DaysOfWeekBitMaskString + ")";
}
```

**Note - Whidbey / ASP.NET 2.0**

In ASP.NET 2.0 you will be able to globally register controls by placing the necessary information in the web.config.  Scott Watermasysk describes the process [here](http://scottwater.com/blog/archive/2004/08/29/13121?Pending=true).  To add the necessary information for this control, you would use this code (inside the <system.web> tag):

```markup
<pages>
   <controls>
      <add tagPrefix="AA" namespace="AspAlliance.Web.Controls"/>
   </controls>
</pages>
```

[Download](http://aspalliance.com/download/521/code.zip) the source files used for this article (tested with Whidbey Beta 1 but the control code should work in .NET 1.1 and the pages will work with minimal modification).

Originally published on [ASPAlliance.com](http://aspalliance.com/521_Writing_a_Days_of_the_Week_Selector_Control.1).
