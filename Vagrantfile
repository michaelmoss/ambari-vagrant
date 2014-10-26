# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "centos65-x86_64-20140116"


  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", 4096] # RAM allocated to each VM
    vb.customize ["modifyvm", :id, "--cpus", 2]
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
  end

  config.vm.provision :shell, :path => "bootstrap.sh"
  config.vm.provision :shell, :path => "blueprint-1-node.sh"
  config.vm.provision :shell, :path => "post-install.sh"

  config.vm.define :c6401 do |c6401|
    #c6401.vm.provision :shell, :path => "start-ambari-server.sh"
    c6401.vm.hostname = "c6401.ambari.apache.org"
    c6401.vm.network :private_network, ip: "192.168.64.101"
    c6401.vm.network "forwarded_port", guest: 50095, host: 50095

  end

end
