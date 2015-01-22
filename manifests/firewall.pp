# == Class: cultuurnet::firewall
#
class cultuurnet::firewall {
  include ::firewall
  create_resources(firewall, hiera_hash('firewall', {}))
}
