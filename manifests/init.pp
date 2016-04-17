# == Class: cultuurnet
#
class cultuurnet {

  class {
    '::cultuurnet::firewall':;
    '::cultuurnet::sshkeys':;
    '::cultuurnet::users':;
  }

  if $settings::storeconfigs {
    class { '::cultuurnet::knownhosts': }
  }

  file { '/usr/local/bin/update_facts':
    ensure => 'file',
    mode   => '0755',
    source => 'puppet:///modules/cultuurnet/update_facts'
  }
}
