---
templateKey: blog-post
title: Government Mandates and Programming Languages
path: blog-post
date: 2010-04-28T06:03:00.000Z
description: >-
  A recent SEC proposal (which, at over 600 pages, I haven’t read in any detail)
  includes the following:
   “We are proposing to require the filing of a computer program (the “waterfall computer program,”
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - programming languages
category:
  - Uncategorized
comments: true
share: true
---
A [recent SEC proposal](http://www.sec.gov/rules/proposed/2010/33-9117.pdf)(which, at over 600 pages, I haven’t read in any detail) includes the following:

> “We are proposing to require the filing of a computer program (the “waterfall computer program,” as defined in the proposed rule) of the contractual cash flow provisions of the securities in the form of downloadable source code in Python, a commonly used computer programming language that is open source and interpretive. The computer program would be tagged in XML and required to be filed with the Commission as an exhibit. Under our proposal, the filed source code for the computer program, when downloaded and run (by loading it into an open “Python” session on the investor’s computer), would be required to allow the user to programmatically input information from the asset data file that we are proposing to require as described above. We believe that, with the waterfall computer program and the asset data file, investors would be better able to conduct their own evaluations of ABS and may be less likely to be dependent on the opinions of credit rating agencies.”
>
> “With respect to any registration statement on Form SF-1 (Section 239.44) or Form SF-3 (Section 239.45) relating to an offering of an asset-backed security that is required to comply with Item 1113(h) of Regulation AB, the Waterfall Computer Program (as defined in Item 1113(h)(1) of Regulation AB)**must be written in the Python programming language and able to be downloaded and run on a local computer properly configured with a Python interpreter**. The Waterfall Computer Program should be filed in the manner specified in the EDGAR Filer Manual.”

I don’t see how it can be in investors’ best interests that the SEC demand a particular programming language be used for software related to investment data. I have a feeling that investors who use computers at all already have software with which they are familiar, and that the vast majority of them are not running an open source scripting language on their machines to do their financial analysis. In fact, I would wager that most of them are using tools like Excel, and if they really need to script anything, it’s being done with VBA in Excel.

Now, I’m not proposing that the SEC should require that the data be provided in Excel format with VBA scripts included so everyone can easily access the data (despite the fact that this would actually be pretty useful generally). Rather, I think it is ill-advised for a government agency to make recommendations of this nature, period. If the goal of the recommendation is to ensure that the way things work is codified in a transparent manner, than I can certainly respect that. It seems to me that this could be accomplished without dictating the technology to use. To wit:

* An Excel document could contain all of the data as well as the formulae necessary, and most likely would not require the end-user to install anything on their machine
* The SEC could simply create a calculator “in the cloud” such that any/all investors could use a single canonical web-based (or web service based) tool
* Millions of Java and .NET developers could write their own implementations

You can read more about this issue, including the favorable position on it, on [Jayanth Varma’s blog](http://jrvarma.wordpress.com/2010/04/16/the-sec-and-the-python).