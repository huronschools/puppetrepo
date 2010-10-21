# /etc/puppet/manifests/classes/ard_all_local.pp
#
#  Installs a custom ARD Installer that enables all local users
##    as well as the "admin" user.

class ardalllocal {
	pkg_deploy {"ardalllocal.dmg": alias => ardalllocal}
	
} # End of class
