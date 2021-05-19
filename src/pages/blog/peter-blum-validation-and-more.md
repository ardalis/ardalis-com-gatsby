---
templateKey: blog-post
title: Review - PeterBlum.com Validation and More Controls
date: 2005-12-22
path: blog-post
description: In this review, Steve Smith details what you get in the box with Peter Blum's Validation and More controls, presents and example, and proffers his opinion on the matter.
featuredpost: false
featuredimage: /img/validation-and-more.png
tags:
  - reviews
category:
  - Software Development
comments: true
share: true
---

## Overview

Validation controls have been one of my favorite features of ASP.NET since I first saw it previewed (back when it was still ASP+). Coming from an ASP background, where integration of client- and server-side validation was, to be kind, tedious, I was eager to put these controls to the test. Initially, I was very pleased with the controls, but with time it became clear that they were "a good start" and were not really sufficient for many real world validation requirements (without resorting to custom validators and a lot of custom code, anyway). Enter Peter Blum's suite of validation controls (and more!), [Professional Validation and More](http://peterblum.com/VAM/Home.aspx) 3.0.3.

More than just validators, this suite of over 40 ASP.NET controls is designed to replace and extend the ASP.NET data entry control set, making it much easier to collect data from web forms and drastically improving your users' experience. The latest version (3.0.3 at the time of writing) is fully compatible with Visual Studio 2005 and .NET 2.0. For this review, I actually tested the controls in both VS 2003 and VS 2005 (and ASP.NET 1.1 and 2.0).

## Installation and Versions

Version 3.0.3 of Professional Validation and More was used for this review (and 3.0.1 for the VS 2003 portion). It is currently priced at $200/server for the complete suite, although individual portions of the suite may be purchased for less than that a la carte. See the Pricing and Licensing section for more details. Free 30-day trial downloads are available, as are site, redistribution, and source code licenses.

After running the .msi installer file and clicking through the usual setup wizard, the first thing you'll want to do is open the Installation Guide PDF from the Start-Programs-Professional Validation and More menu. You will find that unlike many simple components, installation of VAM requires a few more steps. To quote the Installation Guide:

*"Many custom controls are installed more quickly than Professional Validation And More ("VAM"). That's because you only have an assembly to put in the \bin folder and add to the Visual Studio.net or Web Matrix Toolbox. VAM provides more design time and runtime files to save you development time, such as client-side scripts, images, and style sheets. Some will be installed into each web application. Others will be installed into each development computer."*

Basically, Peter has developed enhancements to the VS 2003 design mode which are installed with the VAM product via the ASP.NET Design Mode Extender (ADME). Installing this piece allows the VAM package to behave correctly during development, and is quite straightforward and well-documented. VS 2005 does not require this step.

Incidentally, while you're looking up the Installation Guide, you'll see there are a number of other PDF documents in the Start Menu folder for VAM. One thing Peter Blum's products excel at, in my experience, is documentation. If you actually take a little time to read the various Users Guide and Tutorial documents, your experience with his products should be very smooth.

### Wrapping Up Installation VS.NET 2003

After installing ADME in VS.NET 2003, I launch VS.NET and create a new test web application, `VAMTest`. Creating the web in VS.NET prompts me with an ADME dialog which lets me set some application specific paths used by the VAM controls. The defaults are fine for my purposes. Next I add the controls to my VS.NET toolbox following the instructions in the Installation Guide. To quote the last step: "A large number of controls are added." Indeed. I count 49.

Finally, copy the contents of the once-more-appropriately-named folder "Copy To Web Application Folder" to your - you guessed it - web application folder. In this case, that's c:\inetpub\wwwroot\VAMTest. This just drops a folder called "VAM" into your web application root. Add your license(s) to the Licenses folder under VAM. Then use VS.NET's Add Reference dialog to reference the VAM assemblies and you're ready to start using the controls.

### Wrapping Up Installation VS.NET 2005

After installing VAM (and skipping the ADME step), I launch VS.NET 2005 and create a new Web Site. I add the controls to the toolbox using the instructions in the documentation, copy the "Copy To Web Application Folder" VAM folder to my application, and drop my license file into the /VAM/Licenses/ folder. Voila! Drag a few controls on the page and things start working.

The installation documents, in particular the Installation Guide, have everything you need to get started. If you're not sure at any point, try reading the guide. You'll probably find the answer.

## What's Included

The suite includes several collections of controls, organized into separately purchasable modules. Full descriptions of these modules are available on the [Professional Validation and More home page](http://peterblum.com/VAM/Home.aspx), but they are briefly summarized here:

- VAM: Essential Validators includes 14 validator controls to cover most common scenarios, with extensive cross-browser support.
- VAM: Specialized Validators includes 11 specialized validator controls for advanced scenarios like validating credit card numbers.
- VAM: Data Entry Controls includes 5 TextBox controls with client-side features to greatly enhance user experience.
- VAM: Client-Side Toolkit provides a number of valuable client-side features.
- VAM: Visual Input Security<sup>TM</sup> protects your web application from hackers by guarding user input methods against many attacks, including SQL Injection and Cross-Site Scripting.

Probably the best way to see all of these pieces in action is to visit the all-inclusive [Fancy Form Demo on PeterBlum.com](http://peterblum.com/VAM/DemoAll.aspx). It shows off many of the features unique to these controls, with a great deal of built-in documentation to help call out these features as you interact with the demo.

A good way to see these features in action yourself, after installing everything, is to open up the Tutorials PDF and go through a few of them. The 49 page document includes 15 step-by-step walkthroughs which are very helpful in getting you quickly up to speed with using these controls. Several common (frequently asked questions) issues with validation are covered within these tutorials, including these:

- Display Validators only when certain conditions are met
- Require one Checkbox within many DataGrid Rows
- Setting up multiple validation groups/regions on a web form

In addition to these commonly requested techniques, the VAM suite addresses many other limitations of the built-in ASP.NET validation controls, including:

- Conditionally disabling validators
- Combining validation rules, such as making a field required only when another form element has a particular value
- Providing a single error message if any of several validators fail
- Using graphics within error messages
- Dynamic values within error messages (e.g. "The value you entered, 'foo', is not an Integer.")
- Inability to evaluate an empty TextBox with a RegularExpressionValidator
- Clicking a Reset button does not remove validator messages

More limitations of the built-in ASP.NET validation controls addressed by VAM are described [here](http://peterblum.com/VAM/ValMain.aspx).

One suggestion I'll make for users of the VAM Suite is to break up the controls into several tabs in the toolbox; 49 or so controls in one tab is just a bit much. I would split them up into VAM: Validators and VAM: Data Entry, which makes it easier to find what you're after, in my opinion. You can do this in VS.NET (all versions) by clicking Add Tab in the Toolbox, naming the new tab, and then simply dragging and dropping the appropriate controls into this new tab.

Feature-wise, I've only scratched the surface in this overview (and in my own use). The suite includes a *ton* of functionality and usability enhancements. Just by skimming the "Whats New in Version 3" document, which is 7 pages long, I find dozens of features and enhancements that have been made to this already mature set of controls.

## One Real Example

I want to demonstrate the effectiveness of this suite of controls with at least one concrete example. In this case, I'm going to mock up a Human Resources form that might be used within a company to track information about employees. Some of the fields included are Age, Gender, Date Began With Company, Salary, etc. Some will be a bit contrived just to exercise the validators a bit.

For this scenario, I've established the following business rules:

- Full Name is required
- Age is a positive integer
- Weight is a positive decimal number (I know, no HR person would track weight. Maybe it's for a sports team)
- Annual Salary must be a currency type
- Date Began With Company is required and must be properly formatted
- Date Terminated must follow Date Began, and must be properly formatted
- W9 On File is a checkbox (in case this "employee" is actually a contractor). It is not required but if it is checked, then the location of the electronic W9 document must be specified
- File Location is required, but only if the W9 On File checkbox is checked
- Notes free text, up to 256 characters

I implemented all of the above in less than an hour using a variety of VAM controls for data entry and validation. The Age, Weight, and Salary fields are using IntegerTextBox, DecimalTextBox, and CurrencyTextBox controls, respectively, which means only appropriate values can be entered (so the validators on these fields are generally redundant, but a good idea in case a downlevel browser or hacker avoids the masking built into the textbox controls). One of the cooler features I utilized was the Enabler property and the FieldStateController control. Using these two features, it is relatively straightforward to create dependencies between control visibility or read-only state and the value or validation status of other controls. For instance, the Required validator on the File Location field is only enabled if the W9 On File checkbox is checked. Similarly, the File Location textbox is only visible and write-enabled when the W9 On File checkbox is checked. Since I see people asking how to dynamically enable/disable validators on forums and mailing lists every day, this feature alone is one I know there is a lot of demand for.

#### Listing 1: Usage Example

```html
<%@ Page Language="C#" AutoEventWireup="true" %>
<%@ Register Assembly="PeterBlum.VAM" Namespace="PeterBlum.VAM" TagPrefix="VAM" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
    <head id="Head1" runat="server">
        <title>ACME: Edit Employee Profile</title>
        <link href="/VAM/Appearance/VAMStylesheet.css" type="text/css" rel="stylesheet" />
    </head>

    <body>
        <form id="form1" runat="server">
            <div>
                <strong>Update Employee Profile<br /></strong>
                <VAM:RequiredFieldsDescription ID="RequiredFieldsDescription1" runat="server"></VAM:RequiredFieldsDescription>
                <br />
                <table style="width: 600px">
                    <tr>
                        <td style="width: 175px; height: 23px;">
                            Full Name
                            <VAM:RequiredFieldMarker ID="RequiredFieldMarker1" runat="server"></VAM:RequiredFieldMarker>
                        </td>
                        <td style="width: 300px; height: 23px;">
                            <VAM:TextBox ID="FullNameTextBox" runat="server" Width="300px"></VAM:TextBox>
                        </td>
                        <td style="width: 200px; height: 23px">
                        <VAM:RequiredTextValidator ID="RequiredTextValidator1" runat="server" ControlIDToEvaluate="FullNameTextBox" ErrorMessage="Full name is required." ShowRequiredFieldMarker="True">
                            <ErrorFormatterContainer>
                                <VAM:TextErrorFormatter />
                            </ErrorFormatterContainer>
                        </VAM:RequiredTextValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 175px; height: 21px;">Age</td>
                        <td style="width: 100px; height: 21px;">
                            <VAM:IntegerTextBox ID="IntegerTextBox1" runat="server" TabIndex="1" Width="60px"></VAM:IntegerTextBox>
                        </td>
                        <td style="width: 100px; height: 21px">
                            <VAM:DataTypeCheckValidator ID="DataTypeCheckValidator4" runat="server" ControlIDToEvaluate="IntegerTextBox1" DataType="Positive Integer" ErrorMessage="Age must be a positive integer.">
                                <ErrorFormatterContainer>
                                    <VAM:TextErrorFormatter />
                                </ErrorFormatterContainer>
                            </VAM:DataTypeCheckValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 175px">Weight</td>
                        <td style="width: 100px">
                            <VAM:DecimalTextBox ID="DecimalTextBox1" runat="server" TabIndex="2" Width="60px"></VAM:DecimalTextBox>
                        </td>
                        <td style="width: 100px">
                            <VAM:DataTypeCheckValidator ID="DataTypeCheckValidator5" runat="server" ControlIDToEvaluate="DecimalTextBox1" DataType="Positive Double" ErrorMessage="Weight must be a positive decimal.">
                                <ErrorFormatterContainer>
                                    <VAM:TextErrorFormatter />
                                </ErrorFormatterContainer>
                            </VAM:DataTypeCheckValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 175px">Annual Salary</td>
                        <td style="width: 100px">
                            <VAM:CurrencyTextBox ID="CurrencyTextBox1" runat="server" TabIndex="3"></VAM:CurrencyTextBox>
                        </td>
                        <td style="width: 100px">
                            <VAM:DataTypeCheckValidator ID="DataTypeCheckValidator3" runat="server" ControlIDToEvaluate="CurrencyTextBox1" DataType="Currency with symbol" ErrorMessage="Salary must be currency.">
                                <ErrorFormatterContainer>
                                    <VAM:TextErrorFormatter />
                                </ErrorFormatterContainer>
                            </VAM:DataTypeCheckValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 175px">
                            Date Began w/Company
                            <VAM:RequiredFieldMarker ID="RequiredFieldMarker2" runat="server"></VAM:RequiredFieldMarker>
                        </td>
                        <td style="width: 100px">
                            <VAM:FilteredTextBox ID="StartDateTextBox" runat="server" Digits="True" OtherCharacters="/" TabIndex="4"></VAM:FilteredTextBox>
                        </td>
                        <td style="width: 100px">
                        <VAM:RequiredTextValidator ID="RequiredTextValidator3" runat="server" ControlIDToEvaluate="StartDateTextBox" ErrorMessage="Date Began is required." ShowRequiredFieldMarker="True">
                            <ErrorFormatterContainer>
                                <VAM:TextErrorFormatter />
                            </ErrorFormatterContainer>
                        </VAM:RequiredTextValidator>
                        <VAM:DataTypeCheckValidator ID="DataTypeCheckValidator1" runat="server" ControlIDToEvaluate="StartDateTextBox" DataType="Date" ErrorMessage="Invalid Date Format.">
                            <ErrorFormatterContainer>
                                <VAM:TextErrorFormatter />
                            </ErrorFormatterContainer>
                        </VAM:DataTypeCheckValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 175px">Date Terminated</td>
                        <td style="width: 100px">
                            <VAM:FilteredTextBox ID="EndDateTextBox" runat="server" Digits="True" OtherCharacters="/" TabIndex="5"></VAM:FilteredTextBox>
                        </td>
                        <td style="width: 100px">
                            <VAM:CompareTwoFieldsValidator ID="CompareTwoFieldsValidator1" runat="server" ControlIDToEvaluate="EndDateTextBox" DataType="Date" ErrorMessage="End Date cannot occur before Begin Date." Operator="GreaterThanEqual" SecondControlIDToEvaluate="StartDateTextBox">
                                <ErrorFormatterContainer>
                                    <VAM:TextErrorFormatter />
                                </ErrorFormatterContainer>
                            </VAM:CompareTwoFieldsValidator>
                            <VAM:DataTypeCheckValidator ID="DataTypeCheckValidator2" runat="server" ControlIDToEvaluate="EndDateTextBox" DataType="Date" ErrorMessage="Invalid Date Format.">
                                <ErrorFormatterContainer>
                                    <VAM:TextErrorFormatter />
                                </ErrorFormatterContainer>
                            </VAM:DataTypeCheckValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 175px">W9 On File?</td>
                        <td style="width: 100px">
                            <asp:CheckBox ID="W9OnFileCheckBox" runat="server" TabIndex="6" Width="111px" />
                        </td>
                        <td style="width: 100px"></td>
                    </tr>
                    <tr>
                        <td style="width: 175px">
                            File Location
                            <VAM:RequiredFieldMarker ID="RequiredFieldMarker3" runat="server"></VAM:RequiredFieldMarker>
                        </td>
                        <td style="width: 100px">
                            <VAM:TextBox ID="W9FileLocationTextBox" runat="server"></VAM:TextBox>
                        </td>
                        <td style="width: 100px">
                            <VAM:RequiredTextValidator ID="RequiredTextValidator2" runat="server" ControlIDToEvaluate="W9FileLocationTextBox" Enabler="CheckStateCondition: W9OnFileCheckBox is checked" ErrorMessage="This field is required if W9 on file is checked." ShowRequiredFieldMarker="True">
                                <EnablerContainer>
                                    <VAM:CheckStateCondition ControlIDToEvaluate="W9OnFileCheckBox" Name="CheckStateCondition" />
                                </EnablerContainer>
                                <ErrorFormatterContainer>
                                    <VAM:TextErrorFormatter />
                                </ErrorFormatterContainer>
                            </VAM:RequiredTextValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 175px"></td>
                        <td style="width: 100px"></td>
                        <td style="width: 100px"></td>
                    </tr>
                    <tr>
                        <td style="width: 175px; height: 46px;">
                        Notes (256 char max)</td>
                        <td style="width: 100px; height: 46px;">
                            <VAM:TextBox ID="NotesTextBox" runat="server" Height="71px" MaxLength="300" Rows="5" TextMode="MultiLine" Width="299px"></VAM:TextBox>
                        </td>
                        <td style="width: 100px; height: 46px;">
                            <VAM:TextLengthValidator ID="TextLengthValidator1" runat="server" ControlIDToEvaluate="NotesTextBox" ErrorMessage="Notes cannot exceed 256 characters." Maximum="256">
                                <ErrorFormatterContainer>
                                    <VAM:TextErrorFormatter />
                                </ErrorFormatterContainer>
                            </VAM:TextLengthValidator>
                        </td>
                    </tr>
                </table>
            </div>
            <VAM:ValidationSummary ID="ValidationSummary1" runat="server" HeaderText="Please correct the following:" />
            <VAM:FieldStateController ID="W9FileLocationFieldStateController1" runat="server" Condition="CheckStateCondition: W9OnFileCheckBox is checked" ConditionFalse-ReadOnly="True" ConditionFalse-Visible="False" ControlIDToChange="W9FileLocationTextBox">
                <ConditionContainer>
                    <VAM:CheckStateCondition ControlIDToEvaluate="W9OnFileCheckBox" Name="CheckStateCondition" />
                </ConditionContainer>
            </VAM:FieldStateController>
            <br />
            <VAM:Button ID="SaveButton" runat="server" Text="Save" />
        </form>
    </body>
</html>
```

## Summary and Resources

Overall, I spent several hours working with VAM and found it to be very well-documented and intuitive. The data entry controls provide a much richer user experience than standard HTML form controls, and the validation controls are leaps and bounds better than the ASP.NET 1.x validation control suite. [ASP.NET 2.0 addresses a few of the most glaring issues with the 1.x validators](http://beta.aspalliance.com/QuickStart/aspnet/doc/validation/default.aspx), such as introducing validation groups, but doesn't come close to approaching the flexibility and features provided by the VAM suite. In the future, I will certainly use the VAM suite instead of the built-in validation controls, and you may expect to see VAM controls soon in certain areas of [AspAlliance.com](http://aspalliance.com/).

If you do any data entry web form development, this suite of controls is worthy of your attention (at least worth less than an hour to download and play with the free trial). The per-server license price of $200 is very reasonable, and is certainly less than it would cost for any reasonably-paid developer to build even one of these controls. As with [Peter's Date Package](http://aspalliance.com/657), I'm very impressed with this product from [PeterBlum.com](http://peterblum.com/).

If you're looking for more information, check out [the PeterBlum Message Board (Yahoo Group)](http://groups.yahoo.com/group/peterblum).

[Anand's Review of Peter's Validation and More](http://aspalliance.com/65) (older version) (2 October 2003)

[Solving the Challenges of ASP.NET Validation](http://aspalliance.com/699) (1 August 2005)

[PeterBlum.com Message Board](http://groups.yahoo.com/group/peterblum/)

[ASP.NET Validation Controls QuickStarts Tutorial](http://authors.aspalliance.com/quickstart/aspplus/doc/webvalidation.aspx)

[ASP.NET 2.0 Validation Controls QuickStarts Tutorial](http://beta.aspalliance.com/QuickStart/aspnet/doc/validation/default.aspx)

Originally published on [ASPAlliance.com](http://aspalliance.com/747_Review_PeterBlumcom_Validation_and_More_Controls)
