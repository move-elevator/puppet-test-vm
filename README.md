# puppet Test-VM

VM to test the [puppet-typo3 module](https://github.com/move-elevator/puppet-typo3) or any other puppet module.
All needed requirements are added as git submodule, so you can easily update/change it. 

## Requirements

* [Git](https://git-scm.com/)
* [Virtual-Box](https://www.virtualbox.org/)
* [Vagrant](https://www.vagrantup.com/)

## Install

<pre>
$ git clone https://github.com/move-elevator/puppet-test-vm.git
$ cd puppet-test-vm
$ git submodule update --init --recursive
$ vagrant up
</pre>

## Usage

<pre>
$ vagrant ssh
$ sudo su
$ /vagrant/bin/envpuppet puppet apply /vagrant/manifests/default.pp --modulepath=/modules --debug --verbose
</pre>

## Switch an relevant version (puppet, facter or hiera)

If you want to check your module with different versions (for example puppet version) do the following steps:

<pre>
$ cd src/puppetlabs/puppet
$ git checkout 3.8.3
</pre>

After this, you can use puppet version 3.8.3 in the VM. 
<pre>
$ vagrant ssh
$ puppet --version
</pre>

A change for hiera or facter version are equivalent to the example above.

## Add a module

If you want to add a further module just copy, clone or move the module directory to [here](src/modules).

## Links

* https://puppetlabs.com/blog/use-envpuppet-test-multiple-puppet-versions
* https://github.com/puppetlabs/puppet/blob/master/ext/envpuppet

