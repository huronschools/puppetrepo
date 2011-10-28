metadata :name        => 'printer',
         :description => 'Performs actions for printers and printing',
         :author      => 'Gary Larizza',
         :license     => 'BSD',
         :version     => '0.1',
         :url         => 'http://puppetlabs.com',
         :timeout     => 120

action "list", :description => "Lists current printers on the system" do
  display :always

  output :output,
         :description => "Current Printers",
         :display_as  => "Printers"
end

action "remove", :description => "Removes specified printers" do
  display :always

  output :output,
         :description => "Remove Printers",
         :display_as  => "Removed Printers"
end

action "devices", :description => "List printers and their devices" do
  display :always

  output :output,
	 :description => "Printers and their devices",
	 :display_as  => "Printers"
end
