# /etc/puppet/modules/user/manifests/init.pp

class user {
	case $operatingsystem {
		CentOS: { include user::centos }
		Darwin: { include user::osx }
	}
}