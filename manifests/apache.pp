# == Class: cultuurnet::apache
#
class cultuurnet::apache {
  require ::apache

  class {
    '::cultuurnet::apache::customconfig':;
    '::cultuurnet::apache::monitor':;
    '::cultuurnet::apache::vhost':;
  }
}
