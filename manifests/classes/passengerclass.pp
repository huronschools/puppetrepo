class passengerclass {

	file { ["/etc/puppet/rack", "/etc/puppet/rack/public"]:
	  ensure => directory,
	  mode => 0755,
	  owner => "puppet",
	  group => "puppet",
	}

	file { "/etc/puppet/rack/config.ru":
	  ensure => present,
	  source => "puppet:///files/config.ru",
	  mode => 0644,
	  owner => "puppet",
	  group => "puppet",
	}

	file { "/etc/apache2/httpd.conf":
	  ensure => present,
	  source => "puppet:///files/httpd.passenger.conf",
	  mode => 0644,
	  owner => "root",
	  group => "wheel",
	  before => File["/etc/apache2/passenger.conf"],
	  notify => Service["apache2"],
	}

	file { "/etc/apache2/passenger.conf":
	  ensure => present,
	  source => "puppet:///files/passenger.conf",
	  mode => 0644,
	  owner => "root",
	  group => "wheel",
	  require => [File["/etc/puppet/rack/config.ru"], File["/etc/puppet/rack/public"], Package[$passenger::passenger]],
	  notify => Service["apache2"],
	}

#	package { 'passenger':
#	  ensure => '2.2.14',
#	  name => 'passenger',
#	  provider => "gem",
#	}

	service { "apache2":
		enable => true,
		ensure => true,
		hasrestart => true,
	}

#	exec { "/usr/bin/passenger-install-apache2-module --auto":
#	      subscribe => Package["passenger"],
#	      before => Service["apache2"],
#	      require => [Package["passenger"], File["/etc/apache2/httpd.conf"]],
#	}

} #End of Class
