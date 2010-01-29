#/etc/puppet/manifests/users/virt_users.pp

class virt_users {
	@user { "padmin":
		ensure => "present",
		gid => "80",
		shell => "/bin/bash",
	}
}
