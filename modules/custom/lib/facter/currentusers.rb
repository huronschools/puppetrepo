#
#  File:  currentuser.rb
#
#  Description: A facter fact determining the currently-logged-in user
#   based on the owner of the /dev/console file.
#
require 'facter'

users = []
users += %x(ps aux 2> /dev/null | grep [l]oginwindow | cut -d " " -f1).split()

Facter.add("currentusers") do
  confine :kernel => "Darwin"
  setcode do
    (users - ['root']).join(",")
  end
end
