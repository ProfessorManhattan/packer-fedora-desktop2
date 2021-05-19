# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.ssh.insert_key = false
  config.ssh.password = "vagrant"
  config.ssh.username = "vagrant"

  config.vm.box = "ProfessorManhattan/Fedora-Desktop"
  config.vm.name = "Fedora Desktop"

  config.vm.boot_timeout = 600

  config.vm.define "fedora" do |fedora|
    fedora.vm.box = "ProfessorManhattan/Base-Fedora-Desktop"
    fedora.vm.hostname = "vagrant-fedora"
    fedora.vm.network "private_network",
      ip: "172.24.24.3",
      netmask: "255.255.255.0"

    fedora.vm.provider "hyperv" do |v|
      v.cpus = 2
      v.linked_clone = true
      v.maxmemory = 4096
    end

    fedora.vm.provider :libvirt do |libvirt, override|
      libvirt.cpus = 2
      libvirt.memory = 4096
      # Use WinRM for the default synced folder; or disable it if
      # WinRM is not available. Linux hosts don't support SMB,
      # and Windows guests don't support NFS/9P/rsync
      # See https://github.com/Cimpress-MCP/vagrant-winrm-syncedfolders
      if Vagrant.has_plugin?("vagrant-winrm-syncedfolders")
          override.vm.synced_folder ".", "/vagrant", type: "winrm"
      else
          override.vm.synced_folder ".", "/vagrant", disabled: true
      end
      # Enable Hyper-V enlightments, see
      # https://blog.wikichoon.com/2014/07/enabling-hyper-v-enlightenments-with-kvm.html
      libvirt.hyperv_feature :name => 'stimer',  :state => 'on'
      libvirt.hyperv_feature :name => 'relaxed', :state => 'on'
      libvirt.hyperv_feature :name => 'vapic',   :state => 'on'
      libvirt.hyperv_feature :name => 'synic',   :state => 'on'
    end

    fedora.vm.provider "virtualbox" do |vb|
      # Enable, if Guest Additions are installed, whether hardware 3D acceleration should be available
      vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
      vb.customize ["modifyvm", :id, "--graphicscontroller", "vmsvga"]
      # Enable the use of hardware virtualization extensions (Intel VT-x or AMD-V) in the processor of your host system
      vb.customize ["modifyvm", :id, "--hwvirtex", "on"]
      vb.customize ["modifyvm", :id, "--vram", "128"]
      vb.check_guest_additions = true
      vb.cpus = 2
      vb.memory = 4096
    end

    fedora.vm.provider "vmware_workstation" do |v|
      v.enable_vmrun_ip_lookup = false
      v.gui = true
      v.vmx["RemoteDisplay.vnc.enabled"] = "false"
      v.vmx["RemoteDisplay.vnc.port"] = "5900"
      v.vmx["ethernet0.virtualDev"] = "vmxnet3"
      v.vmx["hgfs.linkRootShare"] = "FALSE"
      v.vmx["memsize"] = "4096"
      v.vmx["numvcpus"] = "2"
      v.vmx["scsi0.virtualDev"] = "lsisas1068"
      v.whitelist_verified = true
    end
  end
end
