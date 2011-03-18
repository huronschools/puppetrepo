# /etc/puppet/modules/general/manifests/osx.pp

class general::osx {

	Package { ensure => installed, provider => pkgdmg }	
	User { provider => "directoryservice" }

	include mcollective_module
	include desktop
	include user
	
	$facter = "facter-1.5.8.dmg"
	$puppetcurrent = "puppet-2.6.4.dmg"
	
	package{"$facter": 
		source 	=> "$pkg_base/$facter",
		before	=> Package["$puppetcurrent"],
	}
	package{"$puppetcurrent":
		source 	=> "$pkg_base/$puppetcurrent",
	}
	file { "/var/lib/": 
		ensure 		=> directory,
	}
	
	file { "/etc/puppet/template.txt":
		ensure	 	=> file,
		content		=> template("sample.erb"),
	}
	
	file { "/etc/puppet/puppet.conf":
		ensure		=> file,
		content		=> template("puppetconf.erb"),
		require 	=> File["/usr/bin/puppetd.rb"],
	}
	
	file { "/usr/bin/puppetd.rb":
		owner		=> root,
		group 		=> wheel,
		mode 		=> 755,
		source	 	=> "puppet:///modules/general/puppetd.rb",
	}
	
	file { "/Library/LaunchDaemons/com.huronhs.puppetconfig.plist":
		owner		=> 	root,
		group 		=> 	wheel,
		mode 		=> 	644,
		source 		=> 	"puppet:///files/com.huronhs.puppetconfig.plist",
		ensure 		=> 	present,
	}

	service { "com.huronhs.puppetconfig":
		enable 		=> 	true,
		ensure 		=> 	running,
		subscribe 	=> 	File["/Library/LaunchDaemons/com.huronhs.puppetconfig.plist"],
		require 	=> 	File["/Library/LaunchDaemons/com.huronhs.puppetconfig.plist"],
	}

}
