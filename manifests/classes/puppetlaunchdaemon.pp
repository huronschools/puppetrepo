# /etc/puppet/manifests/classes/puppetlaunchdaemon.pp

class puppet_LaunchDaemon {

	file { "/Library/LaunchDaemons/com.huronhs.puppetconfig.plist":
		owner => root,
		group => wheel,
		mode => 644,
		source => "puppet:///files/com.huronhs.puppetconfig.plist",
		provider => launchd
		ensure => running,
	}
}
