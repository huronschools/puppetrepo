#/etc/puppet/manifests/classes/hhsfb.pp

class hhsfb {

	#  Include the studentdata class which creates our Student Data Folder
	include studentdata
	
	#  Install Remote Management Unit
	include ardalllocal

	#  Install HHS General Images
	include hhs_general_image

	#  Install Final Cut Pro
	pkg_deploy_hhs {"FinalCut.dmg": 
		alias => FinalCut,
	}

} # End of Class
