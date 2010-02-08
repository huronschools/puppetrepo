# /etc/puppet/manifests/classes/desktopbackground.pp
# 
#  Removes com.apple.desktop.plist and resets background for the Students account
#

class desktopbackground {

	file { "/users/students/library/preferences/com.apple.desktop.plist": ensure => absent}

} # End of Class
