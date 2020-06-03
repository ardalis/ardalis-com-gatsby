---
templateKey: blog-post
title: Untrusted Projects and Blocked Files in Visual Studio
path: blog-post
date: 2010-02-25T12:19:00.000Z
description: Untrusted Projects and Blocked Files in Visual Studio
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - visual studio
category:
  - Uncategorized
comments: true
share: true
---
I was just trying to open a project I was emailed as a zip file from a colleague. VS2010 opens up saying:

> `You should only open projects from a trustworthy source. The project file 'project' may have come from a location that isn’t fully trusted. It could represent a security risk by executing customer build steps when opened in Microsoft Visual Studio that could cause damage to your computer or compromise your private information.`

Which is fine… but in this case I know the project is OK so I click the box and tell it to get on with it. Next, I try to run the project, but I am faced with this:

> Error 1 The "ValidateXaml" task failed unexpectedly.\
> System.IO.FileLoadException: Could not load file or assembly ‘file:///C:UsersSteveDownloadsSomeFile.dll’ or one of its dependencies. Operation is not supported. (Exception from HRESULT: 0x80131515)\
> File name: ‘file:///C:UsersSteveDownloadsSomeFile.dll’ —> System.NotSupportedException: An attempt was made to load an assembly from a network location which would have caused the assembly to be sandboxed in previous versions of the .NET Framework. This release of the .NET Framework does not enable CAS policy by default, so this load may be dangerous. If this load is not intended to sandbox the assembly, please enable the loadFromRemoteSources switch. See <http://go.microsoft.com/fwlink/?LinkId=155569>for more information.
>
> at System.Reflection.RuntimeAssembly._nLoad(AssemblyName fileName, String codeBase, Evidence assemblySecurity, RuntimeAssembly locationHint, StackCrawlMark& stackMark, Boolean throwOnFileNotFound, Boolean forIntrospection, Boolean suppressSecurityChecks)\
> at System.Reflection.RuntimeAssembly.nLoad(AssemblyName fileName, String codeBase, Evidence assemblySecurity, RuntimeAssembly locationHint, StackCrawlMark& stackMark, Boolean throwOnFileNotFound, Boolean forIntrospection, Boolean suppressSecurityChecks)\
> at System.Reflection.RuntimeAssembly.InternalLoadAssemblyName(AssemblyName assemblyRef, Evidence assemblySecurity, StackCrawlMark& stackMark, Boolean forIntrospection, Boolean suppressSecurityChecks)\
> at System.Reflection.RuntimeAssembly.InternalLoadFrom(String assemblyFile, Evidence securityEvidence, Byte\[] hashValue, AssemblyHashAlgorithm hashAlgorithm, Boolean forIntrospection, Boolean suppressSecurityChecks, StackCrawlMark& stackMark)\
> at System.Reflection.Assembly.LoadFrom(String assemblyFile)\
> at Microsoft.Silverlight.Build.Tasks.ValidateXaml.XamlValidator.Execute(ITask task)\
> at Microsoft.Silverlight.Build.Tasks.ValidateXaml.XamlValidator.Execute(ITask task)\
> at Microsoft.Silverlight.Build.Tasks.ValidateXaml.Execute()\
> at Microsoft.Build.BackEnd.TaskExecutionHost.Microsoft.Build.BackEnd.ITaskExecutionHost.Execute()\
> at Microsoft.Build.BackEnd.TaskBuilder.ExecuteInstantiatedTask(ITaskExecutionHost taskExecutionHost, TaskLoggingContext taskLoggingContext, TaskHost taskHost, ItemBucket bucket, TaskExecutionMode howToExecuteTask, Boolean& taskResult)

Naturally I go to the [URL it references which talks about loadFromRemoteSources](http://go.microsoft.com/fwlink/?LinkId=155569)but in my case this is no help, and in any event is a red herring that hides the real issue.

**Windows Wants Me To Be Safe**

…even if it means I can’t do my work. It turns out that Visual Studio’s warning wasn’t enough to protect me, but Windows was blocking many of the files I needed for this project to run. There are a few ways you can fix this – if you’ve already unzipped the project and there are only a couple of such DLLs, you can open each one in Windows Explorer, select Properties, and then click the Unblock button as shown below:

[![unblock downloaded files](/img/unlock-download.png)

Note that if you **Unblock the zip file first, then everything you unzip out of it will also be unblocked**, so this is the way to go. Another option, if you have a FAT/FAT32/exFAT file system drive handy (say, a USB Flash Drive), is to simply copy the files to and then from such a drive (it will lose any knowledge of having been blocked, etc. in the transfer).

There’s a good write-up with [some additional information on Scott Frolich’s post to the Falafel blog about Windows Blocked Files](http://blog.falafel.com/2009/12/18/WindowsBlockedFilesVisualStudio2010AndNET4.aspx), too.
