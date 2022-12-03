Vagrant.require_version ">= 2.0"

Vagrant.configure("2") do |config|
    config.vm.box = "kalilinux/rolling"
    config.vm.box_check_update = false
    config.vm.define "kali"
    config.ssh.username = "vagrant"
    config.ssh.password = "vagrant"
    config.ssh.insert_key = true
    config.ssh.shell = "bash"
    config.vm.synced_folder ".", "/vagrant", disabled: true

    config.vm.provider :libvirt do |domain|
      domain.disk_bus = "virtio"
      domain.driver = "kvm"
      domain.video_vram = 256
      domain.memory = 4096
      domain.cpus = 2
      domain.graphics_type = "spice"
      domain.channel :type => 'unix', :target_name => 'org.qemu.guest_agent.0', :target_type => 'virtio'
      domain.channel :type => 'spicevmc', :target_name => 'com.redhat.spice.0', :target_type => 'virtio'
    end

   config.vm.provider :virtualbox do |v|
      v.memory = 4096
      v.cpus = 2
      v.gui = true
      v.customize ["modifyvm", :id, "--vram", "128"]
      v.customize ["modifyvm", :id, "--graphicscontroller", "vmsvga"]
      v.customize ['setextradata', :id, 'GUI/ScaleFactor', '2.00']
    end

    config.vm.provision "ansible" do |ansible|
      ansible.limit = "kali"
      ansible.ask_vault_pass = true
      ansible.playbook = "ansible/playbook.yml"
      ansible.become = true
      ansible.verbose = "-vv"
      ansible.become_user = "root"
      ansible.host_key_checking = false
    end

end
