#!/usr/bin/env bash

DOMAIN="$1"
PUPPETMASTER="$2"
NAMESERVER="$3"
DIST_CODENAME=$(lsb_release -cs)

echo "$PUPPETMASTER puppet" > /etc/hosts
echo "127.0.0.1 $HOSTNAME.$DOMAIN $HOSTNAME" >> /etc/hosts
cp /etc/hosts /etc/cloud/templates/hosts.debian.tmpl

echo "domain $DOMAIN" > /etc/resolv.conf
echo "search $DOMAIN." >> /etc/resolv.conf
echo "nameserver ${NAMESERVER}" >> /etc/resolv.conf
cp /etc/resolv.conf /etc/cloud/templates/resolv.conf.tmpl

export DEBIAN_FRONTEND=noninteractive

wget --quiet https://apt.puppetlabs.com/puppetlabs-release-pc1-$DIST_CODENAME.deb -O /tmp/puppetlabs-release-pc1-$DIST_CODENAME.deb
dpkg -i /tmp/puppetlabs-release-pc1-$DIST_CODENAME.deb
apt-get update
apt-get -y upgrade
apt-get -y install puppet-agent unzip curl

echo 'export PATH="/opt/puppetlabs/bin:/opt/puppetlabs/puppet/bin:$PATH"' > /etc/profile.d/Z69-puppet.sh
source /etc/profile.d/Z69-puppet.sh

# by default root account denies access for provisioners ssh key
echo -n > /root/.ssh/authorized_keys

puppet agent --test && \
  puppet agent --onetime --no-daemonize
