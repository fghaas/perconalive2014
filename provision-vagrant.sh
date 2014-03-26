#!/bin/bash

set -ex

# Get a checkout of the trove-integration git repo
# (or update it if already checked out)
cd ~
if [ -d ~/trove-integration ]; then
  cd ~/trove-integration
  git pull
else 
  git clone git://git.openstack.org/openstack/trove-integration.git
fi

cd ~/trove-integration/scripts
# Disable Swift
sed -e 's/ENABLED_SERVICES+=,s-proxy/#ENABLED_SERVICES+=,s-proxy/' -i localrc.rc
# Enable screen logging to files, and use Qemu instead of KVM for libvirt
tee -a localrc.rc <<EOF
SCREEN_LOGDIR="/opt/stack/logs"
LIBVIRT_TYPE="qemu"
EOF

# Install Redstack (this also clones, installs and enables DevStack)
./redstack install

# Set up Trove for MySQL
# (includes building the Trove-enabled MySQL image with diskimage-builder)
./redstack kick-start mysql no-clean

# Finally, copy the shell scripts into $HOME (from /vagrant), so
# they are still present even after the VM is turned into an
# appliance and is no longer managed by Vagrant.
cp /vagrant/*.sh ~
