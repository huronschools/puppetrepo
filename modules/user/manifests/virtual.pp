# /etc/puppet/modules/user/manifests/virtual.pp

class user::virtual {

	@user {"student":
		ensure		=> present,
		groups		=> ["localusers"],
		comment		=> "Students User",
		uid			=> '551',
		gid			=> "localusers",
		home		=> "/home/student",
		managehome	=> "true",
		password 	=> "kjxzozJWzbfRI",
		membership	=> minimum,
		shell		=> "/bin/bash",
		require		=> Group["localusers"],
	}
	
	@user {"management":
		ensure		=> present,
		groups		=> ["admins"],
		comment		=> "Computer Management",
		uid			=> '550',
		gid			=> "admins",
		password	=> "saIv9a6pw5vg2",
		home		=> "/home/management",
		managehome	=> "true",
		membership	=> "minimum",
		shell		=> "/bin/bash",
		require		=> Group["admins"],
	}

	group {"localusers":
		ensure		=> present,
		gid			=> 1000,
	}
	
	group{"admins":
		ensure		=> present,
		gid			=> 1001,
	}
}