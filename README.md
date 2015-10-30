# vagrant-openstack-puppet

## Install

```
apt-get install -y vagrant
vagrant plugin install vagrant-openstack-provider vagrant-env
```

## Configure

Create a .env file:
```
tee > .env << EOF
export OS_PUPPETSERVER=<host>
export OS_NAMESERVER=<nameserver>
export OS_TENANT=<tenant>
export OS_USERNAME=<username>
export OS_PASSWORD=<password>
export OS_KEYNAME=<ssh_keyname>
export OS_SERVER_NAME=<hostname>
export OS_SERVER_DOMAIN=<domain>
EOF
```

Example config to bootstrap machine as monolithic mesos server:
```
export OS_PUPPETSERVER=10.10.10.10
export OS_NAMESERVER=10.10.10.100
export OS_TENANT=Test
export OS_USERNAME=rw
export OS_PASSWORD=password
export OS_KEYNAME=rw
export OS_SERVER_NAME=mesos0
export OS_SERVER_DOMAIN=mesos-monolith0.brighton0.foo.com
```

## Usage

```
# bring up
vagrant up --provider=openstack

# destroy
vagrant destroy
ssh root@puppet puppet cert clean <fqdn>
ssh-keyscan -f ~/.ssh/known_hosts -R <floating ip>
```
