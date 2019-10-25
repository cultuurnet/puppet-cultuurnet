# == Class: cultuurnet::firewall
#
class cultuurnet::firewall {

  # unless $::clientcert == 'puppetserver.eu-west-1.compute.internal' {

    include ::firewall

    resources { 'firewall': purge => true }

    firewall { '200 accept nrpe traffic':
      proto  => 'tcp',
      dport  => '5666',
      action => 'accept'
    }

    create_resources(firewall, hiera_hash('firewall', {}))
  # }
}
