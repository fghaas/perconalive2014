#!/bin/bash

set -ex

# For neutron 
# netid=`neutron net-show private | sed -ne 's/|[[:space:]]\+id[[:space:]]\+|[[:space:]]\+\(.\+\)[[:space:]]\+|/\1/p'`

# For nova-network
netid=`sudo nova-manage network list | tail -n1 | awk '{ print $9 }'`

trove create testtrove 9 \
  --size 1 \
  --datastore mysql \
  --datastore_version mysql-5.5 \
  --nic net-id=$netid
