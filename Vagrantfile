# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/centos-7.6"
  config.vbguest.auto_update = false

  config.vm.define :zabbix do |server|
    server.vm.hostname = "zabbix-server-dev"
    server.vm.network "private_network", ip: "192.168.33.5"
    
    server.vm.provision :itamae do |itamae|
      itamae.sudo = true
      itamae.recipes = ['./recipe.rb']
    end
  end
end
