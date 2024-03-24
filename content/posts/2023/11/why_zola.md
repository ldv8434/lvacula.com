+++
title = "Why I moved from Wordpress to Zola"
date = 2023-11-18
draft = true
[taxonomies]
tags= ["shortnotes"]
+++

I've used a few different site generators and blogging platforms over the years, including but not limited to:
- Wordpress
- Google Blogger 
- Tumblr
- Pelican
- MediaWiki (yes, it counts)
- DokuWiki (it counts too!)
- Zola

Each one comes with benefits and trade-offs. 
That should go without saying. 
This post about the *specific* trade-offs that made me switch from Wordpress to Zola. 

The first and most important was the writing. 
The topics that I like to write about often warrant the use of `monospace text` to denote commands and code. 
Inline monospace is fine, but both the block and classic editors fail at making blocks easy to insert.
Combined with the annoyances around making a simple table was enough for me to look elsewhere. 

The second major problem was customization. 
Wordpress *thrives* on being customized.
Unfortuantely, it is also a pain to customize. 
I'm not a web developer and I don't want to learn a subset of PHP to get my link colors to look right with my color scheme. 

So why didn't I immediately move after making the blog? 
Because I wanted to have the "write from anywhere" ability that Wordpress offered, while keeping ownership over the website. 
Tumblr and Blogger let you write from anywhere, but come with a lot of caveats for custom domains (or general usage). 
On the other hand, Pelican and Zola allow you full control over nearly every aspect, but you'd need to be able to build and deploy the website to a specific place from anywhere.

My new solution (and latest accomplishment on the "I did something cool!" list) is a Jenkins host to...
1. Poll for new commits in the repo
2. Build the website if new commits exist
3. Push the build if it succeeds. 
It's my first time using any kind of CI/CD and it's been an ordeal, but I have it working. 
We'll see where it goes from here!
