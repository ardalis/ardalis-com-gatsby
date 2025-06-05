---
templateKey: blog-post
title: "GenAI is the new Offshoring"
date: "2025-06-06"
description: "In the early 2000s, US companies jumped on the offshoring bandwagon as a panacea for increasing dev and IT costs. Many came to regret this decision. GenAI tools are in a similar position to rapidly produce software at low cost."
path: blog-post
featuredpost: false
featuredimage: "/img/genai-is-the-new-offshoring.png"
tags:
  - genai
  - chatgpt
  - ai
  - artificial intelligence
  - offshoring
category:
  - Software Development
comments: true
share: true
---

> I originally [posted this on LinkedIn / BlueSky](https://bsky.app/profile/ardalis.com/post/3lpf22jfrbs2d) but I've found that it's nearly impossible to find (searching for "AI is the new offshoring" or "genAI is the new offshoring" both fail to find it) so I'm cross-posting here and adding a bit more context.

Twenty years ago, the internet and improved communications led to a massive push in US corporate enterprises to outsource IT and dev efforts to far less expensive offshore outfits staffed by eager but often inexperienced workers making pennies on the dollar compared to their US counterparts. Layoffs occurred in many orgs and whole departments moved offshore in some cases, and while there were success stories and many companies continue to leverage offshore talent, many (most in my experience but that's probably biased by the ones coming to my company for help) later regretted the decision.

You see, cheap offshore devs are often very productive at producing code in the short term, but if you review what they produce in many cases it's composed of lots of copy-pasted code everywhere. The result is a short run of high productivity that starts to slow down within 12-24 months and by the third year is a big ball of mud collapsing under its own weight and complexity.

Today, we have various AI and LLM tools capable of producing tons of code for pennies on the dollar compared to professional software engineers (from any country). Many companies are jumping on this bandwagon, blindly taking the output of these tools and building apps quickly from them, and I can't help but wonder if, in a few years, there won't be similar remorse and a whole lot of AI-created legacy code for folks like me to help companies recover from.

Remember, the source code for your apps is a thing you must maintain over time. If it's clean, well-organized, modular, then it's likely it will serve your needs for some time at a reasonable expense. But if it's a Big Ball of Mud of inscrutable generated Spaghetti Code, it's going to require massive effort **even with AI assistance** to modify in any meaningful manner.

GenAI and vibe coding are technical debt generators.

Is it possible to produce good working software using these tools? Yes, but it's the exception, not the rule. These tools are largely trained on public data sets, including tutorials, documentation, and student exercises. Most complex business software isn't publicly available. A lot of the code available publicly is intentionally dumbed down to keep it simple in order to make a specific point or teach a single concept. The sheer volume of this kind of code means GenAI tools will often default to these approaches, without considering what's missing.

Or, consider if real business code **is** available for training. How much of *that* code is what you would consider ideal quality, as opposed to technical-debt-ridden? To paraphrase George Carlin, "think about how bad the average code is, and then realize, half of it is worse than that." This is what GenAI is trained on and will produce - en masse - to fulfill whatever prompt you give it.

Remember [Wirth's Law](https://deviq.com/laws/wirths-law):

"Software is getting slower more rapidly than hardware becomes faster."

What we have today with AI is similar.

**Generation of lousy software and technical debt is happening far more rapidly than tools to manage and improve such software are being developed.**

It's going to be a bumpy ride for a few years.
