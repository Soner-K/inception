Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-24.04"
  config.vm.box_version = "202502.21.0"

#   config.vm.synced_folder "./", "/home/sokaraku", create: true
  config.vm.hostname = "sokaraku"
  config.vm.provision "shell", path: "main-box-dependencies.sh"
  
  # Add user to sudo group and configure passwordless sudo
  config.vm.provision "shell", inline: <<-SHELL
    # Add vagrant user to sudo group if not already added
    if ! groups vagrant | grep -q sudo; then
      usermod -aG sudo vagrant
      echo "Added vagrant user to sudo group"
    fi
    
    # Configure sudo without password for convenience
    echo "vagrant ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/vagrant
    chmod 0440 /etc/sudoers.d/vagrant
  SHELL
  
  config.vm.network "forwarded_port", guest: 443, host: 8443
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "512"
  end
end