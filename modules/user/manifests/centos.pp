# /etc/puppet/modules/user/manifests/virtual.pp

class user::centos inherits user::virtual {

	case $operatingsystem {
		CentOS: { realize( User["students"], User["management"]) }
	}

}