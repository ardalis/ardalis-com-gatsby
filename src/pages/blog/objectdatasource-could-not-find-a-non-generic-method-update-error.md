---
templateKey: blog-post
title: ObjectDataSource could not find a non-generic method Update Error
path: blog-post
date: 2007-02-17T16:46:07.626Z
description: So I’m writing a quick demo for a book chapter, and I want to use
  something close to best practices, so I’m eschewing the SqlDataSource and
  favoring the ObjectDataSource.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - ObjectDataSource
  - ASP.NET
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

So I’m writing a quick demo for a book chapter, and I want to use something close to best practices, so I’m eschewing the SqlDataSource and favoring the ObjectDataSource. Because this is meant to be a quick example I don’t want to spend a lot of time helping the reader get the database set up, so I’m using the built-in ASPNETDB.MDF database that gets created in App_Data when you select the Web Site Configuration Wizard, and I’m going to edit the aspnet_Roles table using a GridView.

After creating a TableAdapter by adding a new DataSet to my project and creating the necessary Select, Update, Insert, and Delete columns, I wire up my GridView to an ObjectDataSource that uses this TableAdapter resulting in code like this:

<!--EndFragment-->

```
<%@ Page Language=”C#” AutoEventWireup=”true” CodeFile=”Default.aspx.cs” Inherits=”_Default” %>

<!DOCTYPE html PUBLIC “-//W3C//DTD XHTML 1.1//EN” “http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd”>
<html xmlns=”http://www.w3.org/1999/xhtml”>
<head runat=”server”>

<title>Untitled Page</title>
</head>
<body>

<form id=”form1″ runat=”server”>

<asp:ScriptManager ID=”ScriptManager1″ runat=”server” />

<div>

<asp:GridView ID=”GridView1″ runat=”server” AllowSorting=”True” AutoGenerateColumns=”False”

DataKeyNames=”ApplicationId,LoweredRoleName” DataSourceID=”RolesDataSource”>

<Columns>

<asp:CommandField ShowEditButton=”True” />

<asp:BoundField DataField=”ApplicationId” HeaderText=”ApplicationId” ReadOnly=”True”

SortExpression=”ApplicationId” />

<asp:BoundField DataField=”RoleId” HeaderText=”RoleId” SortExpression=”RoleId” />

<asp:BoundField DataField=”RoleName” HeaderText=”RoleName” SortExpression=”RoleName” />

<asp:BoundField DataField=”LoweredRoleName” HeaderText=”LoweredRoleName” ReadOnly=”True”

SortExpression=”LoweredRoleName” />

<asp:BoundField DataField=”Description” HeaderText=”Description” SortExpression=”Description” />

</Columns>

</asp:GridView>

<asp:ObjectDataSource ID=”RolesDataSource” runat=”server” DeleteMethod=”Delete” InsertMethod=”Insert”

OldValuesParameterFormatString=”original_{0}” SelectMethod=”GetData” TypeName=”RolesTableAdapters.aspnet_RolesTableAdapter”

UpdateMethod=”Update”>

<DeleteParameters>

<asp:Parameter Name=”Original_ApplicationId” Type=”Object” />

<asp:Parameter Name=”Original_LoweredRoleName” Type=”String” />

</DeleteParameters>

<UpdateParameters>

<asp:Parameter Name=”ApplicationId” Type=”Object” />

<asp:Parameter Name=”RoleId” Type=”Object” />

<asp:Parameter Name=”RoleName” Type=”String” />

<asp:Parameter Name=”LoweredRoleName” Type=”String” />

<asp:Parameter Name=”Description” Type=”String” />

<asp:Parameter Name=”Original_ApplicationId” Type=”Object” />

<asp:Parameter Name=”Original_LoweredRoleName” Type=”String” />

</UpdateParameters>

<InsertParameters>

<asp:Parameter Name=”ApplicationId” Type=”Object” />

<asp:Parameter Name=”RoleId” Type=”Object” />

<asp:Parameter Name=”RoleName” Type=”String” />

<asp:Parameter Name=”LoweredRoleName” Type=”String” />

<asp:Parameter Name=”Description” Type=”String” />

</InsertParameters>

</asp:ObjectDataSource>

 

</div>

</form>
</body>
</html>
```

<!--StartFragment-->

Of course when I go to test it out, I get this:



# Server Error in ‘/BeginningASPNETAJAX’ Application.



- - -



## *ObjectDataSource ‘RolesDataSource’ could not find a non-generic method ‘Update’ that has parameters: RoleId, RoleName, Description, original_ApplicationId, original_LoweredRoleName.*

Some quick searching results in a LOT of hits:

[Brady Gaster with Screenshots](http://weblogs.asp.net/bradygaster/archive/2006/09/26/How-to-Bloody-Your-Forehead.aspx)\
[Forum Thread](http://forums.asp.net/1/1386717/ShowThread.aspx)\
[Another Forum Thread](http://forums.asp.net/1217763/ShowPost.aspx)\
[Another Forum Thread](http://www.dotnetjunkies.com/Forums/ShowPost.aspx?PostID=9995)\
[Another Forum Thread](http://forums.microsoft.com/msdn/showpost.aspx?postid=10179&siteid=1)

At one point (in a comment to Brady)[Scott Guthrie](http://weblogs.asp.net/scottgu)suggests that the DataKeyNames property should resolve this issue, but it does not, at least when the keys are Guid values rather than ints or strings (one of the forum posters suggested the DataKeyNames collection doesn’t support object typed keys).

[G. Andrew Duthie](http://blogs.msdn.com/gduthie) has a summary of [how to fix this issue on his blog](http://blogs.msdn.com/gduthie/archive/2005/06/18/430504.aspx) (from 2005, no less). His workarounds:\
1) Don’t make the keys ReadOnly. **Bad. Bad. Bad. Mega Lame.**\
**2) Modify the Update query (by hand) so that it doesn’t update the key columns.**

To do approach #2, go to the DataSet, click on the TableAdapter and select F4 to open its Properties dialog. Then expand its UpdateCommand property and remove the key colums from the “UPDATE col1= @col1” portion of the query (e.g. **don’t remove the keys from the WHERE part of the query!!!**). You will also want to remove the key parameters from the UpdateCommand’s Parameters collection.

This is a real hassle since the whole reason I’m using the Data Adapters is to keep things simple for the reader, since the whole setup of the GridView and Data Source is really just a prelude to what I’m really trying to show, which in this case is ASP.NET AJAX functionality. However, that seems to be the most reasonable fix since making the key columns editable just screams **HACK**. I have no earthly idea why the Update command wants to update the key columns by default. I would think that **99% of the time this will be completely wrong**, and if you happen to fall into that 1% case then you’re probably going to think it reasonable that you add the key column(s) to the update command yourself.

After making these changes, my page works, and my ObjectDataSource looks like so (compare to above):

<!--EndFragment-->

```
<asp:ObjectDataSource ID=”RolesDataSource” runat=”server” DeleteMethod=”Delete” InsertMethod=”Insert”

OldValuesParameterFormatString=”original_{0}” SelectMethod=”GetData” TypeName=”RolesTableAdapters.aspnet_RolesTableAdapter” UpdateMethod=”Update”>

<DeleteParameters>

<asp:Parameter Name=”Original_ApplicationId” Type=”Object” />

<asp:Parameter Name=”Original_LoweredRoleName” Type=”String” />

</DeleteParameters>

<InsertParameters>

<asp:Parameter Name=”ApplicationId” Type=”Object” />

<asp:Parameter Name=”RoleId” Type=”Object” />

<asp:Parameter Name=”RoleName” Type=”String” />

<asp:Parameter Name=”LoweredRoleName” Type=”String” />

<asp:Parameter Name=”Description” Type=”String” />

</InsertParameters>

<UpdateParameters>

<asp:Parameter Name=”RoleId” Type=”Object” />

<asp:Parameter Name=”RoleName” Type=”String” />

<asp:Parameter Name=”Description” Type=”String” />

<asp:Parameter Name=”Original_ApplicationId” Type=”Object” />

<asp:Parameter Name=”Original_LoweredRoleName” Type=”String” />

</UpdateParameters>

</asp:ObjectDataSource>
```

<!--StartFragment-->

\[categories: ObjectDataSource, ASP.NET]

<!--EndFragment-->