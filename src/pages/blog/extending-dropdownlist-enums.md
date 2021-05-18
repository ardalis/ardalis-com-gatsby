---
templateKey: blog-post
title: Extending the DropDownList to Support Enums
date: 2007-12-04
path: blog-post
description: In this article, Steve demonstrates how to bind a DropDownList to an Enum type, and then goes on to create a generic EnumDropDownList control which will automatically display any enum type's contents.
featuredpost: false
featuredimage: /img/dropdown-enums.png
tags:
  - Enums
  - enumerables
category:
  - Productivity
  - Software Development
comments: true
share: true
---

## Introduction

A fairly common task in some of the applications I work with is to provide a user with a DropDownList of options that is populated by an enum.  This can easily be done with a little bit of code to bind a stock DropDownList control to the enum, but this kind of thing quickly starts to violate the DRY ([Don't Repeat Yourself](https://deviq.com/principles/dont-repeat-yourself)) principle, so I created a simple derived DropDownList control that takes advantage of Generics to make it especially effective and require less code and casting of data types.

## Binding a Standard DropDownList to an Enum

Before we delve into the derived DropDownList, consider the code that it is meant to replace.  Let's say that we have an enum that describes Status, and has possible values of Active, Inactive, Pending, and Declined.  We'll say these are for Proposal, so we'll call the enum ProposalStatus.

#### Listing 1: ProposalStatus enum

```csharp
public enum ProposalStatus
{
  Active =1,
  Inactive = 2,
  Pending = 3,
  Declined = 4
}
```

Now if we want to render a DropDownList that uses this enum as its data source, we would use code like the following:

#### Listing 2: Binding Names to DropDownList

```csharp
if (!Page.IsPostBack)
{
  ProposalStatusDropDownList.DataSource = 
  Enum.GetNames(typeof(ProposalStatus));
  ProposalStatusDropDownList.DataBind();
}
```

This will render a DropDownList with display and value both as the name of the enum – the value is not stored in the DropDownList.  To get at the value, you would use code like this:

#### Listing 3: Getting a Strongly Typed Enum Value from the DropDownList

```csharp
protected void Button1_Click(object sender, EventArgs e)
{
  ProposalStatus myStatus = (ProposalStatus)Enum.Parse(
    typeof(ProposalStatus), ProposalStatusDropDownList.SelectedValue);
  Label1.Text = myStatus.ToString();
}
```

Of course, if you actually want to store the enum’s numeric value as the value of the DropDownList, the most effective way to achieve that is to load up a `SortedList<int,string>` with the values and their corresponding names, and then DataBind to this collection.  This is easily done with a helper method like the one shown in Listing 4.  Note that since we cannot use where `T:System.Enum` the best we can do is constrain T to be a struct and then do a type check in code to verify it inherits from Enum.

#### Listing 4: Convert ENum to SortedList<string,int> Collection

```csharp
public static SortedList<string, int> GetEnumDataSource<T>() where T:struct
{
    Type myEnumType = typeof(T);
    if (myEnumType.BaseType != typeof(Enum))
    {
        throw new ArgumentException("Type T must inherit from System.Enum.");
    }
 
    SortedList<string, int> returnCollection = new SortedList<string, int>();
    string[] enumNames = Enum.GetNames(myEnumType);
    for (int i = 0; i < enumNames.Length; i++)
    {
        returnCollection.Add(enumNames[i],
            (int)Enum.Parse(myEnumType, enumNames[i]));
    }
    return returnCollection;
}
```

Then to use this method with a DropDownList we would use code like what is shown in Listing 5.

#### Listing 5: Bind to SortedList from Enum

```csharp
ProposalStatusDropDownList2.DataSource =
GetEnumDataSource<ProposalStatus>();
ProposalStatusDropDownList2.DataValueField = "Value";
ProposalStatusDropDownList2.DataTextField = "Key";
ProposalStatusDropDownList2.DataBind();
```

## Creating a Generic Enum DropDownList

Now that we’ve written a bunch of code to show how anybody can do this to a stock DropDownList control, let’s roll all of this code into a single reusable control, the `EnumDropDownList`.  One additional requirement we’ll add to this control is that it optionally include a `ListItem` that simply displays “All” and has no associated enum value.  We’ll use this when the `DropDownList` is being used to display filters on search results or reports, and in this case the “All” value will mean that we don’t want to filter by this enum.  Similarly, to make our filtering easier, we’ll also include a nullable integer property, `SelectedIntegerValue`, since the data access layer is going to expect integer values for the statuses we choose to filter on (or null if none).  The control will include the `GetEnumDataSource<T>` method shown earlier, and of course this could be refactored out into a separate utility class where it would make more sense.  I’ve included it in `EnumDropDownList` to make the sample easier to follow.  The complete source for `EnumDropDownList` is shown in Listing 6.

#### Listing 6: EnumDropDownSource

```csharp
public class EnumDropDownList<T> : DropDownList where T : struct
{
    private bool _showAllOption = true;
    public bool ShowAllOption
    {
        get
        {
            return _showAllOption;
        }
        set
        {
            _showAllOption = value;
        }
    }
    public new T? SelectedValue
    {
        get
        {
            if (String.IsNullOrEmpty(this.SelectedItem.Text))
            {
                return null;
            }
            return (T)Enum.Parse(typeof(T), this.SelectedItem.Text);
        }
    }
    public int? SelectedIntegerValue
    {
        get
        {
            if (ShowAllOption && this.SelectedIndex == 0)
            {
                return null;
            }
            if (String.IsNullOrEmpty(this.SelectedItem.Text))
            {
                return null;
            }
            return (int)Enum.Parse(typeof(T), this.SelectedValue.ToString());
        }
    }
 
    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        if (typeof(T).BaseType != typeof(Enum))
        {
            throw new ArgumentException("Type T must inherit from System.Enum.");
        }
        BindData();
    }
 
    protected void BindData()
    {
        this.DataSource = GetEnumDataSource<T>();
        this.DataTextField = "Key";
        this.DataValueField = "Value";
        this.DataBind();
        if (ShowAllOption)
        {
            this.Items.Insert(0, new ListItem("All", ""));
        }
    }
 
    public static SortedList<string, int> GetEnumDataSource<T>() where T : new()
    {
        Type myEnumType = typeof(T);
        if (myEnumType.BaseType != typeof(Enum))
        {
            throw new ArgumentException("Type T must inherit from System.Enum.");
        }
 
        SortedList<string, int> returnCollection = new SortedList<string, int>();
        string[] enumNames = Enum.GetNames(myEnumType);
        for (int i = 0; i < enumNames.Length; i++)
        {
            returnCollection.Add(enumNames[i],
                (int)Enum.Parse(myEnumType, enumNames[i]));
        }
        return returnCollection;
    }
}
```

Now to use this control, unfortunately you can’t simply add markup to the ASPX page.  Some [options were discussed by Mikhail at Microsoft](http://blogs.msdn.com/mikhailarkhipov/archive/2004/08/18/216957.aspx) but I can’t find that anything was ever implemented up through ASP.NET 3.5.  Thus, you can only instantiate this control from your C# or VB code, and then add it to the page using a Placeholder control or similar technique.  This is fairly minor, however, and the resulting code in the page’s codebehind is shown in Listing 7.  PlaceHolder1 is defined on the page where we want the DropDownList to be shown.

#### Listing 7: Rendering the Control in a PlaceHolder

```csharp
protected EnumDropDownList<ProposalStatus> ProposalStatusDropDownList1;
protected override void OnInit(EventArgs e)
{
  base.OnInit(e);
  ProposalStatusDropDownList1 = new EnumDropDownList<ProposalStatus>();
  this.PlaceHolder1.Controls.Add(ProposalStatusDropDownList1);
}
```

## Downloads

You can download the source for this sample [here](http://aspalliance.com/download/1514/EnumDropDownList.zip).

## Resources

[How to Bind Enum to DropDownList](http://geekswithblogs.net/jawad/archive/2005/06/24/EnumDropDown.aspx)

[Use Enum as DataSource for DropDownList](http://weblog.rebex.cz/blogs/honzas/archive/2006/04/25/1289.aspx)

[Generic Enum To List Converter](http://devlicio.us/blogs/joe_niland/archive/2006/10/10/Generic-Enum-to-List_3C00_T_3E00_-converter.aspx)

[Why We Need Where T:Enum Constraint](http://kirillosenkov.blogspot.com/2007/09/why-do-we-need-where-t-enum-generic.html)

## Conclusion

In this article, Steve demonstrated how to create a generic Enum DropDownList control with the help of a sample application.

Originally published on [ASPAlliance.com](http://aspalliance.com/1514_Extending_the_DropDownList_to_Support_Enums)
