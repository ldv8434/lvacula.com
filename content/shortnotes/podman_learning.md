+++
title = "Some things I've recently learned about Podman (and Docker)"
date = 2023-11-27
[taxonomies]
tags= ["shortnotes","podman"]
+++

- Podman does not require a user to have unique permissions to use it.
- Any user on a docker-enabled system that also is in the docker group can become root with one command
- The "ADD" directive in a Containerfile or Dockerfile is considered more insecure than "COPY" because it can pull remote directories.
- Podman was made with Docker command compatability in mind because the devs knew they'd never get market share otherwise.


