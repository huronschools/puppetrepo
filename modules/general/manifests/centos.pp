# /etc/puppet/modules/general/manifests/centos.pp

class general::centos {

	include mcollective_module
	include general::repos
	include user
	
	$minute = generate('/usr/bin/env', 'sh', '-c', 'printf $((RANDOM%60+0))')
	
	cron { "puppet":
		ensure		=> present,
		command		=> "/usr/bin/puppetd.rb",
		user 		=> "root",
		hour 		=> "*",
		minute 		=> $minute,
	}
	
	file { "/etc/puppet/puppet.conf":
		ensure		=> file,
		content		=> template("puppetconf.erb"),
		require 	=> File["/usr/bin/puppetd.rb"],
	}
	
	file { "/etc/rc.d/rc.local":
		ensure 		=> file,
		source		=> "puppet:///general/rc.local",
		owner		=> "root",
		group 		=> "root",
		mode 		=> 755,
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
	
	file { "/etc/cups/cupsd.conf":
		ensure 		=> file,
		owner		=> "root",
		group 		=> "lp",
		mode 		=> 640,
		source 		=> "puppet:///modules/general/cupsd.conf",
		notify		=> Service["cups"],
	}
	
	service {"cups":
		ensure		=> running,
		subscribe	=> File["/etc/cups/cupsd.conf"],
	}
}
