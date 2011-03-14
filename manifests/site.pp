# /etc/puppet/manifests/site.pp

#import "modules"
import "classes/*"
import "nodes"
import "users/*"
import "classes/printers/*"

# Set global defaults - paths
Exec {path => "/usr/bin:/usr/sbin:/bin:/sbin"}

# Run Stages
stage {"pre": before => Stage["main"]}
class {"general::repos": stage => pre }

case $operatingsystem {
	Darwin: { Package {ensure => installed, provider => pkgdmg} }			
	Centos: { Package {ensure => installed, provider => yum} }
}