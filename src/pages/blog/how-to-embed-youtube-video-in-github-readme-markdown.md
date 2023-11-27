---
templateKey: blog-post
title: How to Embed a YouTube Video in GitHub ReadMe Markdown
date: 2023-11-23T11:04:10.000Z
description: "I keep wanting to do this and forgetting how, so I'm writing it down. Here's how to embed a YouTube video in a GitHub ReadMe markdown file." 
path: blog-post
featuredpost: false
featuredimage: /img/how-to-embed-youtube-video-in-github-readme-markdown.png
tags:
  - github
  - youtube
  - video
  - markdown
category:
  - Productivity
comments: true
share: true
---

I keep wanting to do this and forgetting how, so I'm writing it down. Here's how to embed a YouTube video in a GitHub ReadMe markdown file.

Thanks for this [Stack Overflow answer](https://stackoverflow.com/a/29862696/13729) for the tip.

## Step 1: Get the YouTube Video ID

The YouTube video ID is the part of the URL after the `v=`. For example, in the URL `[https://www.youtube.com/watch?v=dQw4w9WgXcQ](https://www.youtube.com/watch?v=dQw4w9WgXcQ)`, the video ID is `dQw4w9WgXcQ`. You'll need that for the next step.

## Step 2: Embed the Video

To embed the video, use the following markdown:

```markdown
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/YOUTUBE_VIDEO_ID_HERE/0.jpg)](https://www.youtube.com/watch?v=YOUTUBE_VIDEO_ID_HERE)
```

YouTube already has a thumbnail image for the video, so you can use that. Just replace `YOUTUBE_VIDEO_ID_HERE` with the video ID you got in step 1 in the first URL (for the image). Then again in the second URL (for the link to the video).

## Step 3: Profit

That's it! You're done. Here's my [Ardalis.GuardClauses repo](https://github.com/ardalis/guardclauses) with a video embedded in the ReadMe:

![Embedded YouTube Video in GitHub ReadMe](/img/ardalis-guardclauses-youtube-embed.png)

View the source to see exactly how it's set up.

Enjoy!

## More tips

The "0.jpg" file is the default thumbnail YouTube uses, but you can also refer to other thumbnails by changing the number. For example, "1.jpg" is the first thumbnail YouTube generates, and "2.jpg" is the second. You can use these in your ReadMe to show a different thumbnail than the default. There are also high resolution options at "maxresdefault.jpg" and "hqdefault.jpg".

Examples (click to see each image from my [Ardalis.GuardClauses video](http://www.youtube.com/watch?v=OkE2VeRM4mE)):

- [http://img.youtube.com/vi/OkE2VeRM4mE/0.jpg](http://img.youtube.com/vi/OkE2VeRM4mE/0.jpg)
- [http://img.youtube.com/vi/OkE2VeRM4mE/1.jpg](http://img.youtube.com/vi/OkE2VeRM4mE/1.jpg)
- [http://img.youtube.com/vi/OkE2VeRM4mE/2.jpg](http://img.youtube.com/vi/OkE2VeRM4mE/2.jpg)
- [http://img.youtube.com/vi/OkE2VeRM4mE/3.jpg](http://img.youtube.com/vi/OkE2VeRM4mE/3.jpg)
- [http://img.youtube.com/vi/OkE2VeRM4mE/maxresdefault.jpg](http://img.youtube.com/vi/OkE2VeRM4mE/maxresdefault.jpg)
- [http://img.youtube.com/vi/OkE2VeRM4mE/hqdefault.jpg](http://img.youtube.com/vi/OkE2VeRM4mE/hqdefault.jpg)

## Share

Did you enjoy this post? Share it with your friends and colleagues! Thanks!
