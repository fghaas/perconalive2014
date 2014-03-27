#!/bin/bash

set -ex

sudo ~/stack-volumes.sh
sudo ~/iptables-hack.sh
~/devstack/rejoin-stack.sh

