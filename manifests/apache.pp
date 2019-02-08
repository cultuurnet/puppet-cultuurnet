# == Class: cultuurnet::apache
#
class cultuurnet::apache {
  require ::apache

  class {
    '::cultuurnet::apache::monitor':;
  }
}
