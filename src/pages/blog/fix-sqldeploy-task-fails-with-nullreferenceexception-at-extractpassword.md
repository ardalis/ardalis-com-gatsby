---
templateKey: blog-post
title: "Fix: SqlDeploy Task Fails with NullReferenceException at ExtractPassword"
path: blog-post
date: 2010-03-10T08:52:00.000Z
description: >-
  Still working on getting a [TeamCity] build working Latest exception is:

  > *C:Program FilesMSBuildMicrosoftVisualStudiov9.0TeamDataMicrosoft.Data.Schema.SqlTasks.targets(120, 5): error MSB4018: The "SqlDeployTask" task failed unexpectedly.*
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - SQL
category:
  - Uncategorized
comments: true
share: true
---
Still working on getting a [TeamCity](http://www.jetbrains.com/teamcity) build working ([see my last post](/could-not-load-type-microsoft-build-framework-buildeventcontext)). Latest exception is:

> *C:Program FilesMSBuildMicrosoftVisualStudiov9.0TeamDataMicrosoft.Data.Schema.SqlTasks.targets(120, 5): error MSB4018: The "SqlDeployTask" task failed unexpectedly.\
> System.NullReferenceException: Object reference not set to an instance of an object.\
> at Microsoft.Data.Schema.Common.ConnectionStringPersistence.ExtractPassword(String partialConnection, String dbProvider)\
> at Microsoft.Data.Schema.Common.ConnectionStringPersistence.RetrieveFullConnection(String partialConnection, String provider, Boolean presentUI, String password)\
> at Microsoft.Data.Schema.Sql.Build.SqlDeployment.ConfigureConnectionString(String connectionString, String databaseName)\
> at Microsoft.Data.Schema.Sql.Build.SqlDeployment.OnBuildConnectionString(String partialConnectionString, String databaseName)\
> at Microsoft.Data.Schema.Build.Deployment.FinishInitialize(String targetConnectionString)\
> at Microsoft.Data.Schema.Build.Deployment.Initialize(FileInfo sourceDbSchemaFile, ErrorManager errors, String targetConnectionString)\
> at Microsoft.Data.Schema.Build.DeploymentConstructor.ConstructServiceImplementation()\
> at Microsoft.Data.Schema.Extensibility.ServiceConstructor`1.ConstructService()\
> at Microsoft.Data.Schema.Tasks.DBDeployTask.Execute()\
> at Microsoft.Build.BuildEngine.TaskEngine.ExecuteInstantiatedTask(EngineProxy engineProxy, ItemBucket bucket, TaskExecutionMode howToExecuteTask, ITask task, Boolean& task Result)*
>
>

This time searching yielded some good stuff, including [this thread that talks about how to resolve this via permissions](http://social.msdn.microsoft.com/Forums/en-US/vstsdb/thread/a7e08143-f7b8-4647-9758-33fb13176e12). The short answer is that the account that your build server runs under needs to have the necessary permissions in SQL Server. You’ll need to create a Login and then ensure at least the minimum rights are configured as described here:

[Required Permissions in Database Edition](http://msdn.microsoft.com/en-us/library/aa833413.aspx)

Alternately, you can just make your build server account an admin on the database (which is probably running on the same machine anyway) and at that point it should be able to do whatever it needs to.

If you’re certain the account has the necessary permissions, but you’re still getting the error, the problem may be that the account has never logged into the build server. In this case, there won’t be any entry in the HKCU hive in the registry, which the system is checking for permissions (see this [thread](http://social.msdn.microsoft.com/Forums/fi-FI/vstsdb/thread/595f847a-b900-460d-9071-414f5a0750d3)). The solution in this case is quite simple: log into the machine (once is enough) with the build server account. Then, open Visual Studio (thanks [Brendan](http://brendan.enrick.com/)for the answer in [this thread](http://social.msdn.microsoft.com/Forums/en/vstsdb/thread/a0f97df1-50b4-491e-85de-3dac105056df?prof=required)).

**Summary**

1. Make sure the build service account has the necessary database permissions
2. Make sure the account has logged into the server so it has the necessary registry hive info
3. Make sure the account has run Visual Studio at least once so its settings are established

In my case I went through all 3 of these steps before I resolved the problem.