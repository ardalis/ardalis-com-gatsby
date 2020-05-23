---
templateKey: blog-post
title: Easily Add /img to GitHub
date: 2018-10-31
path: blog-post
featuredpost: false
featuredimage: /img/github-insert-image.png
tags:
  - GitHub
category:
  - Software Development
comments: true
share: true
---

When working with GitHub on things like ReadMe.md files, it's often helpful to include pictures. Unfortunately, when editing markdown files online, there's no built-in capability to add /img:

[![GitHub Markdown Editor](/img/github-markdown-editor.png)](/img/github-markdown-editor.png)

Typically, this would mean you would need to create an image yourself and commit it into your repository somewhere so you could then reference it. It's much the same if you're working on your repository's wiki:

[![GitHub Wiki Editor](/img/github-wiki-editor.png)](/img/github-wiki-editor.png)

This at least will give you a dialog for adding an image given its URL, but no facility for uploading it.

[![GitHub Insert Image](/img/github-insert-image.png)](/img/github-insert-image.png)

Ok, so your choices are to actually commit an image to your repository, and then try and figure out the path to the raw image and use that. Or host your image somewhere else. Neither is a great option. Thankfully, there's one cool trick that will let you stick with using GitHub in the browser and not only will let you add /img to your content but even supports copy-paste!

## GitHub Copy-Paste Image Upload

Here are the steps to stay in GitHub in your browser and still be able to add /img to your content using copy-paste.

1. On your repository where you want to add /img to markdown files, wiki pages, etc. create an Issue. Call it "/img". [![GitHub Issue /img](/img/github-issue-/img.png)](/img/github-issue-/img.png)
2. Now get an image, perhaps using the Windows Snipping Tool or [SnagIt](https://www.techsmith.com/screen-capture.html), and copy it. [![Windows Snipping Tool](/img/windows-snipping-tool.png)](/img/windows-snipping-tool.png)
3. Paste into the body of the issue you created. You should see it upload quickly and then display markdown with a URL. Note that you can also use drag-and-drop or click on "selecting them" to upload. [![Copy image into issue](/img/copy-image-into-issue.png)](/img/copy-image-into-issue.png)
4. Copy the generated markdown from the image into your markdown file or wiki page. You can of course change the generic \[image\] to something more reflective of the image, as this is used for the alt tag.
5. Repeat as needed. You can close the issue and keep it around for additional /img in the future, or just abandon it and never save it. Uploaded /img on an issue that is never saved are still retained. You can also use the same trick in comments on issues, so you could easily just add one comment per image you need to add as well.

The only annoying thing about this process is that anybody who is following your repository is going to get an email every time you add a comment to an issue or update it, so if you're going to be creating a lot of /img you might do it in a batch before saving or closing the issue (and instead of adding 1 per comment).

The repository shown in the screenshots is my [Clean Architecture solution template for ASP.NET Core](https://github.com/ardalis/CleanArchitecture), which helps ensure your new ASP.NET Core solutions are properly structured to follow clean architecture principles. I cover it in [my ASP.NET Core and Clean Architecture workshops](https://ardalis.com/training-classes) that I offer to teams around the world.

If this helps you, please share it on [twitter](https://twitter.com/ardalis/status/1057633514550648832) or LinkedIn or wherever you find great content.
