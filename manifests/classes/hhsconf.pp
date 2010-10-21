# /etc/puppet/manifests/classes/hhsconf.pp

class hhs_conf {
	
	include hhs_puppetd
	file { "/etc/puppet/puppet.conf":
		owner => root,
		group => wheel,
		mode => 644,
		source => "puppet:///files/hhspuppet.conf",
	}
}
