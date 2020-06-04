---
templateKey: blog-post
title: Test Secure Web APIs with Visual Studio Web Tests
path: /test-secure-web-apis-with-visual-studio-web-tests
date: 2018-07-24
featuredpost: false
featuredimage: /img/test-secure-api-with-visual-studio-web-test-760x360.png
tags:
  - load testing
  - security
  - testing
  - web api
category:
  - Security
  - Software Development
comments: true
share: true
---
A common approach to securing APIs is through the use of bearer tokens, like JWT. If you’re using JWT, [you may find this site useful to easily examine JWT token contents](https://jwt.io/). A common scenario when working with APIs secured by bearer tokens is to have to do something like this:

1. Send credentials to token server to get a token (with some limited lifetime)\
2. Use the token from step 1 in the header of request to API method

Failure to include a valid token will typically result in a 401 Not Authorized response from the API.

You can test this sort of thing manually using a tool like Postman by simply having two requests configured. You make the request to an endpoint like “/connect/token” to get the JWT token. Then you copy that token from the response of that request and paste it into your API request’s header as an Authorization Bearer token:

[![postman-bearer](/img/postman-bearer.png)](/img/postman-bearer.png)

This is great, but if we’re trying to write web tests, and more importantly, load tests, for our API, how do we perform this dance there?

The first step is to create an extraction rule that will pull the token from the first request. You can read [this post by Eric Fleming to see how to use an extraction rule to extract a token from a request](https://ericflemingblog.wordpress.com/2015/08/31/using-extraction-rules-in-your-web-tests/), with some sample code you can grab if you need it. His example shows how to use the extraction rule in the UI, but if you have a coded web test (as most of mine are), you would use the rule like so:

```csharp
var jsonExtractRule = new JsonExtractionRule();
jsonExtractRule.Token = "access_token";
jsonExtractRule.ContextParameterName = "token";

request0.ExtractValues += new EventHandler<ExtractionEventArgs>(jsonExtractRule.Extract);
yield return request0;
request0 = null;
_token = new AuthToken(this.Context["token"].ToString());
```

Side Note: If your Visual Studio web tests fail with weird security errors, you might try adding this to your coded web tests:

```csharp
ServicePointManager.SecurityProtocol |= SecurityProtocolType.Tls12;
ServicePointManager.SecurityProtocol |= SecurityProtocolType.Ssl3;
```

The web tests don’t automatically use more recent secure protocols, so you have to specify them using this code.

Back to the API testing topic… we now have a token. In the code above I assigned it to a local variable, _token, in my coded web test (wrapped in my custom AuthToken class – see below). You don’t have to do this, since you can just use the Context collection directly, but I didn’t want to have to make the token request \*every time\* I make the API call. In real applications, it’s likely that clients will make a request for a token, that token will last for some period of time, and the client will reuse that token many times before requesting a new one. To model this in my tests, I assign the token result to a static property on my test, wrapped in a type that includes the actual token string and when it was procured:

```csharp
public class AuthToken
{
    public AuthToken(string tokenValue)
    {
        TokenValue = tokenValue;
    }
    public string TokenValue { get; }
    public DateTime DateCreated { get; } = DateTime.Now;
}
```

Now in my coded web test, instead of making a request to get the token every run through the test, I only do so when the token is either null (the first time the test is run) or a certain amount of time has passed (10 minutes in this case – only matters for longer running load tests):

```csharp
// get a new token every 10 minutes, not every request
if (_token == null || _token.DateCreated.AddMinutes(10) < DateTime.Now)
{
    WebTestRequest request0 = new WebTestRequest($"https://{subDomain}{mainDomain}/connect/token");
    request0.Method = "POST";
    request0.Headers.Add(new WebTestRequestHeader("Authorization", "Basic CREDS_GO_HERE"));

    var jsonExtractRule = new JsonExtractionRule();
    jsonExtractRule.Token = "access_token";
    jsonExtractRule.ContextParameterName = "token";

    request0.ExtractValues += new EventHandler<ExtractionEventArgs>(jsonExtractRule.Extract);
    yield return request0;
    request0 = null;
    _token = new AuthToken(this.Context["token"].ToString());
}
```

With this in place, I can run tests for one or more API endpoints that require tokens, but only intermittently make requests for new tokens. Obviously you can tweak this to suit your own application’s expected behavior.

By the way, if you’re interested in learning more about[Web Application Performance and Scalability Testing, check out my Pluralsight course on this subject](https://www.pluralsight.com/courses/web-perf). It’s a bit old but it’s mostly conceptual and the concepts don’t change.