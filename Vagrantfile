# -*- mode: ruby -*-
# vi: set ft=ruby :

def ip2mac(prefix, str_ip)
	@mac=prefix
	str_ip.split('.').each do |k|
		k="%02x" % k
		@mac=@mac+":"+k.to_s
	end
	return @mac
end

Vagrant.configure("2") do |config|
 (11..11).each do |i|
    config.vm.define "harv#{i}" do |node|
      node.ssh.username = 'rancher'
      node.ssh.password = 'vagrant'
      node.ssh.insert_key = false
      node.vm.box = "harvester-dev"
      node.vm.guest = 'linux'
      node.vm.hostname = "harv#{i}"
      node.vm.synced_folder '.', '/vagrant', disabled: true
      node.vm.provider :libvirt do |domain|
        domain.driver = 'kvm'
        domain.memory = 32768
        domain.cpus = 8
        domain.nested = true
        domain.management_network_name = "dev"
        domain.management_network_address = "10.5.6.0/24"
        domain.management_network_mac = ip2mac("50:50","10.5.6.#{i}")
        domain.storage :file, :size => '2048G', :bus => 'virtio'
        domain.storage :file, :size => '1024G', :bus => 'virtio'
      end
      node.vm.provision :shell, :path => 'scripts/config-first-server.sh', :upload_path => '/home/rancher/vagrant-shell'
      node.vm.provision :shell, :path => 'scripts/start-k3s.sh', :upload_path => '/home/rancher/vagrant-shell'
    end
  end
end

Vagrant.configure("2") do |config|
 (12..13).each do |i|
    config.vm.define "harv#{i}" do |node|
      node.ssh.username = 'rancher'
      node.ssh.password = 'vagrant'
      node.ssh.insert_key = false
      node.vm.box = "harvester-dev"
      node.vm.guest = 'linux'
      node.vm.hostname = "harv#{i}"
      node.vm.synced_folder '.', '/vagrant', disabled: true
      node.vm.provider :libvirt do |domain|
        domain.driver = 'kvm'
        domain.memory = 16384
        domain.cpus = 8
        domain.nested = true
        domain.management_network_name = "dev"
        domain.management_network_address = "10.5.6.0/24"
        domain.management_network_mac = ip2mac("50:50","10.5.6.#{i}")
        domain.storage :file, :size => '2048G', :bus => 'virtio'
        domain.storage :file, :size => '1024G', :bus => 'virtio'
      end
      node.vm.provision :shell, :path => 'scripts/config-agent.sh', :upload_path => '/home/rancher/vagrant-shell'
      node.vm.provision :shell, :path => 'scripts/start-k3s.sh', :upload_path => '/home/rancher/vagrant-shell'
    end
  end
end
