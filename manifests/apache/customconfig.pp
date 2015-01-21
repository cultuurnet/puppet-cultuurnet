# == Class: cultuurnet::apache::customconfig
#
class cultuurnet::apache::customconfig {
  create_resources(apache::custom_config, hiera_hash('apache::custom_config', {}))
}
