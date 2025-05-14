+++
title = "Why I moved from Wordpress to Zola"
date = 2023-11-21
[taxonomies]
tags= ["meta","zola","wordpress"]
+++

I've used a few different site generators and blogging platforms over the years, including but not limited to:
- Wordpress
- Google Blogger 
- Tumblr
- Pelican
- MediaWiki (yes, it counts)
- DokuWiki (it counts too!)
- Zola

It should go without saying that every system has its benefits and trade-offs. 
This post about the *specific* trade-offs that made me switch from Wordpress to Zola. 

My primary issue with Wordpress is the writing. 
Gutenberg seems like it would be a very useful editor for a more traditional writer or someone who doesn't have an emphasis on technical content.
I couldn't figure out how to easily move from extended code blocks back to normal writing without using my mouse to add a new paragraph block.
(The classic editor doesn't fix this issue.)
With static site generator that rely on Markdown syntax for formatting (like Zola), it's as simple as adding a few backticks at the start and end.
I write enough code or `general monospace text` that this was a dealbreaker for me.

The second major issue was the difficulties I had in customizing the site. 
This isn't an issue of Wordpress lacking customization - Wordpress themes are popular enough for entire businesses to be built upon the back of them.
Unfortunately, the graphical editor wasn't behaving for me (primarily not reliably changing link colors to those in my color scheme) and the code side is its own monster.
I don't want to become a web developer to get my theming working.
Zola's Tera templates only require a bit more than basic HTML and CSS.

Of course, there's downsides to moving to Zola. 
The largest trade-off - and the reason that I waited so long to do so - is that there are extra steps to deploying the website. 
Wordpress is as simple as "write the content and hit publish". 
Zola requires you to have the Zola binary, compile the website, and push the content to the web server host. 
You can simplify this by writing your content on the same host as the web server, but then you lose the ability to write and publish from anywhere. 
In my case, it also means losing the ability to use graphical editors. 

The solution to that trade-off was learning to install and use Jenkins.
For the unfamiliar: Jenkins is a CI/CD tool. 
I can write my content on any host, push the "source code" to a git repo, and Jenkins will take care of the rest.
In theory, Jenkins will detect and push a new version of this site within 3 minutes of a new commit being pushed to the git repo.
So far this has worked fairly well.

The final question I can imagine someone may ask is "Lukas, Pelican is a static site generator as well. Why did you move to a different one?"
The answer is Rust. 
Zola is written in it.
I'm learning it and want to use it more.
If I encounter a bug, I want to be able to fix it.
