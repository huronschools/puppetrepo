# /etc/puppet/modules/user/manifests/virtual.pp

class user::centos inherits user::virtual {

	realize( User["students"], User["management"])

}