# /etc/puppet/modules/puppet_conf/manifests/init.pp

class puppet_conf {

	file { "/etc/puppet/puppet.conf":
		owner => root,
		group => wheel,
		mode => 644,
		source => "puppet:///puppet_conf/puppet.conf",
	}
}
