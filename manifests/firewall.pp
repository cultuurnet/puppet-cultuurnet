# == Class: cultuurnet::firewall
#
class cultuurnet::firewall {

  # unless $::clientcert == 'puppetserver.eu-west-1.compute.internal' {

    include ::firewall

    resources { 'firewall': purge => true }

    create_resources(firewall, hiera_hash('firewall', {}))
  # }
}
