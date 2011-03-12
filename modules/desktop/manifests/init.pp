# /etc/puppet/modules/desktop/manifests/init.pp

class desktop {

	case $operatingsystem {
		CentOS: { include desktop::centos }
		Darwin: { include desktop::osx }
	}

}
