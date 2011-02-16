# /etc/puppet/manifests/classes/puppetconfig.pp

class puppet_config {
	
	# Includes
	include puppet_LaunchDaemon
	
	# Ensure Vardir for .25.4 -> .25.5 clients
	file { "/var/lib/": 
		ensure 	=> directory,
	}
	
	# Templating Example
	file { "/etc/puppet/template.txt":
		ensure 	=> file,
		content => template("sample.erb"),
	}
	
	# Set the puppet.conf file
	file { "/etc/puppet/puppet.conf":
		ensure	=> file,
		content	=> template("puppetconf.erb"),
		require => File["/usr/bin/puppetd.rb"],
	}
	
	# Set the puppet wrapper script
	file { "/usr/bin/puppetd.rb":
		owner	=> root,
		group 	=> wheel,
		mode 	=> 755,
		source 	=> "puppet:///files/puppetd.rb",
	}
}
