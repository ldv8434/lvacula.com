+++
title = "needs-reboot, Satellite, and Ansible"
description = "An explainer on using Ansible within Satellite to detect when a server requires a reboot."
date = 2024-11-21
# updated = 2024-11-21
draft = true
[taxonomies]
tags = []
+++

This post outlines a solution I came up with for a recent problem at work: detecting if servers required a reboot after an update. 
I'll explain the problem and provide the solution in the form of some Ansible job templates for use in Red Hat Satellite 6.15.

---

# Problem

Prior to RHEL9, you could use the `katello-host-tools-tracer` package to provide Satellite with information about if a host required any services to be restarted. 
This method is no longer supported and as far as I can tell there is no alternative integrated into Satellite. 
However, you can use the command `dnf needs-restarting -r` on the host to list services that will require a reboot to benefit from updates. 
This is an ideal time to use Ansible and the job templates within Satellite.

# Solution

This solution uses three job templates: one to collect information from hosts, one to safely reboot the hosts, and one to reset the host facts created by the first one.

The job templates can be created in "Hosts -> Templates -> Job Templates". 
You can copy from a pre-existing playbook job, or create a new one and change "Job -> Provider Type" to "Ansible".
You'll also need to enable the checkbox "Ansible -> Enable Ansible Callback" to allow the hosts to send facts back to Satellite.
_This is critical._

This is the job template to check for the reboot and store the host fact.
```yaml
---
- hosts: all
  tasks:
    - name: Run needs-restarting check
      shell: dnf needs-restarting -r
      changed_when: false
      register: needs_restarting_result
      failed_when: false

    - name: Register fact
      set_fact: 
        needs_restarting: "{{ (needs_restarting_result.rc == 1) | bool }}" 
```

This job template will allow you to restart the servers. 
```yaml
---
- hosts: all
  tasks:
    - name: Safety check
      ansible.builtin.debug:
        msg: "Has \"restart_safety_variable\" been set to \"YES\"?: {{ restart_safety_variable }}"
      failed_when: restart_safety_variable != "YES" 
  
    - name: Reboot with 10 minute timeout
      ansible.builtin.reboot:
        reboot_timeout: 600
  
    - name: Register fact
      set_fact: 
        needs_restarting: false

# Add an input in the job template with the following parameters:
# Name: "restart_safety_variable"
# Required: enabled
# Input Type: User input
# Value Type: Plain
# Advanced: disabled
# Hidden value: disabled
# Options: (blank)
# Default: "NO"

```
It's possible to use the "Ansible Command" job with a "restart" command, but this method offers a few benefits:
- It will automatically reset the `needs_restarting` variable to `false`.
- It will detect if the host came back online.
I've also included a "safety" feature that will fail the playbook if "YES" is not entered while configuring a job execution to prevent a potential accident.
To use it, enter "YES" into the "restart_safety_variable" box on the target selection screen when running the job.

Finally, this job template is either to get the initial facts for each host, or to reset everything if you've done some manual reboots. 
```yaml
---
- hosts: all
  tasks:
    - name: Register fact
      set_fact: 
        needs_restarting: false
```

You can search for which hosts need a restart by going to "Hosts -> All Hosts" and searching for `facts.needs_restarting = true`. 

