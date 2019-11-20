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
      itamae.recipes = ['./bootstrap.rb']
      itamae.yaml = './nodes/zabbix.yml'
    end

    # The following code doesen't work.
    # Because activesuppor tequire Ruby 2.5 or higher.
    # But Vagrant Ruby version is 2.4.9.
    # Someone already reported this issue for them on GitHub.
    # https://github.com/vvchik/vagrant-serverspec/issues/37

    # server.vm.provision :serverspec do |spec|
    #   spec.pattern = '*_spec.rb'
    #   spec.error_no_spec_files = false
    #   spec.html_output = true
    # end
  end
end
