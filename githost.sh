#!/bin/bash
# Fetch hosts file from tinsfox-github-hosts to /etc/hosts
wget --output-document /etc/hosts https://github-hosts.tinsfox.com/hosts
