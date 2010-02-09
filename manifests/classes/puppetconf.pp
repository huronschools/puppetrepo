# /etc/puppet/manifests/classes/puppetconf.pp

class puppet_conf {

	file { "/etc/puppet/puppet.conf":
		owner => root,
		group => wheel,
		mode => 644,
		source => "puppet:///files/puppet.conf",
	}
}
