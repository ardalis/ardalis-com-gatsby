---
templateKey: blog-post
title: Set Up Build Agents By Project in TeamCity
path: blog-post
date: 2010-07-06T13:02:00.000Z
description: "We’re using TeamCity to manage our continous integration builds
  for CodeProject.com and LakeQuincy.com.  Before TeamCity, I was using
  CruiseControl.net, and TeamCity is much easier to get working (and requires
  far less XML manipulation). "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - continuous integration
  - devops
  - teamcity
category:
  - Software Development
comments: true
share: true
---
We’re using TeamCity to manage our continous integration builds for CodeProject.com and LakeQuincy.com. Before TeamCity, I was using CruiseControl.net, and TeamCity is much easier to get working (and requires far less XML manipulation). I do miss CCTray, which I found to be much nicer than the TeamCity tray notifier (which if you click on it never shows anything immediately – it has to go and get it which imposes a delay – it also doesn’t do sounds like CCTray does – but I digress).

Let’s say you have several large projects and you want them to run on the same instance of TeamCity. Let’s further assume that some of these build configurations do a lot of stuff, and thus might take 10 minutes or more to run, while others are for relatively small projects or web sites that might take 30 seconds or less to run. If you were to check in one of these small sites, hoping to quickly see the build server turn green, you would be rather frustrated if your timing were poor and you had to wait 10 minutes for a larger project that was unrelated to your project to finish its build. Beyond the frustration, this causes a very real and negative impact on your productivity.

**Options**

1) Create another build server. The TeamCity tray notifier can now [talk to more than one instance of TeamCity](http://confluence.jetbrains.net/display/TCD5/How+To...#HowTo...-InstallMultipleAgentsontheSameMachine) (though I haven’t tried it myself), so this would be one option if you have the hardware available.

2) Add another build agent. The agent does the real work of building your projects, and you can install multiple agents based on your license of TeamCity. These can live on the same server or on different machines. **This is the approach I’m demonstrating here**.

3) Live with it. This is the default approach, of course, and is listed only to make you think this is an exhaustive list of options.

**Installing an Agent**

Assuming you already have TeamCity set up and running, installing a new agent is pretty simple. If you click on Administration, you should see a link just below the search bar to Install Build Agents, like this:

![image](<> "image")

**Before you do anything, you should read about configuring this new agent!**

Specifically, there are some notes on things you need to know about installing multiple agents on the same machine. [Read them here](http://confluence.jetbrains.net/display/TCD5/How+To...#HowTo...-InstallMultipleAgentsontheSameMachine).

Assuming you’re on a windows machine, you can go ahead and use the MS Windows Installer.

Make sure you edit the launcherconfwrapper.conf file and change the following properties so they are unique among your agents:

* wrapper.console.title
* wrapper.ntservice.name
* wrapper.ntservice.displayname

If you don’t modify these, then what will happen is your new agent will give your old agent the boot, as it were, and you’ll still have only one agent running on the machine as a service, but it will be pointing at the new folders you told it to use for the second agent.

Also, if you find yourself faced with an error when trying to create or delete a service using the scripts for doing so that are included in the agent folders, try closing the services.msc dialog. I found that it was preventing me from deleting some services (that I was trying to then recreate).

**Specify Build Agents for Projects**

Having two (or more) build agents is great, but now all that’s going to happen is every project will just get picked up by whichever agent happens to be free. And each agent will need to have a working copy of every project, which multiplies the disk space needed and the traffic with the VCS server. If you have large projects, these can be real concerns. So how do you specify that a particular agent should be associated only with a certain set of projects? Through the use of [agent environment variables, as discussed here](http://www.thinkplexx.com/learn/howto/build-chain/ci/set-environment-and-properties-for-teamcity-build-agent-reconnect-use-them-in-projects).

Specifically, in the **buildAgent.properties** file (in the **/conf** folder), you can add your own user defined values. Here’s an example of the configuration file for the Lake Quincy build agent:

```
name=LQ Build Agent
ownPort=9091
serverUrl=http:<span style="color: #008000">//localhost:90</span>
workDir=D:TeamCityLQBuildAgentWork
tempDir=D:TeamCityLQBuildAgentTemp
#User defined properties
env.lakequincy=<span style="color: #0000ff">true</span>
env.TEAMCITY_JRE=C:Program FilesJavajre6
```

Notice the env.lakequincy value. What it’s set to is actually not important, as you’ll see in a moment. You’ll want to add such an environment variable to each agent, designating which kinds of projects it should work on.

Next, in TeamCity’s web interface, go to each of your projects and update their Agent Requirements (configuration step 7). In my case, I’m going to **Add requirement for a variable**and say that the project’s agent must have an environment variable called env.lakequincy and that it must exist.

![image](<> "image")

Once this is done, you should see the correct build agents listed as Compatible, and all others listed as Incompatible, with the reason listed for the incompatibility:

![image](<> "image")

**Summary**

It’s pretty easy to get continuous integration working with TeamCity, and very easy to add additional agents to a single server (using unique paths and service names). If you want to dedicate some agents to certain projects or tasks, you can easily do so by using environment variables as shown here.