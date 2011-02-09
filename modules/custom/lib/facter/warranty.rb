#
# File:       warranty.rb
# Type:       Facter fact
# Decription: Returns the dates of purchase and warranty expiration,
#              plus determines if the warranty is active or inactive.
#              We're using open-uri which caused SSL errors behind 
#              proxies (hence the hack in lines 16-20).

require 'facter'
require 'open-uri'
require 'openssl'

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
  hash = {}
  sn  = %x{system_profiler SPHardwareDataType | awk -F": " '/Serial/{print $2}'}
  open('https://selfsolve.apple.com/warrantyChecker.do?sn=' + sn.upcase + '&country=USA') {|item|
         item.each_line {|item|}
         warranty_array = item.strip.split('"')
         warranty_array.each {|array_item|
           hash[array_item] = warranty_array[warranty_array.index(array_item) + 2] if array_item =~ /[A-Z][A-Z\d]+/
         }
  }
end

Facter.add("purchase_date") do
  confine :kernel => "Darwin"
  setcode do
    hash['PURCHASE_DATE'].gsub("-",".")
  end 
end

Facter.add("warranty_out") do
  confine :kernel => "Darwin"
  setcode do
    (hash['HW_COVERAGE_DESC'] == 'Out of Warranty') ? "Yes" : "No"
  end 
end

Facter.add("warranty_end") do
  confine :kernel => "Darwin"
  setcode do
    (!hash['COV_END_DATE'].empty?) ? hash['COV_END_DATE'].gsub("-",".") : "Expired"
  end 
end


Facter.add("product_description") do
  confine :kernel => "Darwin"
  setcode do
    hash['PROD_DESCR'].chomp
  end 
end
