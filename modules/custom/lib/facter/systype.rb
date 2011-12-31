Facter.add('systype') do
  Facter::Util::Resolution.exec('ioreg -l').split("\n").each {|line| @type = line.split("\s").last if line =~ /system-type/ }
  setcode do
    systype = case @type
      when '<02>' then 'Laptop'
      when '<01>' then 'Desktop'
      else 'Unknown'
    end
    systype
  end
end
