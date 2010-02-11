class studentuser {

User { provider => "directoryservice" }

user { "Students":
	ensure => present,
	uid => 502,
	password => "tigers",
	shell => "/bin/bash";
	}

} # End of Class
