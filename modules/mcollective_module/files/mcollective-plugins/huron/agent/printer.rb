module MCollective
  module Agent
    class Printer<RPC::Agent
      metadata :name        => 'printer',
               :description => 'Performs actions for printers and printing',
               :author      => 'Gary Larizza',
               :license     => 'BSD',
               :version     => '0.1',
               :url         => 'http://puppetlabs.com',
               :timeout     => 100

      action 'list' do
        reply[:result] = `lpstat -a | cut -d ' ' -f 1`.split("\n")
      end

      action 'devices' do
	reply[:result] = `lpstat -v | cut -d ' ' -f 3,4`.split("\n")
      end
    
      action 'remove' do
	validate :name, :shellsafe

	return_code = system("lpadmin -x #{request[:name]}")

        if return_code
  	  reply[:result] << "Successfully removed printer: #{request[:name]}\n"
	else
	  reply.fail "There was an error attempting to delete printer: #{request[:name]}"
	end 
      end
    end
  end
end
