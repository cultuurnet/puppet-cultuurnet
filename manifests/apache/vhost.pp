# == Class: cultuurnet::apache::vhost
#
class cultuurnet::apache::vhost {
  create_resources(apache::vhost, hiera_hash('apache::vhost', {}))
}
