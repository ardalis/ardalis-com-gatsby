---
templateKey: blog-post
title: The Evolution of Status Pattern
path: blog-post
date: 2008-04-01T01:28:25.986Z
description: An interesting pattern that I see in many of the applications I’ve
  worked with is the notion of status, and how it tends to evolve over time.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - authentication
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

An interesting pattern that I see in many of the applications I’ve worked with is the notion of status, and how it tends to evolve over time. This is probably familiar to most of you, though perhaps you’ve never thought about it. Consider the following scenario:

**Requirement** – ***The system should have Users, to control access via authentication.***

At this stage, the developer creates a User class and a User table with a few fields like UserId, UserName, Password, Email, etc. Status is implicit – if there exists a row that matches the given UserId (or UserId and Password for authentication), then the user’s status is valid. Otherwise, not. Ah, the beauty that is simplicity.

Invariably, requirements change, and scope creeps…

**Requirement** **– *Administrators should be able to disable users without deleting the record.***

At this stage, the design is updated to include some kind of flag to say whether or not the User is enabled or disabled. In my applications this usually comes in the form of an Enabled bit column in the database (Defaulting to 1) and a corresponding Enabled bool property in the associated User class. This refactoring involves a bit of work to anything that works with Users, including authentication and lists of users (where only active users should be listed).

You’d think this would be the end of it. But no, it gets better…

**Requirement – *New users should be pending until approved by an admin.***

At this point, we’ve surpassed the capabilities of a bit/boolean. A nullable bit might still get us by (since our needs are now [ternary](http://en.wikipedia.org/wiki/Ternary_logic)), but I usually bite the bullet and go with a Status field at this point. It’s a bit of a hack to use a null state as a valid state for this, I think. So at this point a new table in the database is created, UserStatus, which has an ID and a Name and includes rows for Pending, Active, and Disabled or something similar. The User table is updated to include a UserStatusID column (foreign key) and the User class is hooked up with an enum or reference to a UserStatus object. Refactoring this involves removing the Enabled field, revising all tests and references to it so that anything looking for Enabled = true is now looking for UserStatus = UserStatus.Approved. Various queries for lists of users must now be updated as well, which might involve work in stored procedures or generated DAL code (LLBLGen, LINQ, NHibernate, whatever).

Really, this should be good enough. But no, sometimes the evolution continues…

**Requirement – *Pending users should be either Approved or Rejected within 24 hours, and the user who changes their status must be logged.***

Now things really start to get interesting, since a log of changes is required. At this point the question of whether the afore-created UserStatusID column is still required, or if the status of a user can easily be determined by looking at the last action that was performed on it in its log file. The UserStatusLog table is going to include an ID, a UserID, a NewStatusID, a DateCreated datetime field, and an AdminUserID to record who made the change. Depending on performance considerations, we might want to refactor away UserStatusID on the User table and just grab the most recent NewStatusID for this UserID from the UserStatusLog table instead. This would make for a smaller footprint for the User table, while making checks of status much less performant (but it’s a more normalized appoach). Assuming you’ll be using some kind of caching in the business tier, it shouldn’t make a huge difference until you start doing things like trying to index your queries on user status, and then you’ll probably want to denormalize things and add the column back in. So, to save time on that, I would just keep it around and make sure it’s updated and kept in sync with the log ([production database tests are good for this](http://aspadvice.com/blogs/ssmith/archive/2008/02/22/Use-Unit-Test-Framework-to-Test-Production-DB-Consistency.aspx)). Having made that decision, the only refactoring that needs made is in the code that updates UserStatus, to ensure that the change is logged. I would do this in the business layer, typically, but it could also be done at the DAL, sproc, or even trigger level depending on how you want to architect it.

Sometimes, this is (finally) sufficient, but occasionally you end up with something even worse (which I think is probably just a bad design, but we’ll address it anyway):

***Requirement – Users who were deleted but later reinstated should be formatted differently in the UI to make it clear they’re on probation.***

I’m stretching for a scenario here, I realize. The thing I’m going for is a status that depends on a series of prior status changes. In this case, you could probably get away with creating a new status, Probation, and updating everything to use this (and otherwise treating it like Approved). But in some scenarios the number of variations of status can be enough that you don’t want to just keep adding static Status options, but rather you need to use some kind of formula based on the log of events to come up with a dynamic status. This is the ugliest version of this evolution, and one you should really seek to avoid if possible. The complexity of the schema is awful considering what seems like a simple enough task, and usually the solution is to separate out logged status events into multiple categories that each have only a small, known subset of values. It’s also important to keep dynamic status options (e.g. they’re Active if they’ve logged in in the last day, otherwise Inactive) out of the database and in business rules. You don’t want to be doing table updates for statuses that change based on the passage of time, if you can avoid it.



That summarizes my observations on the Evolution of Status Pattern in the applications I’ve worked with. You really don’t want to just start out with the Status lookup table unless you are absolutely certain you’re going to need it, because otherwise it will just slow things down. Remember [YAGNI](http://en.wikipedia.org/wiki/You_Ain't_Gonna_Need_It). As long as you have well-factored code and tests for your interactions, the refactorings at each incremental change will not be too difficult.

<!--EndFragment-->