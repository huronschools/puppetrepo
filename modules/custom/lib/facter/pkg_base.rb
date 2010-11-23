require 'facter'
require 'puppet'

$ip = Facter.value(:ipaddress).split('.')[2]

Facter.add("pkg_base") do
	if $ip == "0"
		$location = "SHEL"
		setcode do
			$pkg_base = "http://testing.huronhs.com/pkgs/general_image"
		end
	elsif $ip == "1"
	  $location = "HHS"
	  setcode do
			$pkg_base = "http://helpdesk.huronhs.com/pkgs"
		end
	elsif $ip == "5"
    $location = "HHS"
    setcode do
			$pkg_base = "http://helpdesk.huronhs.com/pkgs"
		end
	elsif $ip == "2"
    $location = "MJHS"
    setcode do
			$pkg_base = "http://mspuppet.huronhs.com/pkgs"
		end
	elsif $ip == "3"
    $location = "WIS"
    setcode do
			$pkg_base = "http://wesreplica.huronhs.com/pkgs"
		end
	else
    $location = "UNKNOWN"
    setcode do
			$pkg_base = "http://testing.huronhs.com/pkgs/general_image"
		end
  end
end

Facter.add("location") do
  setcode do
    $location
  end
end
