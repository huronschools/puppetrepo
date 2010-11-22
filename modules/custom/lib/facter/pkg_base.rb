require 'facter'
require 'puppet'

$ip = Facter.value(:ipaddress).split('.')[2]

Facter.add("pkg_base") do
	if $ip == "0"
		setcode do
			$pkg_base = "http://testing.huronhs.com/pkgs/general_image"
			$location = "SHEL"
		end
	elsif $ip == "1"
		setcode do
			$pkg_base = "http://helpdesk.huronhs.com/pkgs"
			$location = "HHS"
		end
	elsif $ip == "5"
		setcode do
			$pkg_base = "http://helpdesk.huronhs.com/pkgs"
			$location = "HHS"
		end
	elsif $ip == "2"
		setcode do
			$pkg_base = "http://mspuppet.huronhs.com/pkgs"
			$location = "MJHS"
		end
	elsif $ip == "3"
		setcode do
			$pkg_base = "http://wesreplica.huronhs.com/pkgs"
			$location = "WIS"
		end
	else
		setcode do
			$pkg_base = "http://testing.huronhs.com/pkgs/general_image"
			$location = "UNKNOWN"
		end
  end
end

Facter.add("location") do
  setcode do
    $location
  end
end
