#!/bin/sh

set -ex

if ! vgs | grep stack-volumes; then
  losetup -f /opt/stack/data/stack-volumes-backing-file
  vgchange -ay stack-volumes
fi
