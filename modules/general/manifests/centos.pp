# /etc/puppet/modules/general/manifests/centos.pp

class general::centos {

	include mcollective_module
	include general::repos
	include user
	
	file { "/etc/puppet/puppet.conf":
		ensure		=> file,
		content		=> template("puppetconf.erb"),
		require 	=> File["/usr/bin/puppetd.rb"],
	}
	
	file { "/usr/bin/puppetd.rb":
		owner 		=> "root",
		group 		=> "root",
		mode 		=> 755,
		source 		=> "puppet:///general/puppetd.rb",
	}
	
	file { "/etc/NetworkManager/dispatcher.d/01-puppetd":
		ensure 		=> file,
		owner 		=> "root",
		group 		=> "root",
		mode		=> 755,
		source 		=> "puppet:///general/01-puppetd",
	}
}
