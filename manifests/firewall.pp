# == Class: cultuurnet::firewall
#
class cultuurnet::firewall {

  firewall { '200 accept nrpe traffic':
    proto  => 'tcp',
    dport  => '5666',
    action => 'accept'
  }

  firewall { '100 accept ssh traffic':
    proto  => 'tcp',
    dport  => '22',
    action => 'accept'
  }

  create_resources(firewall, hiera_hash('firewall', {}))
}
