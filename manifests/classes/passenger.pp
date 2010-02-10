class passenger {

file { ["/etc/puppet/rack", "/etc/puppet/rack/public"]:
  ensure => directory,
  mode => 0755,
  owner => puppet,
  group => puppet,
}

file { "/etc/puppet/rack/config.ru":
  ensure => present,
  source => "puppet:///files/config.ru",
  mode => 0644,
  owner => puppet,
  group => root,
}

file { "/etc/apache2/httpd.conf":
  ensure => present,
  source => "puppet:///files/httpd.passenger.conf",
  mode => 0644,
  owner => root,
  group => root,
  before => File["/etc/apache2/passenger.conf"],
  notify => Service["apache2"],
}

file { "/etc/apache2/passenger.conf":
  ensure => present,
  source => "puppet:///files/passenger.conf",
  mode => 0644,
  owner => root,
  group => root,
  require => [File["/etc/puppet/rack/config.ru"], File["/etc/puppet/rack/public"], Package["apache2"], Package["passenger"]],
  notify => Service["apache2"],
}

package { ["rack", "passenger"]:
  ensure => installed,
  provider => "gem",
}

service { "apache2":
}

exec { "/usr/bin/passenger-install-apache2-module --auto":
      subscribe => Package["passenger"],
      before => Service["apache2"],
      require => Package["passenger"],
      require => File["/etc/apache2/httpd.conf"],
}

} #End of Class
