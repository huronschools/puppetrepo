# /etc/puppet/manifests/classes/mjhsconf.pp

class mjhs_conf {

	file { "/etc/puppet/puppet.conf":
		owner => root,
		group => wheel,
		mode => 644,
		source => "puppet:///files/mjhspuppet.conf",
	}
}
