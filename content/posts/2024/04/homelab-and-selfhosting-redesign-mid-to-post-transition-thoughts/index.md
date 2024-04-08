+++
title = "Homelab and Selfhosting Redesign Mid-to-Post-Transition Thoughts"
# description = ""
date = 2024-04-08
# updated = 2024-04-08
#draft = true
[taxonomies]
tags = ["selfhosting", "homelab"]
+++

In [a previous post](../../03/redesigning-my-selfhosting-setup-and-lab), I talked about plans for moving from an expensive Google Cloud VPS and a full-fat SuperMicro server to a small Dell micro PC. 
It's been serveral weeks since that post and I wanted to give an update.

As of this moment, both the VPS and the server are shut down. 
Luckily, all of the services I care about appear to be working! 
All of my goals from the previous post (except for the UPS) have been realized - especially the rootless Podman.

I'll probably make a dedicated post about some of the specific services and what was necessary for each.
For now, I'll give a bit of advice for anyone who might want to follow in my steps: 
It's probably easier to design the initial pod using `podman` commands *then* generate the Kube YAML than it is to use an existing YAML and adapt it for a different service. 
