# /etc/puppet/manifests/site.pp

#import "modules"
import "classes/*"
import "nodes"
import "users/*"
import "classes/printers/*"

# Set global defaults - paths
Exec {path => "/usr/bin:/usr/sbin:/bin:/sbin"}

case $operatingsystem {
	Darwin: { Package {ensure => installed, provider => pkgdmg} }			
	Centos: { 
		Package {ensure => installed, provider => yum} 
		stage {"pre": before => Stage["main"]}
		class {"general::repos": stage => pre }
	}
}