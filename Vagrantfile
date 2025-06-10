Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-24.04"
  config.vm.box_version = "202502.21.0"

  # Modified synced folder with improved permissions
  config.vm.synced_folder "./", "/home/sokaraku", 
    create: true,
    owner: "vagrant",
    group: "docker",
    mount_options: ["dmode=775,fmode=664"]
  
  config.vm.hostname = "sokaraku"
  
  # Add provisioning for data directories before other provisioning
  config.vm.provision "shell", inline: <<-SHELL
    # Create data directories
    mkdir -p /home/sokaraku/data/mariadb /home/sokaraku/data/wordpress
    
    # Set permissions that work for Docker volumes
    chown -R 999:999 /home/sokaraku/data/mariadb
    chmod -R 770 /home/sokaraku/data/mariadb
    
    chown -R 33:33 /home/sokaraku/data/wordpress
    chmod -R 770 /home/sokaraku/data/wordpress
    
    # Add vagrant user to docker group
    usermod -aG docker vagrant
  SHELL
  
  # Main provisioning
  config.vm.provision "shell", path: "main-box-dependencies.sh"
  
  config.vm.network "forwarded_port", guest: 443, host: 8443
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "512"
  end
end

# Vagrant.configure("2") do |config|
#   config.vm.box = "bento/ubuntu-24.04"
#   config.vm.box_version = "202502.21.0"

#   config.vm.synced_folder "./", "/home/sokaraku", create: true
#   config.vm.hostname = "sokaraku"
#   config.vm.provision "shell", path: "main-box-dependencies.sh"
#   config.vm.network "forwarded_port", guest: 443, host: 8443
#   config.vm.provider "virtualbox" do |vb|
#     vb.memory = "512"
#   end
# end