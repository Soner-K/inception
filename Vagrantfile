Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-24.04"
  config.vm.box_version = "202502.21.0"

  config.vm.synced_folder "./srcs", "/home/vagrant/srcs", create: true
  config.vm.hostname = "sokaraku"
  config.vm.provision "shell", path: "main-box-dependencies.sh"

  config.disksize.size = '1GB'

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "512"
  end
end