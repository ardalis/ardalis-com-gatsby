---
templateKey: blog-post
title: Web Application Project Conversion Tips
path: blog-post
date: 2007-01-23T17:30:14.846Z
description: I upgraded a major website (Visual Studio Web Site Project) to a
  Web Application Project on VS2005 SP1 today. I ran into three snags that are
  worth mentioning.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - WAP
  - VS2005
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I upgraded a major website (Visual Studio Web Site Project) to a Web Application Project on VS2005 SP1 today. I ran into three snags that are worth mentioning. Before I get to those, however, make sure if you’re going to do this conversion yourself that you follow [these steps](http://webproject.scottgu.com/CSharp/Migration2/Migration2.aspx).

1) After conversion, I was getting errors with all of my (formerly) App_Code files. They had been moved to Old_App_Code by the convert to web project tool, but they were not being built. I was able to cause compile errors by adding garbage characters to the .cs files, so I thought they were being compiled, but in reality they weren’t. After some minutes of trying to resolve the issue, I opened up the .csproj file in a text editor and noticed that all of these .cs files were listed in <Content /> tags instead of in <Compile /> tags. So I reloaded the project and in solution explorer I clicked on the files and changed their Build Action (in the Properties dialog) to Compile from Content. Problem solved.

2) This got me from having 67 errors (all base page classes not found on my 67 web pages) to about 900 errors, all of which were:

**The name 'CardNumberTextBox' does not exist in the current context**

or something similar. Since I had run the Convert to Web Application tool on the whole project, I had foolishly assumed that it would, in fact, run on the whole project. However, after some additional investigation I discovered one thing in common with all of the pages that were getting these “does not exist in the current context” errors: they were missing .designer.cs files. Re-running the Convert to Web Application wizard on these files individually removed their errors, proving that this was the issue. Re-running it on the whole project seemed to get more, but not all, of the pages. By combining re-running this tool and re-building (along with adding missing references) I eventually got .designer.cs files for all of my ASPX pages, which resolved this issue. I think a variety of missing project references caused the initial failure of the project-wide tool.

3) In the course of correcting the issues with #2, I ran into a chicken-and-egg problem. I had pages that included references to custom controls which were (previously) defined in my App_Code. Now these controls existed in a folder called /code in my WAP project, but the project hadn’t successfully built yet. Unfortunately, a bunch of pages that used these custom control could not have their designer file generated because they were getting Unknown server tag: ‘LQ:LQLinkButton’ errors. Can’t build the project (which has this control) until the designer files are in place. Can’t generate the designer files until the control is built.

I figured there were two possible solutions to this:\
a) Move my controls to their own library. Probably the best option, but my solution had a bunch of projects in it already, and I’m trying not to exacerbate that problem, so I thought I’d try option b first.\
b) Exclude all the pages that use my controls from the project, get it to build, and then re-add them one at a time and re-gen their designer files.

Option b did in fact work for me (although it took a while). Further complicating my migration was my use of the Profile object, a [workaround](http://www.gotdotnet.com/workspaces/workspace.aspx?id=406eefba-2dd9-4d80-a48c-b4f135df4127) for which is described in [ScottGu’s Migration Guide](http://webproject.scottgu.com/CSharp/Migration2/Migration2.aspx). [Rick Strahl also has some good notes](http://west-wind.com/WebLog/posts/5378.aspx), and the [forums are a good place to look or ask questions](http://forums.asp.net/1019/ShowForum.aspx), too.

One more note – I also had issues referencing things withing templated controls, such as the PasswordRecovery control. Previously in the codebehind I could refer to EmailTextBox just fine, but with WAP I can’t, even after adding the .designer.cs file. The solution is to use [Recursive FindControl](http://ardalis.com/blogs/ssmith/archive/2006/08/23/Add-Profile-Items-in-CreateUserWizard-and-Recursive-FindControl.aspx)to do it, like so:

<!--EndFragment--><!--StartFragment-->

TextBox EmailTextBox = Common.FindControl(this.PasswordRecovery1,"EmailTextBox")asTextBox;

if(EmailTextBox !=null)

{

email = EmailTextBox.Text;

name = Membership.GetUserNameByEmail(email);

}

On the plus side, once the 2–3 hours of conversion effort were completed, the project builds MUCH faster…



{

email = EmailTextBox.Text;

name = Membership.GetUserNameByEmail(email);

}

On the plus side, once the 2–3 hours of conversion effort were completed, the project builds MUCH faster…

{

email = EmailTextBox.Text;

name = Membership.GetUserNameByEmail(email);

}

On the plus side, once the 2–3 hours of conversion effort were completed, the project builds MUCH faster…



if(EmailTextBox !=null)

{

email = EmailTextBox.Text;

name = Membership.GetUserNameByEmail(email);

}

On the plus side, once the 2–3 hours of conversion effort were completed, the project builds MUCH faster…



{

email = EmailTextBox.Text;

name = Membership.GetUserNameByEmail(email);

}

On the plus side, once the 2–3 hours of conversion effort were completed, the project builds MUCH faster…

{

email = EmailTextBox.Text;

name = Membership.GetUserNameByEmail(email);

}

On the plus side, once the 2–3 hours of conversion effort were completed, the project builds MUCH faster…

if(EmailTextBox !=null)

{

email = EmailTextBox.Text;

name = Membership.GetUserNameByEmail(email);

}

On the plus side, once the 2–3 hours of conversion effort were completed, the project builds MUCH faster…



{

email = EmailTextBox.Text;

name = Membership.GetUserNameByEmail(email);

}

On the plus side, once the 2–3 hours of conversion effort were completed, the project builds MUCH faster…

{

email = EmailTextBox.Text;

name = Membership.GetUserNameByEmail(email);

}

On the plus side, once the 2–3 hours of conversion effort were completed, the project builds MUCH faster…

this.PasswordRecovery1,"EmailTextBox")asTextBox;

if(EmailTextBox !=null)

{

email = EmailTextBox.Text;

name = Membership.GetUserNameByEmail(email);

}

On the plus side, once the 2–3 hours of conversion effort were completed, the project builds MUCH faster…



{

email = EmailTextBox.Text;

name = Membership.GetUserNameByEmail(email);

}

On the plus side, once the 2–3 hours of conversion effort were completed, the project builds MUCH faster…

{

email = EmailTextBox.Text;

name = Membership.GetUserNameByEmail(email);

}

On the plus side, once the 2–3 hours of conversion effort were completed, the project builds MUCH faster…

if(EmailTextBox !=null)

{

email = EmailTextBox.Text;

name = Membership.GetUserNameByEmail(email);

}

On the plus side, once the 2–3 hours of conversion effort were completed, the project builds MUCH faster…



\[categories:WAP,VS2005]

<!--EndFragment-->