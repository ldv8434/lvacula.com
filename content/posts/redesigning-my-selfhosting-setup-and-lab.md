+++
title = "Home Lab and Selfhosting Redesign Thoughts"
description = "Planning out my homelab setup"
date = 2024-03-09
# updated = 2024-03-09
#draft = true
[taxonomies]
tags = ["selfhosting", "homelab"]
+++

I've been hosting some of my own services since 2019. 
It started as just a Wordpress blog, but now I have things like Nextcloud and Shaarli that give me tangible benefits. 
However, these services are currently spread across about 5 different servers and nearly none of them are worth the price for what they do individually. 
The goal of this post is to share my thoughts and possibly collect some feedback about how to go about changing things. 

(Side note: Google says that I've spent nearly $1500 in their cloud since April 2019. That sounds like a lot, but the amount I've gained from learning to use it has been a lot more.)

## The Current Setup

Currently, I have a server in Google Cloud that I pay ~$30 a month for. 
It hosts Nextcloud, Mediawiki, [my blog](https://lvacula.com), and some other smaller services. 
The VPS is running Rocky Linux, and the services are all in Docker.
My primary reason for using it is not a particularly great one - it's what I've been using since I started selfhosting. 
That's... not a great reason.
$30 for 2 vCPUs and 4GB of RAM is enough to buy the equivelent Raspberry Pi model every 2 months.
However, it also gives me a different IP (so nobody is who tries to DDOS me will kill my home network connectivity) and it's resilient to the semi-regular power outages I have at home. 

In addition to that server, I also have a used SuperMicro server that I use for a mix of home lab and selfhosting. 
I've got several VMs running under KVM - including an OpnSense router to put them all in a private subnet. 
It also serves as a jumpbox to my network if I'm out somewhere and need to access my home network (though I won't give details for security reasons).
It's a really cool setup and has been fun for learning Ansible + networking, but the power usage really high for what's essentially just running Gitea, Jenkins, and Vaultwarden. 
The trade-off is that I get way more bang for my buck than the VPS, but I waste a lot of electricity on unused potential.

Two other servers of note:
- An OVH VPS that is a simple Wireguard tunnel + nginx stream proxy to the SuperMicro for I-don't-want-to-share-my-home-IP reasons.
- A Dell mini PC for testing things when I don't want to provision a new VM in KVM, and for hosting some friends' stuff that doesn't need 90+% uptime.

## The Proposed Setup

In my theoretical new setup:
- The Google VPS would be removed.
- The blog is migrated to Cloudflare Pages or Github Pages.
- All services are moved to a different domain (`vacula.xyz` instead of `lvacula.com`).
- All services are moved to a Dell micro PC with a UPS for power.
- All services are moved to rootless Podman.
- All services are separated into per-service pods and mapped to different ports from 8080 to 8090, then reverse-proxied out to the OVH VPS.
- The SuperMicro server is powered down unless I'm actively using it for home lab or game server hosting. 

The key part of this for me is the move from bare-metal services and Docker to rootless Podman. 
The security benefits of it are almost too incredible to *not* use it. 
Additionally, I want to be able to help document it and `podman kube play ...` + kube YAML system because `podman compose` is *not* a perfect replacement for `docker compose`. 

Do you have thoughts on this?
Do you use Podman for your self-hosting setup? 
Then please, dear reader, email me with your advice and knowledge. 
My email is "lukas" at this domain. 
