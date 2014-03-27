#!/bin/bash

set -ex

# Enable this horrible hack as per
# https://wiki.openstack.org/wiki/Trove/dev-env
# (without which the guestagent can't complete
# the guest's configuration)
iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -o eth0 -j MASQUERADE
