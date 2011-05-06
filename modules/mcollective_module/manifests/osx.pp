# /etc/puppet/manifests/modules/mcollective_module/osx.pp

class mcollective_module::osx {

	Package {ensure => installed, provider => pkgdmg}

	include mcollective_module::plugins
	require mcollective_module::params
	
	$mcollective 	= "MCollective_Installer_Full-1.1.1Revb.dmg"
	$stomp 			= "Stomp_Install-20101216.dmg"

	package { "${mcollective_module::params::packagename}":
		source		=> "$pkg_base/$mcollective",
		before		=> [File["/etc/mcollective/server.cfg"], File["/etc/mcollective/client.cfg"]],
	}
	file { "/Library/LaunchDaemons/com.huronhs.mcollective.plist":
		ensure 		=> file,
		source		=> "puppet:///files/com.huronhs.mcollective.plist",
		mode		=> 0644,
		owner		=> "root",
		group  		=> "wheel",
		require		=> [Package["$mcollective"], File["/etc/mcollective/server.cfg"]],
	}
	service { "${mcollective_module::params::servicename}":
		enable		=> true,
		ensure		=> running,
		subscribe	=> File["/Library/LaunchDaemons/com.huronhs.mcollective.plist"],
		require		=> File["/Library/LaunchDaemons/com.huronhs.mcollective.plist"],
	}
	file { "/etc/mcollective/facts.yaml":
		ensure 		=> file,
		content		=> inline_template("<%= facts = {}; scope.to_hash.each_pair {|k,v| facts[k.to_s] = v.to_s}; facts.to_yaml %>"),
		before		=> Service["com.huronhs.mcollective"],
		require		=> Package["$mcollective"],
		notify		=> Service["com.huronhs.mcollective"],
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

	file { "/etc/mcollective/server.cfg":
		ensure 		=> file,
		content 	=> template("mcollective_module/server.cfg.erb"),
		owner		=> "root",
		group  		=> "wheel",
		mode		=> 0600,
	}
	
	file { "/etc/mcollective/client.cfg":
		ensure 		=> file,
		content 	=> template("mcollective_module/client.cfg.erb"),
		owner		=> "root",
		group  		=> "wheel",
		mode		=> 0600,
	}
}