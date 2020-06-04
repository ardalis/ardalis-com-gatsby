---
templateKey: blog-post
title: Avoid Storing Database Credentials in Source Control
path: /avoid-storing-database-credentials-in-source-control
date: 2016-10-19
featuredpost: false
featuredimage: /img/storing-database-credentials.jpg
tags:
  - asp.net
  - asp.net core
  - database
  - git
  - security
  - source control
category:
  - Security
  - Software Development
comments: true
share: true
---
Your application probably needs to communicate with a database of some kind. Naturally, that database isn’t open to the world – it needs to be protected and secured. The typical solution to this is to create a username and password combination (ideally, specific to each application or user that requires access) and configure the application with these credentials. In many cases, they’re simply stored in configuration, such as thesection of web.config for an ASP.NET application. By default, such settings are stored in plaintext, and are checked into source control, which can have disastrous consequences (note: if you use GitHub and accidentally expose a secret publicly, you need to change it. Just [deleting it isn’t enough](http://jordan-wright.com/blog/2014/12/30/why-deleting-sensitive-information-from-github-doesnt-save-you/)). There are many different kinds of secrets an application might require, from database connection strings to API keys. For many, the ideal solution is to store the secrets in environment variables on the machine where the application runs, or in configuration files that are not part of the dev/build process but only exist on the machine where the application runs. For database connection strings in particular, one option to consider is configuring the environment so that no secrets are required.

## Using Trusted Connection

A trusted connection exists when the database server and the application server are running on the same windows network, and windows users can be authorized to access the database. In this case, the application is configured to run as a particular Windows account, and the database server is configured to grant this account access. The connection string doesn’t need to include any username or password information, and so can be stored in source control without fear of exposing secret data. The recommendation from Microsoft is, whenever possible, to [use Windows authentication](https://msdn.microsoft.com/en-us/library/ms144284.aspx) in this manner.

Once the application and database are configured, the connection string used for this authentication approach looks like this:

```
Server=serverName;Database=databaseName;Trusted_Connection=True;
```

That’s it – no username or password data. If the only secret your application has is its database connection string, you can avoid having to deal with other ways of managing application secrets with just this one simple approach. Configure and use trusted connections between your application and its database, and you no longer need to store credentials in your applications’s configuration files (in development or in production).