Just an experiment/proof-of-concept. My company is building a rails app that
provides an api that conforms to [JsonApi](http://jsonapi.org/). This script
can be called with the URL of one of our searches (e.g.,
http:://server.com/search.json?somesearchparams) as the first command-line
argument and it will look at the linked documents in the result records and
embed them in the document. For example, if the original search result doc
looked like this:

    {
      records: [
        {
          id: 1,
          links: {
            firstitem: "http://example.com/firstitem/312.json",
            seconditem: "http://example.com/firstitem/312.json"
          }
        }
      ]
    }

crawl.io will make it look like this.

    {
      records: [
        {
          id: 1,
          firstitem: {
            id: 312,
            href: "http://example.com/firstitem/312.json",
            foo: "bar"
          },
          seconditem: {
            id: 645,
            href: "http://example.com/seconditem/645.json"
            baz: "blah blah"
          },
          links: {
            firstitem: "http://example.com/firstitem/312.json",
            seconditem: "http://example.com/seconditem/645.json"
          }
        }
      ]
    }

It only crawls one level deep for now. In our situation, automatically crawling
all of them would cause infinite loops and I haven't thought about solving that
yet.

The point of all this is that it uses [io](http://iolanguage.org) and it uses
futures so that those links will be pulled in asynchronously and will not block
until they are actually read. All the script does is reJSONize it and print it,
which means it probably starts blocking fairly quickly, but in a more real
world type of scenario, it means that other processing code could proceed
before the embedded documents have been retrieved.

But really, I just wanted to use io for something.
