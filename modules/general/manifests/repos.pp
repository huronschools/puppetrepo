# /etc/puppet/modules/general/manifests/repos.pp

class general::repos {

	case $operatingsystem {
		CentOS: { 
			yumrepo {"local-centos-os":
					descr		=> "Local Centos Base Repo",
					enabled		=> 1,
					gpgcheck	=> 0,
					baseurl		=> "http://10.13.0.6/centos/$lsbmajdistrelease/os/$architecture/",
			}
	
			yumrepo {"huronrepo":
					descr		=> "Huron Repository",
					enabled		=> 1,
					gpgcheck	=> 0,
					baseurl		=> "http://10.13.0.6/huronrepo",
			}
	
			yumrepo {"local-centos-updates":
					descr		=> "Local Centos Updates Repo",
					enabled		=> 1,
					gpgcheck	=> 0,
					baseurl		=> "http://10.13.0.6/centos/$lsbmajdistrelease/updates/$architecture/",
			}
		}
	}
}