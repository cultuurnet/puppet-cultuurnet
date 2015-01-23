# == Class: cultuurnet::icinga2::web2
#
class cultuurnet::icinga2::web2 (
  $db_host        = '127.0.0.1',
  $db_name        = 'icingaweb2',
  $db_pass        = 'icingaweb2',
  $db_port        = '3306',
  $db_user        = 'icingaweb2',
  $server_db_type = 'mysql',
) {
  require ::icinga2::server

  file { '/etc/apache2/sites-enabled/icinga-web-2.conf':
    ensure  => present,
    owner   => 0,
    group   => 0,
    mode    => '0640',
    content => template('cultuurnet/apache2-icingaweb2.conf.erb'),
  }
}
