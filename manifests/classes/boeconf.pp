# /etc/puppet/manifests/classes/boeconf.pp

class boe_conf {
	
	include boe_puppetd
	file { "/etc/puppet/puppet.conf":
		owner => root,
		group => wheel,
		mode => 644,
		source => "puppet:///files/boepuppet.conf",
	}
}
