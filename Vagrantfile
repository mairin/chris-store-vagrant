# This guide is optimized for Vagrant 1.7 and above.
# Although versions 1.6.x should behave very similarly, it is recommended
# to upgrade instead of disabling the requirement below.
Vagrant.require_version ">= 1.7.0"

Vagrant.configure("2") do |config|

  config.vm.box = "generic/fedora28"

  # Disable the new default behavior introduced in Vagrant 1.7, to
  # ensure that all Vagrant machines will use the same SSH key pair.
  # See https://github.com/mitchellh/vagrant/issues/5005
  config.ssh.insert_key = false

  # Forward traffic on the host to the development server on the guest.
  # You can change the host port that is forwarded to 5000 on the guest
  # if you have other services listening on your host's port 80.
  config.vm.network "forwarded_port", guest: 6543, host: 6543

  # This is an optional plugin that, if installed, updates the host's /etc/hosts
  # file with the hostname of the guest VM. In Fedora it is packaged as
  # ``vagrant-hostmanager``
  if Vagrant.has_plugin?("vagrant-hostmanager")
     config.hostmanager.enabled = true
     config.hostmanager.manage_host = true
  end

  # Comment this line if you would like to disable the automatic update during provisioning
  config.vm.provision "shell", inline: "sudo dnf upgrade -y"

  # bootstrap and run with ansible
  config.vm.provision "shell", inline: "sudo dnf -y install python2-dnf libselinux-python"
  config.vm.provision "ansible" do |ansible|
    ansible.verbose = "v"
    ansible.playbook = "devel/ansible/playbook.yml"
  end

  # Create the bodhi dev box
  config.vm.define "ChRIS-store" do |ChRIS-store|
    ChRIS-store.vm.host_name = "ChRIS-store-devel"

    bodhi.vm.provider :libvirt do |domain|
        # Season to taste
        domain.cpus = 4
        domain.cpu_mode = "host-passthrough"
        domain.graphics_type = "spice"
        # The unit tests use a lot of RAM.
        domain.memory = 2048
        domain.video_type = "qxl"

        # Uncomment the following line if you would like to enable libvirt's unsafe cache
        # mode. It is called unsafe for a reason, as it causes the virtual host to ignore all
        # fsync() calls from the guest. Only do this if you are comfortable with the possibility of
        # your development guest becoming corrupted (in which case you should only need to do a
        # vagrant destroy and vagrant up to get a new one).
        #
        # domain.volume_cache = "unsafe"
    end
  end

end
