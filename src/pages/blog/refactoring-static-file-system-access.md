---
templateKey: blog-post
title: Refactoring Static File System Access
path: blog-post
date: 2016-08-16T05:27:00.000Z
description: "Years ago, I was trying to test an application I’d written, but
  couldn’t figure out how to remove a dependency it had on the file system. At
  the time, I was familiar with unit testing, "
featuredpost: false
featuredimage: /img/photo-1470114716159-e389f8712fda_600x400-600x360.jpg
tags:
  - dependency inversion principle
  - explicit dependencies principle
  - refactoring
  - solid
  - tdd
  - unit testing
category:
  - Software Development
comments: true
share: true
---
Years ago, I was trying to test an application I’d written, but couldn’t figure out how to remove a dependency it had on the file system. At the time, I was familiar with unit testing, and had bought into its value both as a developer and as a business owner (this was software that was central to my business at that time), but I was stymied by some code that looked something like this:

`public class BannerService {
    public void SaveBanner(int publisherId, FileStream file)
    {
        // calculate a filename that isn't taken for this publisher
        string filename = CreateFileNameForPublisher(publisherId);

        var outfile = File.Create(filename);
        file.CopyTo(outfile);
        outfile.Close();

        // save record with publisherId and new file path
    }

    private string CreateFileNameForPublisher(int publisherId)
    {
        // real logic omitted
        return "";
    }
}`

Now, I could pretty easily write some unit tests for the CreateFileNameForPublisher method if I made it public or moved it into its own type, assuming it didn’t also work directly with the file system (it did). But trying to write unit tests for the SaveBanner method was proving impossible in its current form. This is another example of an [insidious dependency](/insidious-dependencies), one of those things that makes writing tests difficult and adds coupling between our business logic and our infrastructure code.

Leaving aside direct testing of CreateFileNameForPublisher, let’s look at how we can refactor SaveBanner to allow its behavior to be tested. We can test that the file creation logic actually works by either running it manually (and trusting it will continue working), or creating an integration test for it. The behavior of SaveBanner, though, should be at a higher level of abstraction. What we want to test is that it performs these operations:

* Call a method to get a new unique filename for the publisher
* Save the file using the filename retrieved
* Call a method to save a new record with the publisherid and the file path used

The first step in modifying this code to be unit testable is to create an abstraction to replace the file system operations being performed, and then copy the low level file code into an implementation of the abstraction. Something like this will work:

`public interface IFileSystem {
    void CreateFileFromStream(string filename, Stream stream);
}

public class LocalFileSystem : IFileSystem
{
    public void CreateFileFromStream(string filename, Stream stream)
    {
        var outfile = File.Create(filename);
        stream.CopyTo(outfile);
        outfile.Close();
    }
}`

Now it’s a simple matter to follow the [Explicit Dependencies Principle](http://deviq.com/explicit-dependencies-principle/) and request an instance of IFileSystem in our BannerService. At this point we can also update the FileStream parameter to simply be a Stream, too.

`public class BannerService {
    private readonly IFileSystem _fileSystem;

    public BannerService(IFileSystem fileSystem)
    {
        _fileSystem = fileSystem;
    }

    public void SaveBanner(int publisherId, FileStream file)
    {
        // calculate a filename that isn't taken for this publisher
        string filename = CreateFileNameForPublisher(publisherId);

        _fileSystem.CreateFileFromStream(filename, file);

        // save record with publisherId and new file path
    }
...
}`

Now we’ve fixed the main problem with testing SaveBanner, which was its direct dependency on the file system. However, there are still two more dependencies. The CreateFileNameForPublisher method \*also\* needs to talk to the file system, and the record saving part will of course use some data access technology. I’ll leave the last bit as an exercise for the reader since I haven’t even shown its implementation here (hint: consider a Repository). For the private method call, though, we have a couple of options.

We could use a mocking tool that will mock private methods on concrete types.

We could create another interface and move the filename logic into a new type. This might make sense, since our BannerService is likely violating the [Single Responsibility Principle](http://deviq.com/single-responsibility-principle/) and may be exhibiting the [Iceberg Class code smell](http://deviq.com/iceberg-class/), with its private functionality. However, I’ve already shown this technique for IFileSystem, so let’s consider another approach.

We could modify BannerService so that we can control the behavior of CreateFileNameForPublisher. This does require one small change to the system under test (SUT): we need to add the virtual keyword and mark the private method as protected:

`protected virtual string CreateFileNameForPublisher(int publisherId) {
    // implementation
}`

This should be a safe refactor, since we know nothing was depending on it before (because it was private).

Now we can create a test version of BannerService that inherits from BannerService and exposes this method in a way that we can alter:

`public class TestBannerService : BannerService {
    private readonly string _filenameformat;
    private readonly IFileSystem _fileSystem;

    public TestBannerService(string filenameformat, IFileSystem fileSystem)
            : base(fileSystem)
    {
        _filenameformat = filenameformat;
        _fileSystem = fileSystem;
    }

    protected override string CreateFileNameForPublisher(int publisherId)
    {
        return string.Format(_filenameformat, publisherId);
    }
}`

At this point, you can write a test that uses the TestBannerService by instantiating it with a known format string, which you can then verify is used in the call to CreateFileFromStream:

`// unit test code using Moq and xUnit `\
`public void GetFilenameSaveFileAndSaveRecord()
{
    int testPublisherId = 123;
    var mockFileSystem = new Mock<IFileSystem>();
    mockFileSystem.Setup(f => f.CreateFileFromStream("banner-123.png", It.IsAny<Stream>())).Verifiable();

    // mock the call to save the record

    var testBannerService = new TestBannerService("banner-{0}.png", mockFileSystem.Object);

    testBannerService.SaveBanner(testPublisherId, new MemoryStream());

    mockFileSystem.Verify();
}`

Having an abstraction for the file system in this case wasn’t just good for testing. It also made it much easier to move to using a CDN for the files in question. Instead of having to change many locations that worked directly with files (violating the [Open Closed Principle](http://deviq.com/open-closed-principle/)), adding support for CDNs simply involved creating a new implementation of IFileSystem for each CDN provider.