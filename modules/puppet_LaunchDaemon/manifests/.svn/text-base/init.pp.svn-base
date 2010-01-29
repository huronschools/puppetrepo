# /etc/puppet/modules/puppet_LaunchDaemons/manifests/init.pp

class puppet_LaunchDaemon {

	file { "/Library/LaunchDaemons/com.huronhs.puppetconfig.plist":
		owner => root,
		group => wheel,
		mode => 644,
		source => "puppet:///puppet_LaunchDaemon/com.huronhs.puppetconfig.plist",
	}
}
