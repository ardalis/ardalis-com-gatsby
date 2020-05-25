---
templateKey: blog-post
title: Could Not Load Type Microsoft.Build.Framework.BuildEventContext
path: blog-post
date: 2010-03-10T12:36:00.000Z
description: Could Not Load Type Microsoft.Build.Framework.BuildEventContext
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Microsoft framework
category:
  - Uncategorized
comments: true
share: true
---
Setting up a [TeamCity](http://www.jetbrains.com/teamcity) build and got this error:

> C:Program FilesMSBuildMicrosoftVisualStudiov9.0TeamDataMicrosoft.Data.Schema.SqlTasks.targets(80, 5): error MSB4018: The "SqlSetupDeployTask" task failed unexpectedly.\
> System.TypeLoadException: Could not load type ‘Microsoft.Build.Framework.BuildEventContext’ from assembly ‘Microsoft.Build.Framework, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a’.\
> at Microsoft.Build.BuildEngine.TaskExecutionModule.SetBatchRequestSize()\
> at Microsoft.Build.BuildEngine.TaskExecutionModule..ctor(EngineCallback engineCallback, TaskExecutionModuleMode moduleMode, Boolean profileExecution)\
> at Microsoft.Build.BuildEngine.NodeManager..ctor(Int32 cpuCount, Boolean childMode, Engine parentEngine)\
> at Microsoft.Build.BuildEngine.Engine..ctor(Int32 numberOfCpus, Boolean isChildNode, Int32 parentNodeId, String localNodeProviderParameters, BuildPropertyGroup globalProperties, ToolsetDefinitionLocations locations)\
> at Microsoft.Build.BuildEngine.Engine.get_GlobalEngine()\
> at Microsoft.Data.Schema.Build.DeploymentProjectBuilder.CreateDeploymentProject()\
> at Microsoft.Data.Schema.Tasks.DBSetupDeployTask.BuildDeploymentProject(ErrorManager errors, ExtensionManager em)\
> at Microsoft.Data.Schema.Tasks.DBSetupDeployTask.Execute()\
> at Microsoft.Build.BuildEngine.TaskEngine.ExecuteTask(ExecutionMode howToExecuteTask, Hashtable projectItemsAvailableToTask, BuildPropertyGroup projectPropertiesAvailableToTask, Boolean& taskClassWasFound)
>
>

The usual searching didn’t bring back anything useful, but I figured out that I’d missed a dropdownlist in the TeamCity project setup:

![](/img/framework.png)

Originally I was using Microsoft .NET Framework 2.0 for my MSBuild task. Changing it to 3.5 (as shown above) got me past this error (and on to the next one…).