require 'facter'
require 'open-uri'

# This is a complete hack to disregard SSL Cert validity for the Apple
#  Selfserve site.  We had SSL errors as we're behind a proxy.  I'm
#  open to suggestions for doing it 'Less-Hacky.'
module OpenSSL
  module SSL
    remove_const:VERIFY_PEER
  end
end

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE


# Constraining to the Darwin Kernel - it's only useful for Macs
if Facter.value('kernel') == 'Darwin'
  warranty_array = []
  sn  = %x{ioreg  -l | grep IOPlatformSerialNumber | sed -e s/\\"//g}.chomp.split{"="}[-1].chomp
  open('https://selfsolve.apple.com/warrantyChecker.do?sn=' + sn.upcase + '&country=USA') {|item|
         item.each_line {|item|}
         warranty_array = item.strip.split('"')
  }
  coverage = warranty_array.index('COV_END_DATE')
  purchase = warranty_array.index('PURCHASE_DATE')
  outofwarranty = warranty_array.index('HW_COVERAGE_DESC')
end

Facter.add("purchase_date") do
  confine :kernel => "Darwin"
  setcode do
    warranty_array[purchase+2]
  end 
end

Facter.add("warranty_out") do
  confine :kernel => "Darwin"
  setcode do
    (warranty_array[outofwarranty+2] == 'Out of Warranty') ? "Yes" : "No"
  end 
end


Facter.add("warranty_end") do
  confine :kernel => "Darwin"
  setcode do
    (!warranty_array[coverage+2].empty?) ? warranty_array[coverage+2] : "Expired"
  end 
end