Fetch a live OPML link containing a blogroll, poll each of the entries in the blogroll for their latest posts, and return a list of most recent posts by blog.

Intended to be used by client-side javascript to display an active blogroll on a page. So it should be optimized to minimize network activity as much as possible.

Inputs:
- Link to OPML file
- State reference

Outputs: 
- State reference
- Array of
    - blog_name,
    - blog_permalink,
    - last_post_date,
    - last_post_title,
    - last_post_permalink,
    - last_post_author

Some sort of state object, table, or something should be passed into this, so we only need to fetch posts if the target site has actually changed since the last time we looked.

The state reference can just be an array of json objects:
- last_poll_date
- blog_feed_uri
- last_feed_update_date
- blog_name
- blog_permalink
- last_post_date
- last_post_title
- last_post_permalink
- last_post_author
