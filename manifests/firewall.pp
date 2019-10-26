# == Class: cultuurnet::firewall
#
class cultuurnet::firewall {

  create_resources(firewall, hiera_hash('firewall', {}))
}
