# /etc/puppet/manifests/classes/boepuppetd.pp

class boe_puppetd {

	file { "/usr/bin/puppetd.sh":
		owner => root,
		group => wheel,
		mode => 755,
		source => "puppet:///files/boepuppetd.sh",
	}
}
