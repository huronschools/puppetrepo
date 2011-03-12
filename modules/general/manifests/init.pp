# /etc/puppet/modules/general/manifests/init.pp

class general {

	case $operatingsystem {
		CentOS: { include general::centos }
		Darwin: { include general::osx }
	}

}
