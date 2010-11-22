# /etc/puppet/manifests/classes/mcollective.pp

class mcollective {

	$mcollective = "mcollective-0.4.10.dmg"

	package { "$mcollective":
		source		=> "$pkg_base/$mcollective",
		before		=> [File["/etc/mcollective/server.cfg"], File["/etc/mcollective/client.cfg"]],
	}

	file { "/etc/mcollective/server.cfg":
		ensure 		=> file,
		content		=> template("mc-server.erb"),
		owner		=> "root",
		group  		=> "wheel",
		mode		=> 0600,
	}
	
	file { "/etc/mcollective/client.cfg":
		ensure 		=> file,
		content		=> template("mc-client.erb"),
		owner		=> "root",
		group  		=> "wheel",
		mode		=> 0600,
	}
	
	file { "/Library/LaunchDaemons/com.huronhs.mcollective.plist":
		ensure 		=> file,
		source		=> "puppet:///files/com.huronhs.mcollective.plist",
		mode		=> 0644,
		owner		=> "root",
		group  		=> "wheel",
		require		=> [Package["$mcollective"], File["/etc/mcollective/server.cfg"]],
	}
	
	service { "com.huronhs.mcollective":
		enable		=> true,
		ensure		=> running,
		subscribe	=> File["/Library/LaunchDaemons/com.huronhs.mcollective.plist"],
		require		=> File["/Library/LaunchDaemons/com.huronhs.mcollective.plist"],
	}
	
	file { "/usr/libexec/mcollective/facts/facter.rb":
		ensure 		=> file,
		source		=> "puppet:///files/facter-plugin.rb",
		before		=> File["/Library/LaunchDaemons/com.huronhs.mcollective.plist"],
	}
	
	package { "stomp":
		ensure		=> installed,
		provider	=> gem,
		before		=> File["/Library/LaunchDaemons/com.huronhs.mcollective.plist"],
	}
}