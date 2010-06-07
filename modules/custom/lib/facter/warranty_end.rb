#
#  This script captures the Applecare Coverage End Date of an Apple Computer
#
#

require 'facter'


#  First grab the serial number with the system_profiler command (note that this runs on the boot volume).
sn = %x{system_profiler SPHardwareDataType | awk '/Serial/ {print $4}'}.chomp

#  Next fetch warranty information from Apple.
item = %x{curl -k -s "https://selfsolve.apple.com/Warranty.do?serialNumber=#{sn}&country=USA&fullCountryName=United%20States"}.chomp

#  Remove the quotation marks from the information provided by Apple, along with whitespace,
#  and enter the remaining information into an array.
warranty_array = item.strip.split('"')

#  Set the Purchase Date by searching through the Array
purchase_date = warranty_array.index('PURCHASE_DATE')

Facter.add("purchase_date") do
  setcode do
    $purchase_date = warranty_array[purchase_date+2]
  end
end

#  First we need to check and see if the machine is out of warranty.  If it is,
#  return the purchase date.  If it isn't out of warranty, return the Coverage Date
coverage_check = warranty_array.index('COVERAGE_DESC')

if warranty_array[coverage_check+2].chomp == "Out of Warranty"
  
  Facter.add("warranty_end") do
    setcode do
      $warranty_end = warranty_array[purchase_date+2]
    end
  end
  
else
  
  position = warranty_array.index('COVERAGE_DATE')
  Facter.add("warranty_end") do
    setcode do
      $warranty_end = warranty_array[position+2]
    end
  end
end