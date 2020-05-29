---
templateKey: blog-post
title: Applying the Builder Pattern to Improve an Angular Service
path: blog-post
date: 2018-01-30T19:18:00.000Z
description: Applying the Builder Pattern to Improve an Angular Service.
  Recently I was working on an Angular/Typescript service that was building up
  some navigation-related properties, driving the menu of a SPA application.
featuredpost: false
featuredimage: /img/applying-the-builder-pattern-to-improve-angular-service.png
tags:
  - angular
  - design patterns
  - javascript
  - patterns
  - testing
  - typescript
category:
  - Software Development
comments: true
share: true
---
![Angular - Typescript](/img/angular-typescript.png)

Recently I was working on an Angular/Typescript service that was building up some navigation-related properties, driving the menu of a SPA application. The existing service had a helper method that took in two arrays full of potential validation issues on the SPA’s different tabs, and based on these it would return an appropriately-styled and configured Tab object. Initially, there were no tests, but after adding some using karma and jasmine, I had enough confidence in how the service was working to start thinking about how to [refactor](https://www.pluralsight.com/courses/refactoring-fundamentals) it. I ended up using the Builder pattern, which I hadn’t applied previously to Angular, so I thought some of you might appreciate seeing the implementation.

Before I get into the refactoring steps, let me reemphasize that the first thing I did was to get the code running under tests that verified its current behavior. This wasn’t my codebase, and I didn’t even have the luxury of pairing with one of the team members as I worked on it, so writing the tests helped me better understand the code and gave me confidence that I could change its structure without breaking its current (hopefully correct!) behavior. Once I had some tests verifying what the code did ([characterization tests](https://en.wikipedia.org/wiki/Characterization_test)), I identified a variety of [code smells](http://deviq.com/code-smells/) and refactored the original service to get it to better follow SOLID principles (unlike some JavaScript code, Angular applications are very well-suited to SOLID).

Each Tab in the navigation had a state, defined in an Enum, a cssClass (a string), and a child Section that could itself have a state (defined in a separate Enum). The states had values like Valid, Invalid, and Incomplete, among others. Within the service there were a set of helper methods that would produce Tabs with the appropriate values, like these:

```typescript
getValidTab() {
  let tab = new Tab();
  tab.cssClass = 'valid';
  tab.state = TabState.Valid;
  tab.section.state = SectionState.Valid;
  return tab;
}

getInvalidTab(bool isSectionIncomplete) {
  let tab = new Tab();
  tab.cssClass = 'invalid';
  tab.state = TabState.Invalid;
  if(isSectionIncomplete) {
    tab.section.state = SectionState.Incomplete;
  } else {
    tab.section.state = SectionState.Valid;
  }
}
```

There were a few more of these. They were called from another method, that used two arrays and a switch statement determine which of these functions to call (and with which flag parameters). I’m not a fan of flag parameters on functions – it’s generally better and clearer to just have two versions of the function – so I knew I wanted to refactor those. I also didn’t like some of the naming I saw, like `isSectionIncomplete`, because it was phrased as a falsehood. If I ever wanted to negate it, I’d have `!isSectionIncomplete` which requires a lot more mental gymnastics to parse than simply `isComplete` would. However, in this case it wasn’t so simple, since the section in question could actually have more than just two states, and thus it wasn’t true that when it wasn’t incomplete, it was complete. It might instead be invalid, for instance.

I was able to address all of these concerns by creating a TabBuilder and having it produce the appropriately configured Tabs(with Sections). Initially I used this Builder inside of the above helper methods, as an interim step. Once I had that working and all tests passing, I was able to do away with the helper methods altogether. This significantly reduced the size of the service I was working with, and made it much simpler as well. So let’s look at what the Builder pattern is and how to construct one in Typescript (or JavaScript) for use (in this case) in an Angular service.

The builder pattern is a creational design pattern that allows a complex object to be built up through a series of method calls. It is similar in intent to a Factory, but typically a factory is implemented as a single (perhaps parameterized) method. The Builder pattern offers much greater flexibility and is generally easier to follow when reading the code than a factory implementation would be for any modestly complex set of inputs. When implementing a builder, you typically create a class that creates a simple instance of the type to be created and stores it in a private instance variable. The other requirement is a method that will return the configured object, which I typically call `build()`. If you have just these two pieces in place, you have a very simple builder implementation that is really just a convoluted way of calling `new`:

```typescript
// typescript
export class FooBuilder {
  private _foo : Foo = new Foo();

  public build() : Foo {
    return this._foo;
  }
}
```

Once you have this simple structure in place, you can start to add all of the different functions that will configure the type you’re building. When you do, be sure that each function returns `this` so that you’re able to chain calls to the builder together, producing a very readable and concise code block. For example:

```typescript
// typescript
export class TabBuilder {
  private _tab : Tab = new Tab();

  public validTab() {
    _tab.state = Tab.Valid;
    _tab.cssClass = 'valid';
    return this;
  }

  public withValidSection() {
    _tab.section.state = Section.Valid;
    return this;
  }

  public build() : Tab {
    return this._tab;
  }
}
```

Now we can update the helper method above to use the builder:

```typescript
getValidTab() {
  return new TabBuilder()
             .validTab()
             .withValidSection()
             .build();
}
```

The next step once this is verified to be correct is to do away with all of the helper methods and replace them with builder calls.

## Common Cases

Of course, not all configurations of a complex object are used equally. It turns out, the “valid/valid” case is actually pretty common. It can be useful to add special methods for common cases to your builder implementation. For example, you could have something like “WithDefaultValues()” that would be a shortcut to getting an object configured with defaults. You could then build on top of this if you set it up as an instance method that returns your builder. Alternately, you can simply add static factory methods that can be called off of the Builder class directly without the need to create an instance, like this:

```typescript
export class TabBuilder {
  // other methods omitted
  public static getValidTab() {
    return new TabBuilder()
             .validTab()
             .withValidSection()
             .build();
  }
}
```

Now anywhere I had code that was calling getValidTab() I can replace it with TabBuilder.getValidTab() just as easily, but now all of the details about how I configure and construct tabs is kept inside of the TabBuilder class, and not the service where it used to reside. Thus, the design is better following [SRP](http://deviq.com/single-responsibility-principle/) and [Separation of Concerns](http://deviq.com/separation-of-concerns/) as the responsibility for configuring Tabs now resides wholly in the TabBuilder class.