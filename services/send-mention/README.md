Send a mention to an external site's mention API.

Requests the page at the target url, looks for webmention endpoint and uses it. Failing that, it looks for a pingback endpoint and uses that.

For protection, in case this is ever used by the public, should probably verify that the content at the source url actually contains a reference to the target url. Otherwise it's just a spam vector. But then I don't see opening these to the public unless someone wants to pay me to manage that infrastructure.

Inputs:
- source url
- target url
