# /etc/puppet/manifests/classes/mcollective.pp

class mcollective {

	include mcplugins

	$mcollective = "mcollective-0.4.10.dmg"
	$stomp = "Stomp_Install-20101216.dmg"
	
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
	
	case $macosx_productversion_major {			
		10.6: { 
			package { "stomp":
				ensure		=> installed,
				provider	=> gem,
				before		=> File["/Library/LaunchDaemons/com.huronhs.mcollective.plist"],
			}
	    }
		
		10.5: {
			package {"$stomp":
				ensure		=> installed,
				provider	=> pkgdmg,
				source		=> "$pkg_base/$stomp",
			}
			
		}
	}
	
	
	file { "/etc/mcollective/facts.yaml":
		ensure 		=> file,
#	    content 	=> inline_template("<%= scope.to_hash.to_yaml.to_s %>"),
		content		=> inline_template("<%= facts = {}; scope.to_hash.each_pair {|k,v| facts[k.to_s] = v.to_s}; facts.to_yaml %>"),
		before		=> Service["com.huronhs.mcollective"],
		require		=> Package["$mcollective"],
		notify		=> Service["com.huronhs.mcollective"],
	}
}