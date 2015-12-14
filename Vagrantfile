# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "golden"
  config.vm.box_url= "BOX/ubuntu-1404lts-vagrant.box"
  config.ssh.forward_agent = true
  #config.ssh.username = "vagrant"
  #config.ssh.password = "vagrant"
  {
    :golden => {
      :hostname       => 'golden.local',
    }
  }.each do |name,cfg|
    config.vm.define name do |vm_config|
      vm_config.vm.hostname = cfg[:hostname]
      vm_config.vm.provider :virtualbox do |vbox|
        vbox.name = "#{vm_config.vm.hostname}"
        end
      end
    end 
end
