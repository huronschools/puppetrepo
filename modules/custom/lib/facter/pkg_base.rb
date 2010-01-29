require 'facter'
require 'puppet'

$ip = Facter.value(:ipaddress).split('.')[2]

Facter.add("pkg_base") do
	if $ip == "0"
		setcode do
			$pkg_base = "http://testing.huronhs.com/pkgs/general_image"
		end
	elsif $ip == "1"
		setcode do
			$pkg_base = "http://helpdesk.huronhs.com/pkgs"
		end
	elsif $ip == "5"
		setcode do
			$pkg_base = "http://helpdesk.huronhs.com/pkgs"
		end
	elsif $ip == "2"
		setcode do
			$pkg_base = "http://mspuppet.huronhs.com/pkgs"
		end
	elsif $ip == "3"
		setcode do
			$pkg_base = "http://wesreplica.huronhs.com/pkgs"
		end
	else
		setcode do
			$pkg_base = "http://testing.huronhs.com/pkgs/general_image"
		end
end
end
