---
templateKey: blog-post
title: Deploy and Test an Azure App with Platform Ready
date: 2011-05-10
path: blog-post
description: Microsoft Platform Ready provides technical and marketing resources for companies building applications for the Microsoft platform. Currently they are working with The Code Project on a promotion that will pay $250 USD to companies for their FIRST Windows Azure Application that is verified compatible using the Microsoft Platform Ready testing tools. The contest is valid only through 21 June 2011 12:00 PST in the US only, but the walkthrough I’m about to show will work for any company who wishes to confirm and verify to customers that their application is running correctly on Windows Azure.
featuredpost: false
featuredimage: /img/azure-app-platform-ready.png
tags:
  - Azure
category:
  - Productivity
  - Software Development
comments: true
share: true
---

## Introduction

Microsoft Platform Ready provides technical and marketing resources for companies building applications for the Microsoft platform.  Currently they are working with The Code Project on a promotion that will pay $250 USD to companies for their FIRST Windows Azure Application that is verified compatible using the Microsoft Platform Ready testing tools.  The contest is valid only through 21 June 2011 12:00 PST in the US only, but the walkthrough I’m about to show will work for any company who wishes to confirm and verify to customers that their application is running correctly on Windows Azure.

## Getting Started

You’ll need to install the latest Azure developer tools for Visual Studio.  You can get these at [Azure.com – just click the Get Tools & SDK link](http://www.microsoft.com/windowsazure/getstarted/).  You’ll find walkthroughs for creating and deploying applications at this location as well.  Once you have the tools, create a new Azure application, or [download my sample application](http://stevesmithblog.s3.amazonaws.com/AzureProfile.zip) and adjust it to suit your needs.  In my case, I wrote a very simple MVC-based web application that displays some very basic profile information from my Code Project profile.

Build and test your application locally using the local Azure tools.  The sample application provided literally only has one small bit of code – it’s pretty close to a Hello World app.  To be sure, you can build much more involved applications and leverage additional services such as Azure Storage or SqlAzure

## Get an Azure SUbscription and Deploy Your App

You can get a 30 day pass for Windows Azure by clicking on this link (no longer active) and then entering promo code CP250.  You don’t need a credit card or anything to get started using this promo code and URL.

You just need to sign in with your Windows Live ID in order to get started, and then fill out a small form.

Accept the agreement…

Now get started:

**Note that it can take 2-3 business days for you to receive an email letting you know that your 30 day pass account has been set up**.  The rest of this walkthrough assumes this has occurred, or that you otherwise have access to an Azure account (paid, via MSDN, etc.).

At this point if you’ve been following along, you’re ready for step 4, Deploy Your Application to the Cloud.  To do this, you’ll need to log in to your Windows Azure Management Portal at windows.azure.com.  You access the portal using the same Live ID you used to get your pass (or that you otherwise have associated with your Windows Azure account).

If you are going to be taking advantage of Microsoft Platform Ready testing (in order to qualify for the $250 USD marketing funds offer), you will need to ensure that your account has a certificate and a storage account set up in addition to your application’s web or worker roles.  We’ll look at getting these set up after we show how to deploy the application.  To deploy, we’ll need to create an application package and a configuration file.

Back in Visual Studio, open your Windows Azure solution, right click on the cloud project, and choose Publish.

Choose the option to Create Service Package Only.

Once the build and package steps complete, a Windows Explorer  window will open showing you the files that were produced.  Click on the address bar and Copy the address to your clipboard.

Now in your browser in the Azure Management Portal, click on New Hosted Service.  Fill in the options however you see fit.  If you created a 30-day pass, you should see it as an option in the Choose a subscription dropdownlist at the top of the form.  The URL prefix must be unique (among all Azure deployments, not just yours).

For Package location, choose Browse Locally and Paste the address where your published package is located, and then choose your .cspkg file.  For the Configuration file, choose Browse Locally again, Paste in the address again if necessary, and choose your .cscfg file.

Click OK.  This can take a bit of time, but once it’s done, verify that your application is working properly at the URL you chose above.

## Create a Storage Account

Whether the app uses one or not, we will need a Storage Account for Platform Ready.  Click on the Storage Accounts link in the Azure Portal, then choose New Storage Account from the ribbon menu.  Fill in the options similar to the Hosted Service, with a unique URL prefix and a subscription selection.

Click OK and the account should be created after a short delay.

## Install a Certificate

Another requirement for Windows Platform Ready is the presence of a certificate with your Azure account.  You don’t need to purchase a certificate – you can use a self-signed one that you can easily create with IIS on your local dev machine.  David Aiken has a nice blog post on how to create a certificate for Windows Azure that I used for these steps.

First, open IIS Manager and click on your computer name.  Then double-click on Server Certificates from the IIS section in the main window.

Next, click on the Create Self-Signed Certificate option on the right.  Specify a name for the cert (e.g. “AzureCert”).  You should then see it listed in the list of Server Certificates.

Close IIS manager and open Certificate Manager (Start -> Run -> certmgr.msc).  Open the Trusted Root Certification Authorities and click on Certificates.  Locate your certification by sorting on the Friendly Name column and finding the name you provided.

Now right click on your cert and choose All Tasks -> Export.

Select No, do not export the private key and click Next.  Select DER encoded (the default) for the file format and click Next.  Specify the file name and path (e.g. c:\AzureCert.cer) making sure to name it with the .cer extension.  Verify the options and click Finish.

Now back in the browser, in the Azure Management Portal, click on Management Certificates.  Choose Add Certificate from the ribbon menu.  Be sure the correct subscription is selected, then browse to the .cer file you just exported, and click OK.

Your application is now ready for MPR testing and verification!

## Verify Application with Microsoft Platform Ready

Go to MicrosoftPlatformReady.com, choose your location (only US is eligible for $250 contest) and sign in using your Live ID.  Fill in the form, making sure to specify Code Project for the How did you hear about MPR? question:

Click Save and Submit to continue.

Next, add your application to MPR and fill the form, noting that the Microsoft Platform(s) used by your application include Windows Azure Platform (Windows Azure, SQL Azure & App Fabric).  Then, click on the Test tab.  You’ll need to download and install the Microsoft Platform Ready Test Tool, which you’ll find a link to once you click on the Test My Apps link on the left.

Install the test tool and run it.  Give your test a name and select Windows Azure as the technology in use, then click Next.

Now click the Edit… link in the Details column.  Here you will need to provide your subscription ID, your certificate file (that we created above), and optionally the URL to your application.

You’ll find your subscription ID in the Azure Portal on the right, as well as listed with your Management Certificate.

Once you’ve selected your subscription ID and certificate, click the Verify button.

Close this window and then click Next.  Your Test Prerequisites should say Pass now.  Click Next to move on to test execution.  Now you will need to verify that your application works correctly.  This is not automated – it’s up to you to perform this test.  When completed, click the Yes checkbox and then click Next.

Ideally you should now see a Test Result of Pass.  If you didn’t set up a storage account, you may see a test failure noting that your account does not have a storage account associated with it.  In that case, shame on you for not following direction – go back and add one, then repeat the steps to run the test.  Click Next.

Now we’re almost done.  You can view the test results, but note that the test results file is not what you are going to upload to the Microsoft Platform Ready web site.  Trust me, I tried, it doesn’t work.  To submit the results of your test to Microsoft, you need to click on the Reports button in the screen below.

Choose the passing test that you want to package, then click Next.

Click Next again on the resulting screen, and then enter in your Application Name and Version on the next screen.  Click Next again.  Now, check the Create Test Results Package checkbox and provide a name for the package, but more importantly, enter in the Application ID from the Microsoft Platform Ready web page.  Fill in the rest of the form and click Next.

After a few seconds, you should see the Finish screen.

On the MPR web page, click the Choose File button, navigate to the Test Results Package Location shown in the Finish screen of the test tool, and upload the test results package.

Next you should see that the upload was successful and the results are queued for processing.  Click Refresh after a bit, and you should see something showing your Passing test.

Now you’re ready to request your $250.  Take a screenshot of the entire page showing the Test tab and the View My Reports tab showing that your application passes.  Then fill out this email template (no longer active) with your company information and paste/attach the screenshot to the email, and send it in.  If you have questions about this offer, please review the terms and conditions here (no longer active).

Congratulations!  You just created and verified your first Windows Azure application!

Originally published on [ASPAlliance.com](http://aspalliance.com/2059_Deploy_and_Test_an_Azure_App_with_Platform_Ready)
