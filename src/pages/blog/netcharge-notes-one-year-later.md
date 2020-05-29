---
templateKey: blog-post
title: .netCHARGE Notes One Year Later
path: blog-post
date: 2007-01-29T17:13:21.063Z
description: About a year ago, I was setting up a new site and wanted to be able
  to accept credit cards via an existing Authorize.Net account.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - reviews
  - controls
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

About a year ago, I was setting up a new site and wanted to be able to accept credit cards via an existing Authorize.Net account. One of my long-time partners and ASPAlliance.com sponsors is [DotNetEcommerce](http://www.dotnetecommerce.com/), and one of their products is [.netCHARGE](http://dotnetcharge.com/). We picked up a copy of .netCharge and installed it into our site.

Initially I had a small challenge because the server version of the control (which I used) expects to be installed in the GAC, and so is not configured for xcopy deployment. However, the installation notes cover this and within a few minutes I was past this hurdle, and if you use the website-specific version of the control, it supports xcopy deployment with no hassle.

Using the control was pretty simple. The documentation provided an example specific to my processor, Authorize.net, which looked something like this:

<!--EndFragment-->

```csharp
// process the payment
// process the payment
int iResult;
dotnetCHARGE.CC Objcc = new dotnetCHARGE.CC();
// Transaction Details

// Transaction Details
// Transaction Details

dotnetCHARGE.CC Objcc = new dotnetCHARGE.CC();
// Transaction Details

// Transaction Details
// Transaction Details
dotnetCHARGE.CC Objcc = new dotnetCHARGE.CC();
// Transaction Details

// Transaction Details
// Transaction Details
int iResult; 
dotnetCHARGE.CC Objcc = new dotnetCHARGE.CC();
// Transaction Details

// Transaction Details
// Transaction Details
CC Objcc = new dotnetCHARGE.CC();
// Transaction Details
// Transaction Details 
Objcc.OrderID = InvoiceNumberTextBox.Text;
Objcc.Description = DescriptionTextBox.Text;
Objcc.Amount = AmountTextBox.DoubleValueOrZero;
// Card Details
// Card Details 
Objcc.Number = CardNumberTextBox.Text;
Objcc.Month = ExpirationDateTextBox.xDate.Month;
Objcc.Year = ExpirationDateTextBox.xDate.Year;
Objcc.Code = SecurityCodeTextBox.Text;
// Address Details
// Address Details 
Objcc.CardName = CardholderNameTextBox.Text;
Objcc.Company = CompanyTextBox.Text;
Objcc.Address = BillingAddressTextBox.Text;
Objcc.City = CityTextBox.Text;
Objcc.StateProvince = StateProvinceTextBox.Text;
Objcc.ZipPostal = PostalCodeTextBox.Text;
Objcc.Country = CountryTextBox.Text;
Objcc.Phone = PhoneTextBox.Text;
Objcc.Email = EmailTextBox.Text;
// Merchant Account Details
// Merchant Account Details 
Objcc.Login = "My Merchant Account Login"; 
//Objcc.TransactionKey="your transaction key"; //Merchant's Transaction Key (Only if Password is not provided) 

//Objcc.TransactionKey="your transaction key"; //Merchant's Transaction Key (Only if Password is not provided) 
//Objcc.TransactionKey="your transaction key"; //Merchant's Transaction Key (Only if Password is not provided) 
"My Merchant Account Login"; 
//Objcc.TransactionKey="your transaction key"; //Merchant's Transaction Key (Only if Password is not provided) 
//Objcc.TransactionKey="your transaction key"; //Merchant's Transaction Key (Only if Password is not provided) 
Objcc.Password = "My Top Secret Password"; //Merchant's Password (Only if Transaction Key is not provided) 
"My Top Secret Password"; //Merchant's Password (Only if Transaction Key is not provided) 
// Logging Details
// Logging Details 
Objcc.ConnectionString = "My Logging Database Connection String"; 
Objcc.CryptoPassword = "my secret crypto key so CC numbers are not in cleartext"; 
///////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////

Objcc.CryptoPassword = "my secret crypto key so CC numbers are not in cleartext";
///////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
Objcc.CryptoPassword = "my secret crypto key so CC numbers are not in cleartext";
///////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
"My L
ogging Database Connection String"; 
Objcc.CryptoPassword = "my secret crypto key so CC numbers are not in cleartext";
///////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
"my secret crypto key so CC numbers are not in cleartext";
///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
// Run the card
// Run the card
iResult = Objcc.Charge("authorizenet");
"authorizenet");
```

<!--StartFragment-->

That’s all there is to it. With that, I’ve had no problems with accepting credit cards in the last year. It’s also simple to run test numbers to test different possible scenarios. If you’re looking for a .NET credit card control that is fairly simple to set up and then just works, I’d recommend giving .netCHARGE a try.

<!--EndFragment-->