# -*- mode: ruby -*-
# vi: set ft=ruby :
# TODO Set RAM to at least 4GB
Vagrant.configure("2") do |config|

  config.ssh.insert_key = false

  config.vm.define "fedora" do |fedora|
    fedora.vm.box = "ProfessorManhattan/Base-Fedora-Desktop"
    fedora.vm.hostname = "vagrant-fedora"
    fedora.vm.network "private_network",
      ip: "172.24.24.3",
      netmask: "255.255.255.0"
    fedora.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--vram", "256"]
      vb.memory = 8192
      vb.cpus = 4
    end
  end
end
