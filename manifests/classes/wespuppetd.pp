# /etc/puppet/manifests/classes/wespuppetd.pp

class wes_puppetd {

	file { "/usr/bin/puppetd.sh":
		owner => root,
		group => wheel,
		mode => 755,
		source => "puppet:///files/wespuppetd.sh",
	}
}
