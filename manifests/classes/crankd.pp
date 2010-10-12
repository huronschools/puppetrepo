# /etc/puppet/manifests/classes/crankd.pp

class crankd {
	
	file { "/Library/HuronHS/Python2.5": 
		recurse => true,
		source => "puppet:///files/crankd/HuronHS/",
		mode => 0755,
	}
	
	file { "/Library/Application Support/crankd": 
		recurse => true,
		source => "puppet:///files/crankd/Application Support/",
		mode => 0755,
	}

	file { "/Library/Preferences/com.huronhs.crankd.plist":
		ensure => present,
		source => "puppet:///files/crankd/crankd-config.plist",
		mode => 0644,
		owner => root,
		group => wheel,
	}
	
	file { "/usr/local/sbin/crankd.py":
		ensure => present,
		source => "puppet:///files/crankd/crankd.py",
		mode => 0755,
		owner => root,
		group => wheel,
		before => File["/Library/Preferences/com.huronhs.crankd.plist"],
		require => [File["/Library/Application Support/crankd"], File["/Library/HuronHS/Python2.5"]],
	}
	
	file { "/Library/LaunchDaemons/com.huronhs.crankd.plist":
		ensure => present,
		source => "puppet:///files/crankd/com.huronhs.crankd.plist",
		mode => 0644,
		owner => root,
		group => wheel,
		require => File["/Library/Preferences/com.huronhs.crankd.plist"],
	}
	
	service { "com.huronhs.crankd.plist":
		enable => true,
		ensure => running,
		subscribe => File["/Library/LaunchDaemons/com.huronhs.crankd.plist"],
		require => File["/Library/LaunchDaemons/com.huronhs.crankd.plist"],
	}
}