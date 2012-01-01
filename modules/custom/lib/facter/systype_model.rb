Facter.add('systype_model') do
  setcode do
    case Facter.value(:sp_machine_name)
      when /[bB]ook/ then 'Laptop'
      when /[sS]erve/ then 'Server'
      else 'Desktop'
    end
  end
end
