# == Class: cultuurnet::icinga2::client
#
class cultuurnet::icinga2::client () {
  require ::icinga2::nrpe

  @@::icinga2::object::host { $::fqdn:
    display_name     => $::fqdn,
    ipv4_address     => $::ipaddress,
    target_dir       => '/etc/icinga2/objects/hosts',
    target_file_name => "${::fqdn}.conf",
    vars             => {
      distro              => $::operatingsystem,
      os                  => $::kernel,
      virtual_machine     => $::is_virtual,
      puppet_certname     => $::clientcert,
      puppet_environment  => $::agent_specified_environment,
    }
  }

  firewall { '200 accept nrpe traffic':
    proto  => 'tcp',
    dport  => '5666',
    action => 'accept'
  }

  create_resources(
    ::icinga2::checkplugin,
    hiera_hash('icinga2::checkplugin', {})
  )

  create_resources(
    ::icinga2::nrpe::command,
    hiera_hash('icinga2::nrpe::command', {})
  )
}
