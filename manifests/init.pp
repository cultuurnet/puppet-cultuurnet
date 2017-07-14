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
}
