# == Class: cultuurnet
#
class cultuurnet {

  class {
    '::cultuurnet::firewall':;
    '::cultuurnet::sshkeys':;
    '::cultuurnet::knownhosts':;
    '::cultuurnet::users':;
  }
}
