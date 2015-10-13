# == Class: cultuurnet
#
class cultuurnet {

  resources { 'sshkey':
    purge => true,
    noop  => true
  }

  class {
    '::cultuurnet::firewall':;
    '::cultuurnet::sshkeys':;
    '::cultuurnet::knownhosts':;
    '::cultuurnet::users':;
  }
}
