require 'facter'

Facter.add("printerlist") do
  setcode do
    %x(lpstat -a | cut -d ' ' -f 1).split("\n").join(",")
  end
end



