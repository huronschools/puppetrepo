#/etc/puppet/manifests/classes/passwd.pp

class passwd {
	file { "/etc/passwd":
		owner => "root",
		group => "wheel",
		mode => 644,
	}
}
