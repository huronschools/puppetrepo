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
	  notify => Service["org.apache.httpd"],
	}

	file { "/etc/apache2/passenger.conf":
	  ensure => present,
	  source => "puppet:///files/passenger.conf",
	  mode => 0644,
	  owner => "root",
	  group => "wheel",
	  require => [File["/etc/puppet/rack/config.ru"], File["/etc/puppet/rack/public"], Class["passenger"]],
	  notify => Service["org.apache.httpd"],
	}

	service { "org.apache.httpd":
		enable => true,
		ensure => true,
		subscribe => [File["/etc/apache2/passenger.conf"], File["/etc/apache2/httpd.conf"]],
		require => [File["/etc/apache2/passenger.conf"], File["/etc/apache2/httpd.conf"]],
	}


} #End of Class
