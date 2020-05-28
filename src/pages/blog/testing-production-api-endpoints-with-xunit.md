---
templateKey: blog-post
title: Testing Production API Endpoints with xUnit
date: 2019-07-02
path: /testing-production-api-endpoints-with-xunit
featuredpost: false
featuredimage: /img/testing-production-api-endpoints-with-xunit.png
tags:
  - asp.net core
  - tdd
  - web api
  - xunit
category:
  - Software Development
comments: true
share: true
---

I'm a big fan of unit tests and integration tests and have written about them frequently. I also [authored the original docs on writing integration tests in ASP.NET Core](https://docs.microsoft.com/en-us/aspnet/core/test/integration-tests?view=aspnetcore-2.2) using TestHost and related types. However, sometimes it's worthwhile to be able to test actual, live API endpoints. This article will lay out a relatively simple way to do this in a configurable manner using xUnit. In the past, I might have used a Visual Studio Web Test for this purpose, but [Microsoft is dropping support for these](https://devblogs.microsoft.com/devops/cloud-based-load-testing-service-eol/) (particularly in the cloud) so I needed a new solution.

Since these are "real" tests, they also need to be able to deal with real authorization. To that end, I started from [an IdentityServer sample that Brock built which you can find here](https://github.com/brockallen/IdentityServerAndApi). It configures a one-project API solution with IdentityServer for auth. I modified it slightly and added tests to it and you can find [my code for testing live API endpoints using xUnit here](https://github.com/ardalis/TestSecureApiSample).

Testing an API endpoint is itself a pretty simple thing to do assuming the API you're testing is running and you can get to it. These aren't always easy tasks in all environments, especially during automated builds, but unfortunately they're outside the scope of this article. If you just want to test this out locally, you just need to make sure you launch the web app before you run the tests (if you expect them to pass).

If your application supports health checks, which I recommend, your first test can simply target the health check endpoint. If it's doing its job, it should provide you with reasonable confidence that the API is working (or not). The code to do so might look like this:

```
[Fact]
public async Task GetPublicHealthEndpoint()
{
    var apiClient = new HttpClient();

    var apiResponse = await apiClient.GetAsync($"{ApiBaseUrl}/health");

    Assert.True(apiResponse.IsSuccessStatusCode);

    var stringResponse = await apiResponse.Content.ReadAsStringAsync();

    Assert.Equal("Healthy", stringResponse);
}
```

A few things to note real quick:

- The test is async. This is a nice xUnit feature and one that makes it much nicer to work with async code like `HttpClient` exposes
- The protocol and domain and base route of the API are not hard-coded.

We might be targeting an API that could be running in any number of locations. It might be running locally, or it could be in a local container or Kubernetes cluster with its own IP address or local domain. It could be deployed in Azure or AWS or anywhere else for that matter. It's important that the test be able to have the API's location passed into it. However, that's not how xUnit works.

If you do some research into this, you'll find that xUnit specifically doesn't allow things like passing inputs in via command line arguments. So, if you want to make a flexible, environment-specific test that you can run locally and then your CI server can run within its environment and your deployment can run a post-deployment check to ensure everything works in production, you need to find a different way.

That way is environment variables, which you can read in your tests (and set in your CI/CD scripts).

In addition to the API base URL, once you add auth into the mix you're likely to also need to pass in the base URL for your identity server or STS instance. Thus, your test might have these properties and set them accordingly:

```
public string IdentityBaseUrl { get; set; } = Config.BASE_URL;
public string ApiBaseUrl { get; set; } = Config.BASE_URL;

// constructor
public TestApiEndpoints()
{
    string identityBaseUrl = Environment.GetEnvironmentVariable("IdentityBaseUrl");
    if (!String.IsNullOrEmpty(identityBaseUrl))
    {
        IdentityBaseUrl = identityBaseUrl;
    }
    string apiBaseUrl = Environment.GetEnvironmentVariable("ApiBaseUrl");
    if (!String.IsNullOrEmpty(apiBaseUrl))
    {
        ApiBaseUrl = apiBaseUrl;
    }
}
```

You can configure your default (dev local, perhaps) URLs as constants in another file so you're able to run the tests without having to set the environment variables every time.

## Testing Secure Live API Endpoints with xUnit and IdentityServer

Ok, so testing a public health check API is pretty simple - what about a secured API endpoint, where you first need to get a token and then you need to present the token during subsequent API calls? Here's some sample code to get an auth token from an STS given a known username/password (note this is using the `IdentityBaseUrl` configured above):

```
private async Task<string> GetAccessToken()
{
    var client = new HttpClient();
    var disco = await client.GetDiscoveryDocumentAsync(IdentityBaseUrl);
    if (!String.IsNullOrEmpty(disco.Error))
    {
        throw new Exception(disco.Error);
    }
    var response = await client.RequestTokenAsync(new TokenRequest
    {
        Address = disco.TokenEndpoint,
        GrantType = IdentityModel.OidcConstants.GrantTypes.ClientCredentials,
        ClientId = "spa",

        Parameters =
        {
            { "username", "alice"},
            { "password", "alice"},
            { "scope", IdentityServerConstants.LocalApi.ScopeName }
        }
    });
    return response.AccessToken;
}
```

You can build this into its own test to verify it works. Again, this requires the auth server endpoint to be running when you run the test:

```
[Fact]
public async Task GetAccessTokenWithAliceCreds()
{
    string token = await GetAccessToken();

    Assert.False(string.IsNullOrWhiteSpace(token));
}
```

Now that you have the code to get a token using a known good user/password, building a real API endpoint test is pretty straightforward:

```
[Fact]
public async Task HitApiEndpoint()
{
    string token = await GetAccessToken();

    var apiClient = new HttpClient();
    apiClient.SetBearerToken(token);

    var apiResponse = await apiClient.GetAsync($"{ApiBaseUrl}/test");

    Assert.True(apiResponse.IsSuccessStatusCode);

    var stringResponse = await apiResponse.Content.ReadAsStringAsync();

    dynamic result = JsonConvert.DeserializeAnonymousType(stringResponse, new { message = "" });
    Assert.Equal("Hello API", result.message);
}
```

## But can you script it?

You may want to be able to launch the web server and run the tests from a command prompt without having to do any manual work. [I wrote about this first here](https://twitter.com/ardalis/status/1144026948492058625). One challenge with scripting the running of ASP.NET Core apps is that by default they expect you to call `dotnet run` from the project root. But if I want to run the script from the root of my GitHub repository, or from my test project folder, that's obviously a problem. Fortunately, you can use this script to accomplish the task in a Windows cmd prompt:

```
pushd WebApp
start dotnet run
popd
pushd TestProject
dotnet test
popd
```

The above script [runs from the root of my GitHub repository](https://github.com/ardalis/TestSecureApiSample/blob/master/RunAndTest.bat), so if you clone or download the repo and run it (on Windows) it should work. Running the RunAndTest.bat file should produce something like this:

[![RunAndTest.bat screenshot](/img/image-1024x369.png)](/img/image-1024x369.png)

That's all you need to write tests that consume live API endpoints, wherever they're running. If you found this helpful, consider helping others find it by retweeting it using the tweet below, along with your own comment. Thanks!

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Testing Production API Endpoints with xUnit<br><a href="https://t.co/xsFoZWIHHg">https://t.co/xsFoZWIHHg</a></p>— Steve "ardalis" Smith (@ardalis) <a href="https://twitter.com/ardalis/status/1146166112230498306?ref_src=twsrc%5Etfw">July 2, 2019</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

[Download the GitHub sample associated with this article here](https://github.com/ardalis/TestSecureApiSample).
