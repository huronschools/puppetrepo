# /etc/puppet/manifests/classes/crankd.pp

class crankd {


        package { 'sqlite3':
    	  ensure   => present,
          provider => 'macports',
          before   => File['/Library/Application Support/crankd'],
	}	
	#  Ensure the required directories
	file { "/Library/HuronHS": 
		ensure => directory,}
	file { "/usr/local/sbin": 
		ensure => directory,
	}
	
	#  Copy down the required Python2.5 folder
	file { "/Library/HuronHS/Python2.5": 
		recurse => true,
		source 	=> "puppet:///files/crankd/HuronHS/",
		mode	=> 0755,
	}
	
	#  Copy down the crankd folder
	file { "/Library/Application Support/crankd": 
		recurse => true,
		source 	=> "puppet:///files/crankd/Application Support/",
		mode 	=> 0755,
	}

	#  This is the plist that crankd uses for listening to events
	file { "/Library/Preferences/com.huronhs.crankd.plist":
		ensure 	=> present,
		source 	=> "puppet:///files/crankd/crankd-config.plist",
		mode 	=> 0644,
		owner 	=> root,
		group 	=> wheel,
	}
	
	#  This is the crankd.py script itself
	file { "/usr/local/sbin/crankd.py":
		ensure 	=> present,
		source 	=> "puppet:///files/crankd/crankd.py",
		mode 	=> 0755,
		owner 	=> root,
		group 	=> wheel,
		before 	=> File["/Library/Preferences/com.huronhs.crankd.plist"],
		require => [File["/Library/Application Support/crankd"], File["/Library/HuronHS/Python2.5"]],
	}
	
	#  This launchdaemon keeps crankd.py running 
	file { "/Library/LaunchDaemons/com.huronhs.crankd.plist":
		ensure 	=> present,
		source 	=> "puppet:///files/crankd/com.huronhs.crankd.plist",
		mode 	=> 0644,
		owner 	=> root,
		group 	=> wheel,
		require => File["/Library/Preferences/com.huronhs.crankd.plist"],
	}
	
	#  We setup a service for the launchd plist file we created above and ensure that it's running
	service { "com.huronhs.crankd.plist":
		enable 		=> true,
		ensure 		=> running,
		subscribe 	=> File["/Library/LaunchDaemons/com.huronhs.crankd.plist"],
		require 	=> File["/Library/LaunchDaemons/com.huronhs.crankd.plist"],
	}
}
