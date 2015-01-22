# == Class: cultuurnet::puppetmaster
#
class cultuurnet::puppetmaster () {
  require ::apache

  class {
    '::apache::mod::headers':;
    '::apache::mod::passenger':;
    '::apache::mod::ssl':;
  }

  file { '/etc/apache2/sites-available/puppetmaster.conf':
    ensure  => present,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => template('cultuurnet/apache2-puppetmaster.conf.erb'),
  } ->

  file { '/etc/apache2/sites-enabled/puppetmaster.conf':
    ensure => link,
    target => '/etc/apache2/sites-available/puppetmaster.conf',
  }
}

