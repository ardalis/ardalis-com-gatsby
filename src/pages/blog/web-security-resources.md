---
templateKey: blog-post
title: Web Security Resources
path: blog-post
date: 2015-11-07T13:01:00.000Z
description: "Last month I attended a workshop put on by none other than Troy
  Hunt. Try had a ton of great security tips, as well as some online resources.
  "
featuredpost: false
featuredimage: /img/screenshot-2015-11-07-12.32.25-760x360.png
tags:
  - security
category:
  - Software Development
comments: true
share: true
---
Last month I attended a workshop put on by none other than [Troy Hunt](http://www.troyhunt.com/). Try had a ton of great security tips, as well as some online resources. I took notes, and have been meaning to post some of the links here for my (and your) future reference. To get the full scoop on these and other tools and resources, check out Troy Hunt’s [Pluralsight Courses](http://bit.ly/PluralS).

## NeedADebitCard

First, there are a lot of people who are just asking to get hacked or stolen from. Such as those who post photos of their new credit cards to the Internet. There’s even a twitter feed dedicated to this practice, [NeedADebitCard](https://twitter.com/needadebitcard). Check it out if you don’t believe me.

## Google for Hackers

Next, let’s talk about files that shouldn’t be shared from web sites. If you’re an ASP.NET developer, you know what kinds of goodies often are placed within web.config files. Fortunately, ASP.NET 5 is doing away with web.config and dramatically improving how developers determine which files should and should not be shared online. But that doesn’t help the millions of sites out there running ASP.NET 1 through 4, many of which aren’t configured properly. How do you find these hackable sites? How else but [Google](https://www.google.com/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=inurl:ftp+inurl:web.config+filetype:config+connection). Google can search ftp as well as http, and you can easily narrow your search to just a certain type of file. Further, since the juiciest thing in config files is usually the database connection string, just add that to the search string as well. Make sure sites you’re responsible for (or use!) aren’t in these results.

## Rainbow Tables

Now, when it comes to hacking passwords using brute force, there are some pretty easy ways to beat a lot of users’ password strategies. Rather than going character by character, trying every possible combination, password cracking tools will look for known words. And, since hashes don’t change, there’s no need to recompute hashes for these words when you can just look them up from a table. Tables of hashes of known common words used in passwords are known as rainbow tables, and you can simply [download huge rainbow tables](https://www.google.com/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=rainbow%20tables) for a variety of hashing algorithms.

## MD5 Cracker

Of course, downloading tables and running brute force attacks works best when you have a huge number of user accounts (and their password hashes) to work from. But what if you just have one hash, and you want to figure out the password that was used to generate it? Well, once again Google can help. Try this. Make up a simple password from a couple of words put together, and [generate the MD5 hash](http://www.miraclesalad.com/webtools/md5.php) for this potential password. Now, take that hash (remember, hashing is a one-way cryptographic operation, meaning there’s no way (easily) to reverse the hash and recover the password cryptographically), and enter it into [MD5Cracker](http://md5cracker.org/). See if it’s able to give you back your password. If it works, try it with something more difficult.

## Salting

Note that password schemes that use a salt are less vulnerable to rainbow tables and MD5 hash lookups like MD5 cracker, since they increase the size of the password and add some randomness to what otherwise might be plain dictionary words. The salt itself is typically stored in plaintext with the password (since it is needed when validating user passwords), but even when known it can help. For example, take your original password you tried in MD5 Cracker above, and simply add “5$dF&G” to the end of it. Now see if MD5Cracker can break it. It should make it much less likely to succeed (in my case it helped enough to prevent any of the databases from succeeding):

![](/img/screenshot-2015-11-07-12.32.25-760x360.png)

Salting (with a unique salt per password) also makes it impossible to attempt to crack more than one password at a time, dramatically reducing the rate at which a collection of password hashes can be cracked.

## Hashcat

Don’t feel too secure, though. Modern graphic cards have multiple GPUs and dozens of cores, all optimized for parallel operations like generating hashes. One of the main problems with MD5 and similar hashing algorithms is that they are extremely fast to compute. Thus, a typical video card today is capable of computing [literally billions of hashes per second](https://gist.github.com/epixoip/8171031) using a tool like [Hashcat](http://hashcat.net/oclhashcat/). With that kind of speed, only a very long password will have any chance of surviving even a total brute force attack with no optimizations.

## PBKDF2

Since hashing operations are so fast, one way to generate more secure hashes is to apply the hash multiple times. The [PBKDF2 algorithm](https://en.wikipedia.org/wiki/PBKDF2) applies thousands of hashes to a password, as many as 100,000 for server-side operations (and several thousand on small devices like cell phones). It’s recommended to be used in conjunction with a long salt value for additional security.

## bcrypt

[Bcrypt](http://wildlyinaccurate.com/bcrypt-choosing-a-work-factor/) is another hashing algorithm that is more expensive than traditional algorithms like MD5. It uses a work factor that determines how many iterations are applied. The work factor is used as an exponent of 2 to determine the iterations. Thus, a work factor of 2 would be 4 iterations, and a more typical work factor of 12 would be 2^12, or 4,096.

## SQL Injection

If you’ve built data-driven web applications, you should be aware of SQL Injection attacks. These attacks take advantage of SQL queries that are constructed from user inputs without guarding against these inputs. For instance, a query that is built using:

`var query = "SELECT * FROM Users WHERE UserName='" + username + "'"`

Can easily be hacked by providing a username that prematurely closes the trailing ‘ character, and then executes another query (or command). Although guarding against these attacks is fairly straightforward (use parameters or an ORM), there are still many sites online that are vulnerable today. So of course there are [tools for locating such sites](http://waziristanihaxor.blogspot.com/2015/02/SQL-VULNERABLE-websites-List.html). Again, make sure the sites you work on and use are not in these lists…

## Online Web Security Scanners

Some sites offer scanners that will detect and report common vulnerabilities, such as [NetSparker](https://www.netsparker.com/web-vulnerability-scanner/) and [ASafaWeb](https://asafaweb.com/Scan?Url=microsoft.com). These can detect common ASP.NET problems, like failing to set a custom error page (so yellow-screen-of-death messages are visible) or leaving tracing on in production (e.g. trace.axd), among other things.

## Try Your Newfound Hacker Skills

Troy Hunt has set up [a web site](http://hackyourselffirst.troyhunt.com/) where you can try some of the techniques discussed here, and many more that are covered in his Pluralsight course. Good luck!