# /etc/puppet/modules/user/manifests/virtual.pp

class user::virtual {

	@user {"students":
		ensure		=> present,
		groups		=> ["localusers"],
		comment		=> "Students User",
		uid			=> '551',
		gid			=> "localusers",
		home		=> "/home/students",
		managehome	=> "true",
		password 	=> "kjxzozJWzbfRI",
		membership	=> minimum,
		shell		=> "/bin/bash",
		require		=> Group["localusers"],
	}
	
	@user {"management":
		ensure		=> present,
		groups		=> ["admin"],
		comment		=> "Computer Management",
		uid			=> '550',
		gid			=> "admin",
		password	=> "saIv9a6pw5vg2",
		home		=> "/home/management",
		managehome	=> "true",
		membership	=> "minimum",
		shell		=> "/bin/bash",
		require		=> Group["admin"],
	}

	group {"localusers":
		ensure		=> present,
		gid			=> 1000,
	}
	
	group{"admin":
		ensure		=> present,
		gid			=> 1001,
	}
}