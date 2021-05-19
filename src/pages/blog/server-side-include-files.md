---
templateKey: blog-post
title: Using Server Side Include Files
date: 2000-09-25
path: blog-post
description: Server Side Include Files provide a simple way to reuse code in ASP applications. In this article, you will see how to implement them and when it's a good idea to use them.
featuredpost: false
featuredimage: /img/server-side-include.png
tags:
  - ASP.NET
category:
  - Software Development
comments: true
share: true
---

## Include Files

Server Side Includes (SSI) are a powerful tool for code re-use and to make site maintenance easier.  Include files can themsevles include other files, allowing for cascading include files. This can make it much easier for the developer to maintain a consistent site. One of the most popular uses for SSIs is to create uniform headers and footers, often with menu items. On a previous version of [AspAlliance.com](http://aspalliance.com/), I had both a standard header and a standard footer, which were referenced from one include file, called articleformat.asp.

Whenever possible, you should avoid simply including files inline in your ASP code. The reason for this is that if any variables are defined or changed in the included file, your ASP page may bomb due to a duplicate declaration or behave unexpectedly with the new variable's value. By using functions for all of your include files, you can place all of your includes at the top of your ASP file, where you can quickly see which files any given page depends on. Variables within the function are of local scope, so there is no need to use hacks like making up strange variable names in order to avoid name conflicts. Wherever you want to use the include file, you simply add a line of code invoking the function. For many of my library functions, I name the include file the same as the function to make it easy to tell which functions are in which files and what they're called.

## Sample Formatting Include File

My format include file:

```html
1    <!-- #include virtual="/ads/adshowaspa.asp"-->
2    <!-- #include virtual="/stevesmith/include/AmazonLink.asp"-->
3    <!-- #include virtual="/stevesmith/include/TitleCase.asp"-->
4    <%
5    
6    'Preserved for old interface
7    Sub ArticleHeader(title,javascript,css)
8     Call ArticleHeader2(title,javascript,css,"")
9    End Sub
10   
11   Sub ArticleHeader2(title,javascript,css,article_id)
12    Dim path
13    Dim index
14    Dim vpath
15    Dim querystring
16   %>
17   <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
18   "http://www.w3.org/TR/REC-html40/loose.dtd">
19   <html>
20   <head>
21   <!--#INCLUDE VIRTUAL="stevesmith/metainc.asp"-->
22   <title><%=title%></title>
23   <link type="text/css" rel="stylesheet" href="http://www.aspalliance.com/stevesmith/include/ss.css" /></head>
24   <script type="text/javascript">
25   <!--
26   <%=javascript%>
27   
28   function openEmailWin(){
29    winTech=window.open('http://www.aspalliance.com/stevesmith/email.asp','Email','height=350,width=500,toolbar=0,location=0,directories=0,status=0,menubar=0,resizable=1, scrollbar=1')
30   }
31   // -->
32   </script>
33   <% If css <> "" Then %>
34   <style type="text/css">
35   <!--
36   <%=css%>
37   -->
38   </style>
39   <% End If %>
40   <body topmargin="0" leftmargin="0"
41    marginwidth="0" marginheight="0" link="#0000ff" alink="#0000ff" vlink="#0000ff">
42   <%
43   If LCase(Request.Querystring("print_view")) <> "true" Then
44   %>
45   <table width="100%" cellpadding="4" cellpadding="0">
46   <TBODY>
47   <TR bgColor="#CC0000">
48    <TD height="50" width="80%" valign="absmiddle">
49    <table width="100%">
50    <tr>
51    <td align="center" width="145">
52    <a href=""><img
53    src="/libraryaspa/logocounter.asp?article_id=<%=article_id%>"
54    border="0" height="57" width="142" alt="ASPAlliance.com: The #1 ASP.NET Community"></a><br/>
55    <b>The ASPSmith</b>
56    </td>
57    <td align="center">
58    <% Call AdShowAspa() %>
59    </td>
60    </tr>
61    </table>
62    </TD>
63    <TD align="right" height="50" width="200">
64    <TABLE>
65    <TBODY>
66    <TR>
67    <TD class="small">
68    <FORM action="/search/default.asp" method="post" id="searchform"
69    name="searchform">
70    Search<BR>
71    <INPUT size="18" name="keyword">
72    </FORM>
73    </TD>
74    </TR>
75    </TBODY>
76    </TABLE>
77    </TD>
78   </TR>
79   </TBODY>
80   </TABLE>
81   <table width="100%" cellpadding="4" cellpadding="0">
82   <TBODY>
83    <TR bgColor="#000000">
84    <TD height="20" width="80%">
85    <span class="small">
86    <%
87    path = LCase(Request.Servervariables("path_translated"))
88    If InStr(1, path, "d:\domains\aspalliance.com\") Then
89    path = Replace(path, "d:\domains\aspalliance.com\", "")
90    vpath = "/"
91    %>
92    <A href="<%=vpath%>">ASPAlliance.com</A> |
93    <%
94    End If
95    If Left(path, 11) = "stevesmith\" Then
96    path = Replace(path, "stevesmith\", "")
97    vpath = vpath & "stevesmith/"
98   
99    dim stevehome
100    stevehome = vpath & "olddefault.asp"
101    %>
102    <a href="<%=stevehome%>">The ASPSmith Home</a> |
103    <%
104    End If
105    index = Instr(1, path, "\")
106    While index > 0
107    vpath = vpath & Left(path, index - 1) & "/"
108    Response.Write "<a href=""" & vpath & """>"
109    Response.Write TitleCase(Left(path, index - 1)) & "</a> | "
110    path = Right(path, len(path)-index)
111    index = Instr(1, path, "\")
112    Wend
113    %>
114    <%=title%>
115    </span>
116    </TD>
117    <TD align="right" height="20" width="200">
118    <div class="small">
119   <%
120    If Request.ServerVariables("QUERY_STRING") = "" Then
121    querystring = "?print_view=true"
122    Else
123    querystring = "?" & Request.ServerVariables("QUERY_STRING") & "&print_view=true"
124    End If
125   %>
126    <a href="<%=Request.ServerVariables("URL") & querystring %>"
127    target="_blank">Print View</a>
128    |
129    <a HREF="javascript:openEmailWin();"
130    onMouseOver="status='Feedback.'; return true;"
131    onMouseOut="status=''; return true;"
132    title="Feedback.">
133    Feedback
134    </a>
135    |
136    <a href="http://dotnetweblogs.com/ssmith/" target="weblog">My Blog</a>
137    </div>
138    </TD>
139    </TR>
140   </TBODY>
141   </TABLE>
142   <table width="100%" cellpadding="4" cellpadding="0" bgcolor="#FFFFFF">
143   <tr>
144    <td width="80%" align="left" valign="top">
145    <div class="articletitle"><%=title%></div><br />
146    <% if LCase(title) <> "table of contents" then %>
147    <div class="authorblock">By Steven Smith</div><br />
148    <% end if %>
149   <%
150    Else
151    'Print View
152   %>
153   <table width="600" bgcolor="#FFFFFF">
154    <tr>
155    <td align="center"><h2>The ASPSmith Articles, ASPAlliance.com</h2></td>
156    </tr>
157    <% if Len(title) > 0 then %>
158    <tr>
159    <td align="center"><div class="articletitle"><%=title%></div><br/>
160    <% if LCase(title) <> "table of contents" then %>
161    <div class="authorblock">By Steven Smith</div>
162    <% end if %>
163    </td>
164    </tr>
165    <% end if %>
166    <tr>
167    <td align="center">
168    <b>http://www.aspalliance.com<%=Request.ServerVariables("URL")%></b>
169    </td>
170    </tr>
171    <tr>
172    <td>
173   <%
174    End If
175   End Sub
176   %>
177   
178   <%
179   Sub ArticleFooter()
180    Dim filepath ' This file's path
181    Dim objFSO
182    Dim objFile ' An instance of the file object
183    Dim modify_date
184    Dim create_date
185   
186    filepath = Request.ServerVariables("PATH_TRANSLATED")
187    Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
188    Set objFile = objFSO.GetFile(filepath)
189    modify_date = objFile.DateLastModified
190    create_date = objFile.DateCreated
191   
192    If LCase(Request.QueryString("print_view")) <> "true" Then
193   %>
194    </td>
195    <td align="right" valign="top" width="200">
196    <iframe src="http://ads.aspalliance.com/displayad.aspx?m=1&amp;t=6&amp;s=ROOT&amp;page=1" target=_parent" height="125" width="125"
197    marginwidth="0" marginheight="0" hspace="0" vspace="0" frameborder="0" scrolling="no"><script language="javascript"
198    src="http://ads.aspalliance.com/displayad.aspx?t=6&amp;m=1&amp;target=_parent&amp;js=1&amp;s=ROOT&amp;page=1"></script></iframe>
199    <br/><br/>
200    <% Call AdShowSmall() %>
201    <br /><br/>
202   <%
203    Call AmazonLink ("0672325241", _
204    "ASP.NET Developer's Cookbook, By Steven Smith, Rob Howard, ASPAlliance.com", _
205    "", _
206    true, "center")
207   %>
208    <br /><br/>
209   <%
210    Call AmazonLink ("0789725622", _
211    "ASP.NET By Example, By Steven Smith", _
212    "", _
213    true, "center")
214   %>
215    <br />
216    <br />
217    <% Call AdShowSmall() %>
218    <br/>
219    <br/>
220    <iframe src="http://ads.aspalliance.com/displayad.aspx?m=1&amp;t=5&amp;s=ROOT&amp;page=1" target=_parent" height="125" width="125"
221    marginwidth="0" marginheight="0" hspace="0" vspace="0" frameborder="0" scrolling="no"><script language="javascript"
222    src="http://ads.aspalliance.com/displayad.aspx?t=5&amp;m=1&amp;target=_parent&amp;js=1&amp;s=ROOT&amp;page=1"></script></iframe>
223    </td>
224   </tr>
225   </table>
226   <table width="100%" cellpadding="0" cellspacing="0">
227    <tr>
228    <td colspan="2" width="100%" align="center">
229    <hr color="red" width="90%" align="center" />
230    </td>
231    </tr>
232    <tr>
233    <td align="left" valign="top" width="30%">
234    <div class="authorblock">
235    <a HREF="javascript:openEmailWin();"
236    onMouseOver="status='Send email to Steve.'; return true;"
237    onMouseOut="status=''; return true;"
238    title="Send email to Steve."
239    >Steven Smith, MCSE + Internet (4.0)</a><br />
240    <b>Last Modified:</b> <%=modify_date%><br />
241    <b>History:</b> <%=create_date%>
242    </div>
243    <img src="/stevesmith/images/clear.gif" height="1" width="300" alt="">
244    </td>
245    <td align="center" valign="top" width="70%">
246    <% 'Call AdShowAspa %>
247   <%
248   End If 'non-print-view
249   %>
250    </td>
251    </tr>
252   </table>
253   </body>
254   </html>
255   <%
256   End Sub
257   %>
```

## Usage Recommendations

Anything that you will use on more than one page is a good candidate for placing in an include file. Menus should ALWAYS be include files if they are not in a separate frame (which is a whole different subject). Also, it is a good idea to declare all of the variables in your include files, so that all pages that call it using OPTION EXPLICIT will work.  (Actually, an even better practice is to always wrap everything you put in an include file in a Sub/Function -- this will avoid the possibility of having duplicate variable declarations if an include file happens to be included twice)

Microsoft has acknowledged problems with the "\*.inc" naming convention of include files. It is possible for users to access the source code of these files, depending on what version of IIS you are running. The fix is to name all include files with the "\*.asp" extension. A common naming convention is to append "inc" to the end of the filename before the extension. So for example, the standard include file with all of ADO's constant names is "adovbs.inc". This would be renamed to "adovbsinc.asp". Another common practice is to throw all of the include files for a web site into a "/include/" subdirectory off of the main page. This makes accessing them simple regardless of what directory you are accessing them from. By doing this, you can easily reference all of your include files using VIRTUAL paths, making it easier to maintain your site when you move ASP files from one directory to another (which would break FILE paths if the depth of the ASP file in the directory structure changed). One last note -- any server side Sub or Function that you might use on more than one page should go into an include file.

## Resources

[ASP Mailing Lists](http://aspadvice.com/)

[Include Files on W3 Schools](http://www.w3schools.com/asp/asp_incfiles.asp)

Originally published on [ASPAlliance.com](http://aspalliance.com/656_Using_Server_Side_Include_Files)
