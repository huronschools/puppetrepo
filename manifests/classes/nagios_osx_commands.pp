
class nagios_osx_commands{

	Nagios_command{target => '/usr/local/nagios/etc/puppet_osx_commands.cfg',}

	nagios_command { "check_osx_afp":
		command_line => '/usr/local/nagios/libexec/check_osx_server afp $HOSTADDRESS$ $ARG1$ $ARG2$ $ARG3$',
		command_name => 'check_osx_afp';
	}

	nagios_command { "restart_osx_afp":
		command_line => '/usr/local/nagios/libexec/osx_server_event_handler afp $SERVICESTATE$ $SERVICESTATETYPE$ $SERVICEATTEMPT$ $HOSTADDRESS$ $ARG1$ $ARG2$ $ARG3$',
		command_name => 'restart_osx_afp';
	}

	nagios_command { "check_osx_dhcp":
		command_line => '/usr/local/nagios/libexec/check_osx_server dhcp $HOSTADDRESS$ $ARG1$ $ARG2$ $ARG3$',
		command_name => 'check_osx_dhcp';
	}

	nagios_command { "restart_osx_dhcp":
		command_line => '/usr/local/nagios/libexec/osx_server_event_handler dhcp $SERVICESTATE$ $SERVICESTATETYPE$ $SERVICEATTEMPT$ $HOSTADDRESS$ $ARG1$ $ARG2$ $ARG3$',
		command_name => 'restart_osx_dhcp';
	}

	nagios_command { "check_osx_dirsrv":
		command_line => '/usr/local/nagios/libexec/check_osx_server dirserv $HOSTADDRESS$ $ARG1$ $ARG2$ $ARG3$',
		command_name => 'check_osx_dirsrv';
	}

	nagios_command { "restart_osx_dirsrv":
		command_line => '/usr/local/nagios/libexec/osx_server_event_handler dirsrv $SERVICESTATE$ $SERVICESTATETYPE$ $SERVICEATTEMPT$ $HOSTADDRESS$ $ARG1$ $ARG2$ $ARG3$',
		command_name => 'restart_osx_dirsrv';
	}

	nagios_command { "check_osx_dns":
		command_line => '/usr/local/nagios/libexec/check_osx_server dns $HOSTADDRESS$ $ARG1$ $ARG2$ $ARG3$',
		command_name => 'check_osx_dns';
	}

	nagios_command { "restart_osx_dns":
		command_line => '/usr/local/nagios/libexec/osx_server_event_handler dns $SERVICESTATE$ $SERVICESTATETYPE$ $SERVICEATTEMPT$ $HOSTADDRESS$ $ARG1$ $ARG2$ $ARG3$',
		command_name => 'restart_osx_dns';
	}

	nagios_command { "check_osx_ftp":
		command_line => '/usr/local/nagios/libexec/check_osx_server ftp $HOSTADDRESS$ $ARG1$ $ARG2$ $ARG3$',
		command_name => 'check_osx_ftp';
	}

	nagios_command { "restart_osx_ftp":
		command_line => '/usr/local/nagios/libexec/osx_server_event_handler ftp $SERVICESTATE$ $SERVICESTATETYPE$ $SERVICEATTEMPT$ $HOSTADDRESS$ $ARG1$ $ARG2$ $ARG3$',
		command_name => 'restart_osx_ftp';
	}

	nagios_command { "check_osx_jabber":
		command_line => '/usr/local/nagios/libexec/check_osx_server jabber $HOSTADDRESS$ $ARG1$ $ARG2$ $ARG3$',
		command_name => 'check_osx_jabber';
	}

	nagios_command { "restart_osx_jabber":
		command_line => '/usr/local/nagios/libexec/osx_server_event_handler jabber $SERVICESTATE$ $SERVICESTATETYPE$ $SERVICEATTEMPT$ $HOSTADDRESS$ $ARG1$ $ARG2$ $ARG3$',
		command_name => 'restart_osx_jabber';
	}

	nagios_command { "check_osx_mail":
		command_line => '/usr/local/nagios/libexec/check_osx_server mail $HOSTADDRESS$ $ARG1$ $ARG2$ $ARG3$',
		command_name => 'check_osx_mail';
	}

	nagios_command { "check_osx_mysql":
		command_line => '/usr/local/nagios/libexec/check_osx_server mysql $HOSTADDRESS$ $ARG1$ $ARG2$ $ARG3$',
		command_name => 'check_osx_mysql';
	}

	nagios_command { "restart_osx_mysql":
		command_line => '/usr/local/nagios/libexec/osx_server_event_handler mysql $SERVICESTATE$ $SERVICESTATETYPE$ $SERVICEATTEMPT$ $HOSTADDRESS$ $ARG1$ $ARG2$ $ARG3$',
		command_name => 'restart_osx_mysql';
	}

	nagios_command { "check_osx_nat":
		command_line => '/usr/local/nagios/libexec/check_osx_server nat $HOSTADDRESS$ $ARG1$ $ARG2$ $ARG3$',
		command_name => 'check_osx_nat';
	}

	nagios_command { "restart_osx_nat":
		command_line => '/usr/local/nagios/libexec/osx_server_event_handler nat $SERVICESTATE$ $SERVICESTATETYPE$ $SERVICEATTEMPT$ $HOSTADDRESS$ $ARG1$ $ARG2$ $ARG3$',
		command_name => 'restart_osx_nat';
	}

	nagios_command { "check_osx_netboot":
		command_line => '/usr/local/nagios/libexec/check_osx_server netboot $HOSTADDRESS$ $ARG1$ $ARG2$ $ARG3$',
		command_name => 'check_osx_netboot';
	}

	nagios_command { "restart_osx_netboot":
		command_line => '/usr/local/nagios/libexec/osx_server_event_handler netboot $SERVICESTATE$ $SERVICESTATETYPE$ $SERVICEATTEMPT$ $HOSTADDRESS$ $ARG1$ $ARG2$ $ARG3$',
		command_name => 'restart_osx_netboot';
	}

	nagios_command { "check_osx_nfs":
		command_line => '/usr/local/nagios/libexec/check_osx_server nfs $HOSTADDRESS$ $ARG1$ $ARG2$ $ARG3$',
		command_name => 'check_osx_nfs';
	}

	nagios_command { "restart_osx_nfs":
		command_line => '/usr/local/nagios/libexec/osx_server_event_handler nfs $SERVICESTATE$ $SERVICESTATETYPE$ $SERVICEATTEMPT$ $HOSTADDRESS$ $ARG1$ $ARG2$ $ARG3$',
		command_name => 'restart_osx_nfs';
	}

	nagios_command { "check_osx_print":
		command_line => '/usr/local/nagios/libexec/check_osx_server print $HOSTADDRESS$ $ARG1$ $ARG2$ $ARG3$',
		command_name => 'check_osx_print';
	}

	nagios_command { "restart_osx_print":
		command_line => '/usr/local/nagios/libexec/osx_server_event_handler print $SERVICESTATE$ $SERVICESTATETYPE$ $SERVICEATTEMPT$ $HOSTADDRESS$ $ARG1$ $ARG2$ $ARG3$',
		command_name => 'restart_osx_print';
	}

	nagios_command { "check_osx_qtss":
		command_line => '/usr/local/nagios/libexec/check_osx_server qtss $HOSTADDRESS$ $ARG1$ $ARG2$ $ARG3$',
		command_name => 'check_osx_qtss';
	}

	nagios_command { "restart_osx_qtss":
		command_line => '/usr/local/nagios/libexec/osx_server_event_handler qtss $SERVICESTATE$ $SERVICESTATETYPE$ $SERVICEATTEMPT$ $HOSTADDRESS$ $ARG1$ $ARG2$ $ARG3$',
		command_name => 'restart_osx_qtss';
	}

	nagios_command { "check_osx_samba":
		command_line => '/usr/local/nagios/libexec/check_osx_server smb $HOSTADDRESS$ $ARG1$ $ARG2$ $ARG3$',
		command_name => 'check_osx_samba';
	}

	nagios_command { "restart_osx_samba":
		command_line => '/usr/local/nagios/libexec/osx_server_event_handler smb $SERVICESTATE$ $SERVICESTATETYPE$ $SERVICEATTEMPT$ $HOSTADDRESS$ $ARG1$ $ARG2$ $ARG3$',
		command_name => 'restart_osx_samba';
	}

	nagios_command { "check_osx_swupdate":
		command_line => '/usr/local/nagios/libexec/check_osx_server swupdate $HOSTADDRESS$ $ARG1$ $ARG2$ $ARG3$',
		command_name => 'check_osx_swupdate';
	}

	nagios_command { "restart_osx_swupdate":
		command_line => '/usr/local/nagios/libexec/osx_server_event_handler swupdate $SERVICESTATE$ $SERVICESTATETYPE$ $SERVICEATTEMPT$ $HOSTADDRESS$ $ARG1$ $ARG2$ $ARG3$',
		command_name => 'restart_osx_swupdate';
	}

	nagios_command { "check_osx_web":
		command_line => '/usr/local/nagios/libexec/check_osx_server web $HOSTADDRESS$ $ARG1$ $ARG2$ $ARG3$',
		command_name => 'check_osx_web';
	}

	nagios_command { "restart_osx_web":
		command_line => '/usr/local/nagios/libexec/osx_server_event_handler web $SERVICESTATE$ $SERVICESTATETYPE$ $SERVICEATTEMPT$ $HOSTADDRESS$ $ARG1$ $ARG2$ $ARG3$',
		command_name => 'restart_osx_web';
	}

	file { "/usr/local/nagios/etc/puppet_osx_commands.cfg":
		owner => 'nagiosuser',
		group => 'nagios',
		mode => 644,
	}
}