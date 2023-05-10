# == Class: cultuurnet::apache
#
class cultuurnet::apache {
  include ::apache

  class {
    '::cultuurnet::apache::monitor':;
  }
}
