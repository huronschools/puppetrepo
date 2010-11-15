# /etc/puppet/manifests/site.pp

#import "modules"
import "classes/*"
import "nodes"
import "users/*"
import "classes/printers/*"

# Set global defaults - paths
Exec {path => "/usr/bin:/usr/sbin:/bin:/sbin"}
Package {ensure => installed, provider => pkgdmg}	
User { provider => "directoryservice" }