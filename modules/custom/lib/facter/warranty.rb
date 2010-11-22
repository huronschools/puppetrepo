require 'facter'

if Facter.value('kernel') == 'Darwin'
  #  First grab the serial number. For some reason I can't get it from Facter
  sn  = %x{ioreg  -l | grep IOPlatformSerialNumber | sed -e s/\\"//g}.chomp.split{"="}[-1].chomp
  url = "https://selfsolve.apple.com/Warranty.do?serialNumber=#{sn}&country=USA&fullCountryName=United%20States"

  #  Next fetch warranty information from Apple, convert the resulting json to a hash
  warranty_info = eval %x{curl -k -s "#{url}"}.split(',').each { |element|
    element.sub! ':', ' => '
  }.join(',') 
end

#  Set the Purchase Date by searching through the Array
Facter.add("purchase_date") do
  confine :kernel => "Darwin"
  setcode do
    warranty_info['PURCHASE_DATE']
  end 
end

#  First we need to check and see if the machine is out of warranty.  If it is,
#  return the purchase date.  If it isn't out of warranty, return the Coverage Date
Facter.add("warranty_out") do
  confine :kernel => "Darwin"
  setcode do
    warranty_info['COVERAGE_DESC'] == 'Out of Warranty' ? 'yes' : 'no'
  end 
end


Facter.add("warranty_end") do
  confine :kernel => "Darwin"
  setcode do
    warranty_info['COVERAGE_DATE']
  end 
end