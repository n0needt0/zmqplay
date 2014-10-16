Vagrant.configure("2") do |config|
    
    config.vm.define "zmqbox" do |zmqbox|
        zmqbox.vm.box = "precise64"
        zmqbox.vm.box_url = "http://files.vagrantup.com/precise64.box"
        zmqbox.vm.provision :shell, :path => "bootstrap.sh"
        #zmqbox.vm.network :private_network, ip: "10.10.10.11"
        zmqbox.vm.hostname = "zmqbox"
        zmqbox.vm.network "forwarded_port", guest: 5555, host: 5555

        zmqbox.vm.provider :virtualbox do |vb|
            vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
            vb.customize ["modifyvm", :id, "--memory", "1024"]
        end
    end
end