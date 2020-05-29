---
templateKey: blog-post
title: Add Profile Items in CreateUserWizard and Recursive FindControl
path: blog-post
date: 2006-08-24T02:54:55.951Z
description: There's an example in Professional ASP.NET 2.0 that shows how to
  add a few profile items to a CreateUserWizard. Unfortunately, it doesn't work
  in certain cases, specifically when the profile item in question is set to
  allowAnonymous="false".
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - C#
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

There's an example in Professional ASP.NET 2.0 that shows how to add a few profile items to a CreateUserWizard. Unfortunately, it doesn't work in certain cases, specifically when the profile item in question is set to allowAnonymous="false". When that happens, you will receive this error:

**"This property cannot be set for anonymous users."**

One fix is to simply set the allowAnonymous flag to true, but if it's not something you want anonymous users to be able to set, that's not ideal. Another thing that can be tricky is referencing your Textbox (or other web form) controls within the CreateUserWizard. I'll cover that next.

For the profile issue, the fix is to create a local instance of ProfileCommon, as described in this thread on [Updating Profile of Created User](http://aspalliance.com/groups/microsoft_public_dotnet_framework/ng-395881_Update_Profile_of_Created_User.aspx).

Walter Wang \[MSFT] Writes:

I think you can create and save the profile manually after you created the user:

```csharp
ProfileCommon p = (ProfileCommon) ProfileCommon.Create(username, true);
p.UserInfo.UserEmail = UserName.Text;
…
```

One thing he leaves out in the … is this line, which is needed to actually save the profile data:

> **p.Save();**

That works, but what about if your profile item's textbox is inside the CreateUserWizard control? In that case, you need to get a reference to the textbox (let's call it **FullNameTextBox**). One option to do this is to use some code like this:

```csharp
// get an instance of the FullName textbox from the wizard's controls hierarchy.
TextBox FullNameTextBox = CreateUserWizard1.WizardSteps\[0].Controls\[0].Controls\[0].Controls\[0].Controls\[0].FindControl("FullName")asTextBox;
if(FullNameTextBox!=null)
{

Profile.FullName = FullNameTextBox.Text;

}
```

Unfortunately this is some very hard to read, and hard to maintain, code. It's very brittle. Wouldn't it be nice if FindControl() actually recursed through the Controls() collection of each control in a hierarchy? Well, it just so happens that my buddy[Ambrose Little](http://dotnettemplar.net/) has some code that will do just this, which he was nice enough to share with me (and which I'm sharing with you). Replace the above ugliness with this code (which also includes the ProfileCommon fix):

```csharp
protectedvoidCreateUserWizard1_CreatedUser(objectsender,EventArgse)
{
// get an instance of the FullName textbox from the wizard's controls hierarchy.
TextBoxFullNameTextBox =FindControl(CreateUserWizard1,"FullName")asTextBox;
if(FullNameTextBox!=null)
{
ProfileCommonp = (ProfileCommon)ProfileCommon.Create(((CreateUserWizard)sender).UserName,true);

p.FullName = FullNameTextBox.Text;

p.Save();

}

}
```

You can see that I'm now using the FindControl() method, which is defined at Page level (put it in your BasePage class, or call it statically from some Common class, which is what I'm actually doing). Here is the code:

```csharp
///<summary>
///Returns a control if one by that name exists in the hierarchy of the controls collection of the start control
///</summary>
///<param name="start"></param>
///<param name="id"></param>
///<returns></returns>

System.Web.UI.ControlFindControl(System.Web.UI.Controlstart,stringid)
{
  System.Web.UI.ControlfoundControl;
  if(start !=null)
  {
    foundControl = start.FindControl(id);
    if(foundControl !=null)
      return foundControl;
    foreach(Controlcinstart.Controls)
    {
      foundControl = FindControl(c, id);
        if(foundControl !=null)
          return foundControl;
    }
  }
  return null;
}
```

<!--EndFragment-->