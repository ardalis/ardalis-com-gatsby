---
templateKey: blog-post
title: Configure Grunt in Visual Studio 2015
path: blog-post
date: 2015-04-06T14:27:00.000Z
description: "You can easily configure Grunt to perform client-side build tasks
  in Visual Studio 2015. Grunt is very similar to Gulp, and either one can be
  used with Visual Studio 2015 to perform a variety of tasks. "
featuredpost: false
featuredimage: /img/vs-grunt-760x339.png
tags:
  - grunt
  - visual studio
category:
  - Software Development
comments: true
share: true
---
# Configure Grunt in Visual Studio 2015

You can easily configure [Grunt](http://gruntjs.com/) to perform client-side build tasks in Visual Studio 2015. Grunt is very similar to [Gulp](http://gulpjs.com/), and either one can be used with Visual Studio 2015 to perform a variety of tasks. Although it’s supported, you need to add it to the project as a dependency before you can start working with Grunt. In this example, we are going to configure Grunt to process files and place them where we want them in the project’s wwwroot folder.

First, we need to make sure Grunt is installed locally for the project. This is accomplished using NPM, which is similar to Bower but requires a different configuration file, “package.json”. Add a new NPM configuration file to the root of the project, called package.json. Add the “grunt” and “grunt-bower-task” items to the devDependencies property, as shown (you should get Intellisense as you type their names):

```
"devDependencies": {
	"grunt": "0.4.5",
	"grunt-bower-task": "0.4.0"
}
```

Save your changes. You should see a new NPM folder in your project, under Dependencies, and it should include the grunt and grunt-bower-task items.

Next, add a new Grunt Configuration file (Gruntfile.js) to the root of the project. The default version of this file includes an empty call to grunt.initConfig. We need to configure grunt to use bower, and then register tasks associated with this configuration. Modify the Gruntfile.js to match this file:

```
module.exports = function (grunt) {
	grunt.initConfig({
		bower: {
			install: {
				options: {
					targetDir: "wwwroot/lib",
					layout: "byComponent",
					cleanTargetDir: false
				}
			}
		}
	});
		grunt.registerTask("default", ["bower:install"]);
		grunt.loadNpmTasks("grunt-bower-task");
};
```

Now that we’ve finished setting things up, we’re ready to let these tools manage our static files and client-side dependencies for us. Right click on gruntfile.js in your project, and select Task Runner Explorer. Double-click on the bower task to run it.

The output should show that the process completed without errors, and you should see that it copied some packages to the \wwwroot\lib folder. Open the wwwroot\lib folder in project explorer, and you should find that the client-side dependencies (bootstrap, jquery, etc.) have all been copied into this folder.

That’s all that’s required to quickly get grunt set up and working in Visual Studio 2015.