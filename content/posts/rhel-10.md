+++
title = "Thoughts on RHEL 10's Release Notes"
# description = ""
date = 2025-05-14
# updated = 2025-05-14
#draft = true
[taxonomies]
tags = ["linux"]
+++

Between Red Hat Summit next week and what seems to have been an accidental announcement of a GA release on the [RHEL Release dates page](https://access.redhat.com/articles/3078) (which has now been reverted), it seems clear that RHEL 10 will be released within the next week or two.
I thought it would be a good time to look over the changes listed for the RHEL 10 beta to see what might be interesting or applicable to me at work. 
I'm not much of a developer so most of my interests will be on the admin side.

* The embedded DNS server for IdM is not available because they are waiting on updates to another library. We've tried to move away from the embedded DNS server in our environment, but I can see this being an issue for anyone who does and wants to upgrade to RHEL 10 immediately. 
* RDP has replaced VNC as the graphical remote access protocol for RHEL 10's installer. I haven't tried to set up RDP on Linux before, but I *have* set up VNC on a home server. Maybe I should figure out how they're handling it in RHEL and consider switching over. 
* Valkey has replaced redis. I'm not surprised after reading some of the problems of the licensing change. 
* Firefox and Thunderbird are only available as Flatpaks in RHEL 10. It looks like this change will require logging in to the Red Hat Container Catalogue, which is slightly unfortunate because of the extra step required. On the other hand, this appears to simplify a lot of the upstream work and allow longer terms for supporting a single version. Ultimtely, I don't use RHEL on the desktop so this is all just a curiosity to me.
* The web console known as Cockpit now includes a file manager.
* The `storage` system role can now manage Stratis pools. This is the only time I've seen Stratis mentioned outside of studying fro the RHCSA exam.
* The `podman` system role can now log in to container registries. Cool and useful.
* There's a `postfix` system role. This isn't new, but I wish I knew about it before making basically the same thing for work. 


If you'd like to read the notes for yourself, they are currently hosted at [https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/10-beta/html/10.0_beta_release_notes/index](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/10-beta/html/10.0_beta_release_notes/index).
