###############################################################
# ========================Pre-requisite ======================#
# Install Vagrant, Virtualbox, Set executables dir's in PATH
# Install vagrant plugins
# vagrant plugin install vagrant-vbguest
# vagrant plugin install vagrant-disksize
# Initiualize box
# vagrant init ubuntu/xenial64
# vagrant vbguest
###############################################################

script_path = '../scripts'

##### *** START *** configuration #####
Vagrant.configure("2") do |config|
  
  # $$$$$ *** START *** Linux-Ubuntu distro node $$$$$
  config.vm.define "ubuntuLinux" do |ubuntu|
    ubuntu.vm.box = "ubuntu/xenial64"
    ubuntu.vm.box_version="20190320.0.0"
    ubuntu.disksize.size = '20GB'
    ubuntu.vm.hostname = "ulinux"
    ubuntu.vm.network "private_network", ip: "192.168.19.101"
    #ubuntu.vm.network "public_network"
    #ubuntu.vm.network "forwarded_port", guest: 9483, host: 19483
    #ubuntu.vm.network "forwarded_port", guest: 7600, host: 17600
    #ubuntu.vm.network "forwarded_port", guest: 7800, host: 17800
    #ubuntu.vm.network "forwarded_port", guest: 7483, host: 17483
    #ubuntu.vm.synced_folder "D:/shared/softwares", "/shared_data"
    
    # ===== START ===== Set VM resources
    ubuntu.vm.provider "virtualbox" do |vb|
      vb.memory = "4068"
      vb.name = "ulinux.inthub.local"
      vb.cpus = 2
    end
    # ===== END ===== Set VM resources
    
    ### *** START *** Provision ###
    config.vm.provision "shell" do |script|
      #script.path = "#{script_path}/setup_docker.sh"
      #script.args = %w(docker_version_17.03)
      apt-get install -y figlet
      figlet "My Virtual Machine - "$HOSTNAME
    end
    ### *** END *** Provision ###
    
  end
  # $$$$$ END *** Linux-Ubuntu distro node $$$$$
  
end
##### *** END *** configuration #####
