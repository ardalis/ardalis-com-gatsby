---
templateKey: blog-post
title: Bulk Delete Old and Big GMail Email
date: 2019-01-04
path: /bulk-delete-old-and-big-gmail-email
featuredpost: false
featuredimage: /img/large-gmail-messages-1.png
tags:
  - email
  - gmail
  - google
  - google docs
  - search
category:
  - Productivity
comments: true
share: true
---

My GMail is complaining it's running out of space. I remember the days when GMail would show an ever-increasing counter of how much more space I had in my inbox, but apparently those days are over. I rarely delete anything in GMail, because I've been trained to just archive things with the click of a keystroke ('e' by default once you enable keyboard shortcuts). Thus, I have a lot of email in my account, and a lot of it is stuff I really don't need to keep.

## Delete Big Emails

![](/img/large-gmail-messages-1.png)

If you want to find and potentially delete large emails, which are usually going to be emails with large attachments, you can use a search filter of **larger:10mb**. Adjust the number up or down to see more or fewer matching messages. The current GMail free limit is 15GB so every 10MB message you find and delete is getting you .01GB more room.

For these items, it's probably best to look at each one, decide if it has an attachment you'd like to save, and then delete the message individually. Remember that deleting items will just move them to Trash, where they'll sit for a while (30 days currently) before Google actually deletes them. If you're anxious to free up space right now, go to the Trash folder and click the Empty Trash now link:

![GMail empty trash now](/img/gmail-empty-trash-now-1024x165.png)

Depending on how often you send and receive large file attachments, this might be sufficient to clean up a lot of space in your GMail account. However, if you've done this and you still need to clean up more space, keep reading on to the next section on how to clean up many old, smaller messages.

## Delete Old Emails

![](/img/old-gmail-messages-by-category-1024x199.png)

The trick to finding old email messages in GMail is to use the filter before:YYYY/MM/DD, as shown in the above image. You can further combine this with [GMail search operators](https://support.google.com/mail/answer/7190?hl=en) like the message's category. If you don't have any rules that do it automatically and you're not in the habit of categorizing every message (I don't), don't worry, GMail does some of this for you. You'll find categories for Social, Updates, Forums, and Promotions by default which GMail automatically applies. It's not always perfect, but pretty much anything in Promotions you can count on as being some kind of mailing list (not spam, since you probably opted into it at some point).

If you do use folders/labels, just use the **label:whatever** search term.

In my case, I don't really care what offer United or Marriott or Amazon had for me from over a year ago, so I'm happy to bulk delete hundreds of these messages. To do the actual deletion, click on the checkbox in the header to select all conversations, then click the Select all conversations that match this search link:

![Select all conversations that match this search](/img/gmail-bulk-delete-select-all-conversations-that-match-this-search-1024x129.png)

Now click the Trash icon. Again, it won't actually delete anything, but if you leave it in the trash it'll be gone in 30 days. Even though technically every conversation has been selected, I've found that Google doesn't actually delete all of them if there are a lot. In my case, it's deleting about a year's worth of messages at a time. After running it twice, I still have 2485 unread promotions left. Running it a third time... which takes a couple of minutes... and now it looks like it worked! Only a handful of unreads left and all of the ones left are since the 'before' filter I specified.

My Trash now has 36,814 items in it, mostly from the old Promotions emails. I'm at 14.82GB used. Hitting Empty Trash now... This also takes a few minutes... Ok, I actually left it overnight and the dialog was still there in the morning, but it did delete them. And afterward I'm at 12.6GB used. So, clearing out a bunch of useless promotions saved me about 2.2GB (and will probably keep me under the 15GB free limit for some time).

## More Search Tips

A few more handy GMail search tips:

has:attachment is great for finding messages that have an attachment. You can also use more specific one for Google documents like has:drive, has:document, has:spreadsheet or has:presentation. Note that these all assume you're talking about the Google versions of these things, not Excel, Word, PowerPoint, etc.

Want stuff that's been read, starred, or snoozed? Use is:starred, is:snoozed, is:unread, is:read.

Looking for a more specific time range? You can use both after:2019/01/04 and before:2019/2/28 to specify a range. If you'd rather just specify a timespan from now, you can use older\_than:30d which supports (d)ay, (m)onth, and (y)ear options for units.

[Check out the complete list of search options here.](https://support.google.com/mail/answer/7190?hl=en)
