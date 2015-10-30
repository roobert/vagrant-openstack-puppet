require 'vagrant-openstack-provider'
require 'vagrant-env'

Vagrant.configure('2') do |config|

  config.env.enable
  config.vm.box               = ENV['OS_SERVER_NAME']
  config.ssh.username         = 'debian'
  config.ssh.private_key_path = '~/.ssh/id_rsa'
  config.ssh.shell            = "bash"

  config.vm.provider :openstack do |os|
    os.openstack_auth_url = 'http://openstack.brandwatch.com:5000/v2.0'
    os.server_name        = ENV['OS_SERVER_NAME']
    os.username           = ENV['OS_USERNAME']
    os.password           = ENV['OS_PASSWORD']
    os.tenant_name        = ENV['OS_TENANT']
    os.flavor             = 'sys.robw'
    os.image              = 'Debian Jessie'
    os.keypair_name       = ENV['OS_KEYNAME']
    os.floating_ip_pool   = 'ext-net'
    os.sync_method        = 'none'
  end

  config.vm.provision "file", source: "bootstrap.sh", destination: "/tmp/bootstrap.sh"
  config.vm.provision "shell",
    inline: "/usr/bin/sudo /bin/bash /tmp/bootstrap.sh #{ENV['OS_SERVER_DOMAIN']} #{ENV['OS_PUPPETSERVER']} #{ENV['OS_NAMESERVER']}"
end
