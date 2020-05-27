---
templateKey: blog-post
title: Persisting the Type Safe Enum Pattern with EF 6
path: blog-post
date: 2016-08-04T05:39:00.000Z
description: I’ve written about Enum Alternatives in C#, and a common problem
  developers encounter when they try to use such an approach is persistence.
featuredpost: false
featuredimage: /img/persisting-the-type-safe-enum-pattern-with-ef6-760x360.png
tags:
  - C#
  - ef6
  - entity framework
  - pattern
category:
  - Software Development
comments: true
share: true
---
I’ve written about [Enum Alternatives in C#](https://ardalis.com/enum-alternatives-in-c), and a common problem developers encounter when they try to use such an approach is persistence. By default, ORM tools like Entity Framework don’t know what to do with these custom types. However, you can add support to let EF map these types to database columns as you would expect without too much effort. Here’s a quick example you can try yourself with a new MVC 5 project.

**Step 1. Create a new Web Application in Visual Studio.**

![](/img/newwebapp.png)

Make sure to specify that you want individual user accounts.

**Step 2. In the Models folder, find the ApplicationUser class.**

We’re going to give it a new Role property that will use the type-safe enum pattern. Add this property:

`public class ApplicationUser : IdentityUser {
    public Role Role { get; set; } = Role.Author;
    // other stuff
}`

**Step 3. Define the Role Class**

The Role class is our type-safe enum implementation. It must include whatever value you want persisted in the database to indicate that an ApplicationUser is in this role. This might be an Id property or a Value property, and it could be an int or a string or whatever makes sense for your application and data structure. In this case, it’s going to have a Value property and it’s going to start at 0 to properly emulate an enum.

`public class Role {
    private readonly string _name;
    public static Role Author { get; } = new Role(0, "Author");
    public static Role Editor { get; } = new Role(1, "Editor");
    public static Role Administrator { get; } = new Role(2, "Administrator");
    public static Role SalesRep { get; } = new Role(3, "Sales Representative");

    private Role(int val, string name)
    {
        Value = val;
        Name = name;
    }

    private Role()
    {
        // required for EF
    }

    public int Value { get; private set; }
    public string Name { get; private set; }

    public IEnumerable<Role> List()
    {
        return new[] { Author, Editor, Administrator, SalesRep };
    }

    public Role FromString(string roleString)
    {
        return List().FirstOrDefault(r => String.Equals(r.Name, roleString, StringComparison.OrdinalIgnoreCase));
    }

    public Role FromValue(int value)
    {
        return List().FirstOrDefault(r => r.Value == value);
    }
}`

**Step 4. Map the Property for Entity Framework**

Ok, so far, so good. If you try to generate a new schema now using EF migrations, the Role property is likely to be completely ignored. Let’s look at what we need to add to the DbContext to properly map this property:

`protected override void OnModelCreating(DbModelBuilder modelBuilder) {
    base.OnModelCreating(modelBuilder);
    modelBuilder.Entity<ApplicationUser>()
        .Property(a => a.Role.Value)
        .HasColumnType("int");

    modelBuilder.ComplexType<Role>()
        .Ignore(r => r.Name);
}`

This mapping tells EF to map the Role property based on its Value property, and to use a columntype of int. It also tells it to ignore the Name property on Role (by default every property on a complex type is mapped, and until recently, had to be mapped).

With this in place, you can enable migrations and add a new migration:

`> Enable-Migrations Checking if the context targets an existing database...
Code First Migrations enabled for project WebApplication2.

> Add-Migration RoleProperty
Scaffolding migration 'RoleProperty'.`

Looking at the generated ‘DATESTAMP_RoleProperty.cs’ file, you’ll find a new Role_Value column on AspNetUsers:

`CreateTable(     "dbo.AspNetUsers",
    c => new
        {
            Id = c.String(nullable: false, maxLength: 128),
            Role_Value = c.Int(nullable: false),
            Email = c.String(maxLength: 256),
            EmailConfirmed = c.Boolean(nullable: false),
            PasswordHash = c.String(),
            SecurityStamp = c.String(),
            PhoneNumber = c.String(),
            PhoneNumberConfirmed = c.Boolean(nullable: false),
            TwoFactorEnabled = c.Boolean(nullable: false),
            LockoutEndDateUtc = c.DateTime(),
            LockoutEnabled = c.Boolean(nullable: false),
            AccessFailedCount = c.Int(nullable: false),
            UserName = c.String(nullable: false, maxLength: 256),
        })
    .PrimaryKey(t => t.Id)
    .Index(t => t.UserName, unique: true, name: "UserNameIndex");`

If you want to test that everything works, just create a new user and assign it to a role (or whatever enum you’re using). Then fetch it from persistence and confirm it has the value you expected.

`// put this in HomeController.Index for instance var db = new ApplicationDbContext();

var user = new ApplicationUser();
string username = "user" + Guid.NewGuid();
user.UserName = username; // required
user.Role = Role.Administrator;
db.Users.Add(user);
db.SaveChanges();

var someUser = db.Users.FirstOrDefault(u => u.UserName == username);
if (someUser.Role != Role.Administrator)
{
    throw new Exception("Should have been an admin.");
}`

If you like, you can certainly write integration tests to confirm the same behavior.

This pattern is much more powerful than the standard enum keyword. I use it frequently and I hope you find it helpful.