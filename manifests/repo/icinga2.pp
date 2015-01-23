# == Class: cultuurnet::repo::icinga2
#
class cultuurnet::repo::icinga2 {
  require ::apt

  apt::ppa { 'formorer/icinga':; }
}
