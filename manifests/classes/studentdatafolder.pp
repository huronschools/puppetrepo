# /etc/puppet/manifests/classes/studentdatafolder.pp
#
# Creates a Student Data Folder that is World RWX
class studentdata {
	file { "/Student Data Folder":
		ensure => directory,
		owner => "admin",
		group => "staff",
		mode => 777,
		alias => "sdfolder",
	}
}
