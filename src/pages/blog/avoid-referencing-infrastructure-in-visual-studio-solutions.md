---
templateKey: blog-post
title: Avoid Referencing Infrastructure in Visual Studio Solutions
path: blog-post
date: 2016-12-14T04:35:00.000Z
description: The dependency inversion principle states that your application’s
  abstractions should not depend on implementation details, but rather
  implementation should depend on abstractions.
featuredpost: false
featuredimage: /img/avoid-referencing-infrastructure-in-vs-solutions-760x360.png
tags:
  - clean architecture
  - dependency inversion
  - solid
  - visual studio
category:
  - Software Development
comments: true
share: true
---
The [dependency inversion principle](http://deviq.com/dependency-inversion-principle/) states that your application’s abstractions should not depend on implementation details, but rather implementation should depend on abstractions. In [Clean DDD](https://github.com/CleanDDD) architected applications, you’ll typically have a class library called Core (or something similar) which houses the domain model, including the main abstractions. Your implementation libraries (“Infrastructure”) will reference this project or assembly and implement the abstractions found within it (e.g. IFooRepository, IEmailSender). This works extremely well and produces modular, testable, loosely-coupled software in both libraries. But what about the front end of the application, the user interface layer?

At some point, you need to have the application wire up the abstractions to the implementations it will be using at runtime – you can’t run abstractions. You may use an IOC container to help with this, since they make it much easier to work with applications that follow the DI principle and the [Explicit Dependencies principle](http://deviq.com/explicit-dependencies-principle/). One of my favorite containers is [StructureMap](http://structuremap.github.io/), which can easily be configured to support the decoupling even in the UI layer.

Normally, to wire up implementations from the Infrastructure project to interfaces in the Core project, you would have some code in the UI layer that would configure the IOC container. It would include something like this:

`For<IDoSomething>().Use<DoSomethingSpecific>();`

In the above example, IDoSomething would be defined in Core, and DoSomethingSpecific would be defined in Infrastructure. Of course, the only way for this to compile is if the UI project references both Core and Infrastructure, as otherwise the compiler won’t be able to evaluate the two types referenced. This has the unfortunate side effect of making all of Infrastructure available to the UI layer at compile time (just to enable this bit of IOC container wireup logic). New developers, or experienced ones who slip, might make use of Infrastructure types directly from the UI project, introducing unwanted coupling and harming testability.

What you really want is a project dependency structure like this one:

![](/img/cleanguestbookreferences-300x179.png)

In this solution, neither the UI layer (CleanGuestbookMvc5) nor the Infrastructure projects have any knowledge of one another. If a developer tries to use a type from Infrastructure directly within the UI project, they will get a compile error (that should remind them to instead use an abstraction from Core and some dependency injection).

There are two things you need to make this work:

1. StructureMap has support for registries, which can hold rules for configuring the container when the application starts up. Put one registry in the UI project and a separate one in the Infrastructure project (so that the UI registry doesn’t need to know about any Infrastructure types). Other containers support similar approaches.
2. Configure a post-build step to manually copy the Infrastructure dll to the UI project’s output folder. Normally project references are automatically updated/copied as part of the build process. Without the project reference, you’re responsible for getting the assembly to the /bin folder, and a post-build step is an easy way to do it.

The DefaultRegistry.cs Class in UI:

```
using Core.Interfaces;
using StructureMap.Configuration.DSL;
using StructureMap.Graph;

namespace CleanGuestbookMvc5.DependencyResolution {
	
    public class DefaultRegistry : Registry {
        public DefaultRegistry() {
            Scan(
                scan => {
                    scan.TheCallingAssembly();
                    scan.AssemblyContainingType<IGuestbookRepository>(); // Core
                    scan.Assembly("Infrastructure"); // the Infrastructure DLL
                    scan.WithDefaultConventions();
		    scan.With(new ControllerConvention());
                    scan.LookForRegistries(); // find and run other registries
                });
        }
    }
}
```

Note in the above code listing the the “Infrastructure” assembly is referenced by name, rather than by using a generic (the generic reference won’t work without a project reference).

Now in the Infrastructure project, you need a registry as well (InfrastructureRegistry.cs);

```
using Core.Interfaces;
using Infrastructure.Data;
using StructureMap.Configuration.DSL;
using StructureMap.Graph;

namespace Infrastructure {
    public class InfrastructureRegistry : Registry {
        public InfrastructureRegistry() {
            Scan(
                scan => {
                    scan.TheCallingAssembly();
                    scan.AssemblyContainingType<IGuestbookRepository>(); // Core
                    scan.WithDefaultConventions();
                });
            For<IGuestbookRepository>().Use<InMemoryGuestbookRepository>();
        }
    }
}
```

Finally, in the Infrastructure project’s properties, on the Build Events tab, edit the Post-build event command line to add this:

`copy /Y "$(TargetDir)$(TargetName).dll" "$(SolutionDir)CleanGuestbookMvc5\bin$(TargetName).dll"`

![](/img/infrastructurepostbuild.png)

To demonstrate the solution working, reference an abstraction from the Core project in the UI project, and run the application:

```
using System.Web.Mvc;
using Core.Interfaces;

namespace CleanGuestbookMvc5.Controllers
{
    public class HomeController : Controller
    {
        private readonly IGuestbookRepository _guestbookRepository;

        public HomeController(IGuestbookRepository guestbookRepository)
        {
            _guestbookRepository = guestbookRepository;
        }

        public ActionResult Index()
        {
            var model = _guestbookRepository.GetById(1);

            ViewBag.Message = model.Name;

            return View();
        }
    }
}
```

![](/img/cleanguestbookrunning.png)

You can [view the sample code for this example on GitHub](https://github.com/CleanDDD/NoInfrastructureReferences).