#
#  File:  currentuser.rb
#
#  Description: A facter fact determining the currently-logged-in user
#   based on the owner of the /dev/console file.
#

require 'etc' 
require 'facter'

uid = File.stat('/dev/console').uid 

Facter.add("currentuser") do
  confine :kernel => "Darwin"
  setcode do
    Etc.getpwuid(uid).name
  end
end
