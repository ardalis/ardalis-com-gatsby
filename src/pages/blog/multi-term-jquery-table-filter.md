---
templateKey: blog-post
title: Multi-Term jQuery Table Filter
path: blog-post
date: 2016-06-30T06:36:00.000Z
description: Recently I was mentoring a client who needed a simple filter for a
  table of data. In this case, they weren’t using a viewmodel-based framework,
  so it wasn’t an option to simply modify the collection to which the table was
  bound.
featuredpost: false
featuredimage: /img/multitermfilter.png
tags:
  - javascript
  - jquery
category:
  - Software Development
comments: true
share: true
---
Recently I was mentoring a client who needed a simple filter for a table of data. In this case, they weren’t using a viewmodel-based framework, so it wasn’t an option to simply modify the collection to which the table was bound. We needed to use old school jQuery. Fortunately, a bit of searching yielded some code that mostly did the trick. We cleaned it up a bit and enhanced it. The source version didn’t have any attribution; my cleaned-up version is available as a [jsFiddle](http://jsfiddle.net/ardalis/u4121h6d/).

The bulk of the code is all in the keyup function of the search textbox:

`$("#searchInput").keyup(function () {     // Split the current value of the filter textbox
    var data = this.value.split(" ");
    // Get the table rows
    var rows = $("#fbody").find("tr");
    if (this.value == "") {
        rows.show();
        return;
    }
    
    // Hide all the rows initially
    rows.hide();

    // Filter the rows; check each term in data
    rows.filter(function (i, v) {
        for (var d = 0; d < data.length; ++d) {
            if ($(this).is(":contains('" + data[d] + "')")) {
                return true;
            }
        }
        return false;
    })
    // Show the rows that match.
    .show();
});`



The split function is what allows the textbox to support multiple terms. In the fiddle, test it out on the right by typing in ‘cat two’. After typing in just ‘cat’ you should only see two records, but once you add another term, it shows the row that contains ‘two’ as well. Basically, it’s performing an OR based search on the terms being provided.

Once the terms are split into the data array, the function gets the set of rows in the table. Then, it makes sure all rows are displaying and exits the function if the input box is empty. If it’s not empty, the filtering takes place by first hiding all of the rows, and then running a filter function. The filter function removes records from an array if the associated function returns false, and keeps them if it returns true. In this case, it will return true if the row passes jQuery “:contains” selector for any element of the data array of terms. Any one term is sufficient, since it’s an OR condition. If no term is matched, the function returns false and that row is not included. The “.show();” at the end is chained onto the result of the filter, so all of the rows that are found are displayed.

Normally the “:contains” selector is case-sensitive, so searching for ‘cat’ would not find rows that only contained ‘Cat’. There’s not an easy way to fix this from within the function itself. Rather, you can [make jQuery :contains case-insensitive](https://css-tricks.com/snippets/jquery/make-jquery-contains-case-insensitive/), like this:

`// make contains case insensitive globally // (if you prefer, create a new Contains or containsCI function)
$.expr[":"].contains = $.expr.createPseudo(function(arg) {
    return function( elem ) {
        return $(elem).text().toUpperCase().indexOf(arg.toUpperCase()) >= 0;
    };
});`



Try it:

<!--<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
			xmlns:dc="http://purl.org/dc/elements/1.1/"
			xmlns:trackback="http://madskills.com/public/xml/rss/module/trackback/">
		<rdf:Description rdf:about="https://ardalis.com/multi-term-jquery-table-filter"
    dc:identifier="https://ardalis.com/multi-term-jquery-table-filter"
    dc:title="Multi-Term jQuery Table Filter"
    trackback:ping="https://ardalis.com/multi-term-jquery-table-filter/trackback" />
</rdf:RDF>-->