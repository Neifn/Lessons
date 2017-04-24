Vagrant.configure("2") do |config|
    config.vm.box = "primalskill/ubuntu-trusty64"
    config.vm.network :forwarded_port, guest: 80, host: 8931, host_ip: "127.0.0.1", auto_correct: true
    config.vm.synced_folder "./", "/var/www", create: true, group: "www-data", owner: "www-data"
    config.vm.provider "virtualbox" do |v|
        v.name = "SitePoint Test Vagrant"
        v.customize ["modifyvm", :id, "--memory", "1024"]
    end
    config.vm.provision "shell" do |s|
        s.path = "provision\\setup.sh"
    end

end