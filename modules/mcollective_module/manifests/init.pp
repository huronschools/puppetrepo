class mcollective_module {

	case $operatingsystem {
		Darwin: { include mcollective_module::osx }			
		Centos: { include mcollective_module::centos }
	}

}