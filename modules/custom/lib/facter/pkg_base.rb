require 'facter'
require 'puppet'

$ip = Facter.value(:ipaddress).split('.')[2]

Facter.add("pkg_base") do
	if $ip == "0"
		setcode do
		  $location = "SHEL"
			$pkg_base = "http://testing.huronhs.com/pkgs/general_image"
		end
	elsif $ip == "1"
		setcode do
      $location = "HHS"
			$pkg_base = "http://helpdesk.huronhs.com/pkgs"
		end
	elsif $ip == "5"
		setcode do
      $location = "HHS"
			$pkg_base = "http://helpdesk.huronhs.com/pkgs"
		end
	elsif $ip == "2"
		setcode do
      $location = "MJHS"
			$pkg_base = "http://mspuppet.huronhs.com/pkgs"
		end
	elsif $ip == "3"
		setcode do
      $location = "WIS"
			$pkg_base = "http://wesreplica.huronhs.com/pkgs"
		end
	else
		setcode do
      $location = "UNKNOWN"
			$pkg_base = "http://testing.huronhs.com/pkgs/general_image"
		end
  end
end

Facter.add("location") do
  setcode do
    $location
  end
end
