# /etc/puppet/manifests/classes/wesconf.pp

class wes_conf {

	file { "/etc/puppet/puppet.conf":
		owner => root,
		group => wheel,
		mode => 644,
		source => "puppet:///files/wespuppet.conf",
	}
}
