---
templateKey: blog-post
title: 9 Ways Contract Lawyers are Like Software Developers
path: blog-post
date: 2010-11-22T11:54:00.000Z
description: Lawyers. We love to hate them. But they’ve been writing code since
  long before Ada Lovelace wrote the first computer program. Here are 9 ways
  that Contract Lawyers are like Software Developers.
featuredpost: false
featuredimage: /img/9-ways-contract-lawyers-are-like-software-developers-760x360.png
tags:
  - contracts
  - lawyers
  - programming
category:
  - Software Development
comments: true
share: true
---
Lawyers. We love to hate them. But they’ve been writing code since long before [Ada Lovelace wrote the first computer program](http://en.wikipedia.org/wiki/Ada_Lovelace). Here are 9 ways that Contract Lawyers are like Software Developers.

## Reason One: They Use a Language That Barely Resembles English

![](/img/117048243_7cc6bb0b87.jpg)

[](http://www.flickr.com/photos/joegratz/117048243 "Source: http\://www.flickr.com/photos/joegratz/117048243/")Let’s face it, most attorneys writing contracts use language that one would be hard-pressed to find used anywhere on the planet in the last 100 years. In part, this is because English (and most other natural languages) is not very good at being specific without being verbose (and even then, it’s often ambiguous). This is the same reason why attempts to program computers using natural language have not been wildly successful thus far ([LOLCode](http://lolcode.com/examples/hai-world) being perhaps the exception). So, in order to be a competent contract attorney, one must first learn a new language, or at least dialect, and become comfortable with the rules, vocabulary, keywords, and syntax of this language, which has come to be known as *legalese*.

Sadly, I’m unaware of a legalese compiler. In fact, I can’t even find a legalese translator after a brief search, which surprises me. However, I did find the DailyWTF of legalese, the **Legalese Hall of Shame** (sadly no longer there, fortunately I copied this bit before the site disappeared. source: www.partyofthefirstpart.com/hallOfShame.html). Here’s an example:

> *Retiree hereby agrees to and does for himself and his heirs, executors, administrators, successors and assigns, and each of them, release, remit, remise, acquit and forever discharge Employer, all individual members of Board of Directors (past, present and future), its employees, officer, agents, successors and assigns and XYZ Company, Inc. from any and all matters of action, causes of action, grievances, rights or claims of rights, debts, dues, damages, liabilities, costs claims, controversies, demands, torts, contracts, agreements, guarantees, indebtedness, obligations, expenses, accountings, warranties and choices in action, in law or in equity, including grievances of unfair labor practices and of every nature and description whatsoever by reason of or in respect to the performance by Retiree of any extra duty assignment by Retiree whether known or unknown, suspected or unsuspected, latent or patent, or has at any time heretofore owned or held against the aforesaid parties or Board of Directors.*
>
> **Translation:***Retiree waives his right to sue the employer.*

Compare that to the densest, most arcane programming language code and then realize, at least you can compile, test, or execute that code to see what it actually does!

## Reason Two: Copy-Paste Reuse is Rampant

Let’s say you’re facing a problem that you’ve seen before. Maybe it’s a need for exception management. Or logging. Or how to retrieve a datatable from a database query. What do you do? If you know you have the exact code you need somewhere else in your current project, or even in another project you’ve recently worked on, you probably grab the bit of code you need and paste it into the program you’re currently working on. If you’re a bit more diligent about code cleanliness, you may find a way to avoid this replication by using a common library, subsystem, or tool.

In contracts, lawyers develop standard clauses and “boiler plate” sections that they have tweaked over the years to suit their needs and to adapt to the latest laws and precedents. These boiler plate blocks of code usually comprise the last paragraphs of a contract, and include such things as whether the contract is in fact the whole agreement, the jurisdiction that will apply to any disputes, and things of this nature. In my experience, it’s also not uncommon for large sections of contracts that relate to the specific domain of the contract to also be cut-and-pasted from one client to another (e.g. for an asset purchase agreement). In this case, it can be rather embarrassing if the authoring attorney isn’t especially diligent and details of another client’s purchase are left in as part of the contract they’re writing for you (yes, this has happened). All of the usual problems with duplication apply to legal contracts, but unfortunately there is no mechanism to simply reference a shared common subroutine in most custom contracts. The boilerplate~~code~~legalese needs to be added, every time, with all of the waste and opportunities for error that this approach has in software.

## Reason Three: Lawyers’ Contracts are Interpreted Code

Some programming languages are compiled, and some are *interpreted*. But even programs written in interpreted languages can be, well, interpreted ahead of time, before they need to run in production. It’s nice that as programmers we can have our very own interpreter running on our own machine. Sadly, there are no virtual courtrooms or automated judges that a contract attorney can run their contract through to see how it does. They only get to see how their contract executes in production when it’s actually in production. On the plus side, you do get to see the bugs in others’ contracts, so you can learn from their mistakes, but you never really know if your contract is “correct”. And of course, since the interpreter is constantly changing and there is easy way to rev a contract once it’s in place, what you might believe is correct today might be completely incorrect next week.

## Reason Four: Open Source

Programmers have a huge resource in the form of open source software. Contract lawyers have a similar resource in the form of prior case law. As noted above, the only way attorneys can learn how their code holds up under the interpreter is by looking at their own and others’ past legal encounters in the courtroom. Of course, there’s a lot of noise in the signal, but there are I suspect journals and other sources that offer the highlights for those attorneys who are inclined to follow the latest developments. I’m not sure if there are repositories of freely available legal contract provisions that are collaborated on by hundreds of attorneys in their free time after work – I rather doubt it – but maybe that will happen someday.

## Reason Four: Stepping Through Code and Debugging is Very Expensive

When bugs aren’t obvious, one of the most brute force things a programmer can do to determine why the program isn’t behaving as expected is to attach a debugger and step through the code. This is expensive, in terms of the time it can take to locate the problem. So too with attorneys. If two attorneys disagree about the perceived meaning of a particular clause in a contract, the resolution of such a dispute can quickly get quite expensive (for the clients). All the more so since there is no debugger, no compiler, and no interpreter that can say with any authority, outside of a lawsuit in a courtroom, what a given clause actually means with any authority.

## Reason Five: Only Other Lawyers Can Tell Good Contracts from Bad Ones

And since it’s so difficult to understand the language used in many contracts, and there is no authority that can say with any certainty whether a given clause is effective or enforceable, the only way to determine whether a contract is “good” or “bad” is to ask a competent lawyer. Finding a lawyer is rather straightforward, but judging one’s competence is a difficult task for a non-lawyer. It’s sort of like saying: *If you can tell good advice from bad, you don’t need advice*. Of course, the same is true for programmers. If you were to ask a non-programmer whether a given program was “good” or “bad” they would be unlikely to be able to do so. And on more nuanced questions, such as whether a particular design was appropriate to a given context, only a competent programmer would be able to say with any certainty, and of course it would not be uncommon for several such competent programmers to disagree.

## Some Reasons Why Programmers Are Not Like Contract Lawyers

Obviously the analogy only goes so far. Here are a few differences.

## Reason Not.1: Only Manual Tests

Some programs are very expensive to run in a production or simulated production environment. In virtually all programs, in fact, it is orders of magnitude more expensive to correct an error once it has been deployed to production than to do so while the code is still in development on the programmer’s computer. Given this, automated test suites have been found to provide a huge benefit to the quality of shipping code, and likewise have been shown to reduce the overall costs of the code by reducing the number of shipping defects. Unfortunately, lawyers’ lives are not so blessed, as there are no automated test suites that can quickly locate regressions in contracts. The only tests available are manual ones, such as reading through the~~code~~contract looking for problems, asking a peer to review it, and finally, presenting the contract to a judge or arbitrator. I do not envy attorneys in this regard one bit.

## Reason Not.2: Even Code That Is Never Interpreted Has Value

In software, we generally write code so that a computer can run it. Certainly there are learning exercises that are the exception to this rule, but generally speaking even when we set about to write code purely for learning purposes, we run it on a computer as part of this process. Code that never is run by a computer has little value, especially since any significant amount of code that’s never met a compiler or interpreter is unlikely to do what its author intended in any event. This is quite unlike contracts, of which the **vast majority are never interpreted by an authority**, and yet they continue to provide value all the same. In a sense, they are interpreted many times by many individuals, both lawyers and non-lawyers, but since none but a judge or arbitrator can truly determine the correctness, this amounts to a series of code reviews without the benefit of a computer to run the code on.

## Reason Not.3: Code Changes Based on How Everybody Else’s Code Runs

It’s true that if I wrote some code that worked just fine a few years ago, it may not run as expected (or at all) today on a different computer, operating system, or in a different browser. The environment in which my code executes can change how it behaves, but there are many environments and it is usually fairly inexpensive to create an environment in which my code can run, and to communicate to end users what the general requirements are of my code in terms of its environment. However, in the field of law, the lawyer has no control over the environment in which a contract will find itself being interpreted. Years may and often do pass between when the contract was written, when it was signed, and when (if ever) it is tested in a court of law. At that time, the body of law by which it will be judged may be quite different than what existed when it was written and signed. I’m not aware of any contracts that include the equivalent of *system requirements*, stating the statutes and precedents which must exist in order for the contract to be correctly interpreted. However, just as error handling and defensive coding are habits of programmers that increase the robustness of our code, so too do contract lawyers add clauses that attempt to compensate the unexpected. For example, here’s the contract equivalent of a try-catch block that simply swallows the exception:

> If any provision of this Agreement is declared to be invalid under any
>
> applicable statute or rule of law, the parties agree that such invalidity shall
>
> not affect the remaining portions of this Agreement.

## Summary

There are quite few similarities between the writing of contracts and the writing of software. In fact, when dealing with contract attorneys, it’s easy to feel a kind of kinship with them, I’ve found. For myself, though, I don’t think I’ll be taking any night classes on law or studying for the bar any time soon. I think the frustration of never really knowing whether anything I’d produced was actually going to do what I’d intended it to would be too much for me. I much prefer the great satisfaction of watching a program compile successfully, watching thousands of unit tests light up green, and seeing an automated build and deployment script execute successfully.

*PS – Most folks don’t read the agreements they sign, and even if they do, it’s easy to miss details. The same is true with source code, which is one reason why having automated tests (that you know and trust) can be so useful. Did you notice after reading this far how many reasons were given, versus what was said in the title?*
