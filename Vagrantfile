Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-24.04"
  config.vm.box_version = "202502.21.0"

#   config.vm.synced_folder "./", "/home/sokaraku", create: true
  config.vm.hostname = "sokaraku"
  config.vm.provision "shell", path: "main-box-dependencies.sh"
  config.vm.network "forwarded_port", guest: 443, host: 8443
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "512"
  end
end