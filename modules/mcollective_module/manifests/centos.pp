class mcollective_module::centos {

    # Load the variables used in this module. Check the params.pp file 
    require mcollective_module::params

    # Autoloads server class. This is done by default.
    # To install a mcollective client without the server components 
    # Set $mcollective_client to "yes" and $mcollective_server to "no"
    include mcollective_module::server

    # Include debug class is debugging is enabled ($debug=yes)
    # Autoloads client class if $mcollective_client is "yes"
    include mcollective_module::client

}