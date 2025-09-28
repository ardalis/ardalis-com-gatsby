---
title: SQLite Error IDbCommand and IDbConnection implementation in the assembly
date: "2010-02-26T07:16:00.0000000-05:00"
description: SQLite Error IDbCommand and IDbConnection implementation in the
featuredImage: img/sqlite-error-idbcommand-and-idbconnection-implementation-in-the-assembly-system-data-sqlite-could-not-be-found-featured.png
---

I just ran into a problem with SQLite and NHibernate, which was giving me this error message:

> The IDbCommand and IDbConnection implementation in the assembly System.Data.SQLite could not be found.

The strange thing was, it worked fine from within Visual Studio, but it died when I used my ClickToBuild.bat file, which calls msbuild and runs my tests from the command line. A bit of searching led me to [a similar problem on StackOverflow](http://stackoverflow.com/questions/1460045/sql-data-sqllite-version-with-nhibernate-2-1), which produced the answer:

**Use the x64 binaries.**

I downloaded the [latest version of SQLite (SQLite-1.0.65.0-binaries.zip)](http://sourceforge.net/projects/sqlite-dotnet2)and made sure to use the.dll in the x64 folder, and the problem disappeared. It's worth noting that I'm running on Windows 7 x64. I'm assuming that since Visual Studio 2008 is still in the dark ages and only runs as a 32-bit application, that's the reason why this issue only appeared outside of Visual Studio.

