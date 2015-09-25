Vagrant.configure('2') do |config|
  config.vm.define :testpuppet do |node|

    node.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210-nocm.box'
    node.vm.box = 'ubuntu-1204-x64-vbox4210-nocm'

    # Install default ruby for Ubuntu
    node.vm.provision :shell, :inline => 'command -v ruby >/dev/null 2>&1 || { apt-get update && apt-get install -y ruby; }'

    node.vm.hostname = 'puppet.test.vm'

    node.vm.synced_folder './src/puppetlabs', '/puppetlabs'
    node.vm.synced_folder './src/modules', '/modules'

    # Write a fragment to /etc/profile.d that activates envpuppet
    node.vm.provision :shell, :inline => <<-EOS
tee /etc/profile.d/envpuppet.sh << "EOF"
export ENVPUPPET_BASEDIR=/puppetlabs
eval $($ENVPUPPET_BASEDIR/puppet/ext/envpuppet)
EOF
    EOS

    # The puppet user and group are required to run Puppet 2.7.0 -- 3.1.0.
    node.vm.provision :shell, :inline => <<-EOS
puppet resource group puppet ensure=present
puppet resource user puppet ensure=present gid=puppet
    EOS

  end

end
