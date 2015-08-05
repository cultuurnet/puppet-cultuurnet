# == Class: cultuurnet::icinga2::client
#
class cultuurnet::icinga2::client () {
  require ::icinga2::nrpe

  if ! defined(Class['::cultuurnet::icinga2::server']) {
    notice "Exporting Icinga data for ${::fqdn}"
    @@::icinga2::object::host { $::fqdn:
      display_name     => $::fqdn,
      ipv4_address     => hiera('icinga2::object::host::ipv4_address', $::ipaddress),
      target_dir       => '/etc/icinga2/objects/hosts',
      target_file_name => "${::fqdn}.conf",
      vars             => {
        distro              => $::operatingsystem,
        os                  => $::kernel,
        virtual_machine     => $::is_virtual,
        puppet_certname     => $::clientcert,
      },
    }
  }

  create_resources(
    ::icinga2::object::checkcommand,
    hiera_hash('icinga2::object::checkcommand', {})
  )

  create_resources(
    ::icinga2::checkplugin,
    hiera_hash('icinga2::checkplugin', {})
  )

  create_resources(
    ::icinga2::nrpe::command,
    hiera_hash('icinga2::nrpe::command', {})
  )
}

