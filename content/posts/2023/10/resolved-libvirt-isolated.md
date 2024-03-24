+++
title = "Resolved: Connection Issues on a libvirt Isolated Network to Router"
date = 2023-10-07
[taxonomies]
tags= ["resolved"]
+++

Quick answer: The isolated network auto-allocates the first address to a virtual interface for the hypervisor host. Check that your router’s IP isn’t set to the same thing.

---

I was having issues the other night with my homelab setup. Specifically, devices would randomly be unable to communicate with the router. Pinging worked, but accessing OPNsense’s web interface wasn’t. It wasn’t firewall issues either.

After running `tcpdump` on the opnsense box, I realized that my traffic wasn’t even reaching it. I double checked that they were on the same vnet (they were), then checked the ARP table on the client I was using. Sure enough, the MAC of the supposed gateway wasn’t the same as the OPNsense interface.

I took down all other VMs except the router and client to isolate the issue in case it was a misconfiguration, but the issue persisted. This meant it had to be something involving libvirt.

Sure enough, a quick Google search revealed that libvirt will still allocate an address for the host on isolated subnets – even if you disable services such as DHCP. It defaults to the first IP address in the subnet.

I changed the OPNsense LAN IP from .1 to .254 and the issue was resolved.
