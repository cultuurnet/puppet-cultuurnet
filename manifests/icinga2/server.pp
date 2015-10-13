# == Class: cultuurnet::icinga2::server
#
class cultuurnet::icinga2::server (
  $db_host        = '127.0.0.1',
  $db_name        = 'icinga2',
  $db_pass        = 'icinga2',
  $db_port        = '5432',
  $db_user        = 'icinga2',
  $server_db_type = 'pgsql',
) {
  class { '::icinga2::server':
    db_host                       => $db_host,
    db_name                       => $db_name,
    db_password                   => $db_pass,
    db_port                       => $db_port,
    db_user                       => $db_user,
    server_db_type                => $server_db_type,
    server_install_nagios_plugins => false,
  }

  case $server_db_type {
    'pgsql': {
      require ::postgresql::server
      require ::cultuurnet::postgresql

      ::icinga2::object::idopgsqlconnection { $server_db_type:
        categories       => [
          'DbCatConfig',
          'DbCatState',
          'DbCatAcknowledgement',
          'DbCatComment',
          'DbCatDowntime',
          'DbCatEventHandler',
        ],
        database         => $db_name,
        host             => $db_host,
        password         => $db_pass,
        port             => $db_port,
        target_dir       => '/etc/icinga2/features-enabled',
        target_file_name => "ido-${server_db_type}.conf",
        user             => $db_user,
      }

      Icinga2::Object::Idopgsqlconnection <<||>>
    }

    'mysql': {
      icinga2::object::idomysqlconnection { $server_db_type:
        categories       => [
          'DbCatConfig',
          'DbCatState',
          'DbCatAcknowledgement',
          'DbCatComment',
          'DbCatDowntime',
          'DbCatEventHandler',
        ],
        database         => $db_name,
        host             => $db_host,
        password         => $db_pass,
        port             => $db_port,
        target_dir       => '/etc/icinga2/features-enabled',
        target_file_name => "ido-${server_db_type}.conf",
        user             => $db_user,
      }

      Icinga2::Object::Idomysqlconnection <<||>>
    }

    default: {
      fail "Wrong value for \$server_db_type: ${server_db_type}."
    }
  }

  create_resources(
    ::icinga2::object::apply_notification_to_host,
    hiera_hash('icinga2::object::apply_notification_to_host', {})
  )

  create_resources(
    ::icinga2::object::apply_notification_to_service,
    hiera_hash('icinga2::object::apply_notification_to_service', {})
  )

  create_resources(
    ::icinga2::object::apply_service_to_host,
    hiera_hash('icinga2::object::apply_service_to_host', {})
  )

  create_resources(
    ::icinga2::object::checkcommand,
    hiera_hash('icinga2::object::checkcommand', {})
  )

  create_resources(
    ::icinga2::object::checkresultreader,
    hiera_hash('icinga2::object::checkresultreader', {})
  )

  create_resources(
    ::icinga2::object::compatlogger,
    hiera_hash('icinga2::object::compatlogger', {})
  )

  create_resources(
    ::icinga2::object::eventcommand,
    hiera_hash('icinga2::object::eventcommand', {})
  )

  create_resources(
    ::icinga2::object::externalcommandlistener,
    hiera_hash('icinga2::object::externalcommandlistener', {})
  )

  create_resources(
    ::icinga2::object::host,
    hiera_hash('icinga2::object::host', {})
  )

  create_resources(
    ::icinga2::object::hostgroup,
    hiera_hash('icinga2::object::hostgroup', {})
  )

  create_resources(
    ::icinga2::object::idomysqlconnection,
    hiera_hash('icinga2::object::idomysqlconnection', {})
  )

  create_resources(
    ::icinga2::object::idopgsqlconnection,
    hiera_hash('icinga2::object::idopgsqlconnection', {})
  )

  create_resources(
    ::icinga2::object::livestatuslistener,
    hiera_hash('icinga2::object::livestatuslistener', {})
  )

  create_resources(
    ::icinga2::object::notification,
    hiera_hash('icinga2::object::notification', {})
  )

  create_resources(
    ::icinga2::object::notificationcommand,
    hiera_hash('icinga2::object::notificationcommand', {})
  )

  create_resources(
    ::icinga2::object::perfdatawriter,
    hiera_hash('icinga2::object::perfdatawriter', {})
  )

  create_resources(
    ::icinga2::object::scheduleddowntime,
    hiera_hash('icinga2::object::scheduleddowntime', {})
  )

  create_resources(
    ::icinga2::object::service,
    hiera_hash('icinga2::object::service', {})
  )

  create_resources(
    ::icinga2::object::servicegroup,
    hiera_hash('icinga2::object::servicegroup', {})
  )

  create_resources(
    ::icinga2::object::statusdatawriter,
    hiera_hash('icinga2::object::statusdatawriter', {})
  )

  create_resources(
    ::icinga2::object::syslogger,
    hiera_hash('icinga2::object::syslogger', {})
  )

  create_resources(
    ::icinga2::object::timeperiod,
    hiera_hash('icinga2::object::timeperiod', {})
  )

  create_resources(
    ::icinga2::object::user,
    hiera_hash('icinga2::object::user', {})
  )

  create_resources(
    ::icinga2::object::usergroup,
    hiera_hash('icinga2::object::usergroup', {})
  )

  #Icinga2::Object::Syslogger <<||>>
  Icinga2::Object::Apply_service_to_host <<||>>
  Icinga2::Object::Checkcommand <<||>>
  Icinga2::Object::Host <<||>>
  Icinga2::Object::Hostgroup <<||>>
  Icinga2::Object::Service <<||>>
  Icinga2::Object::Servicegroup <<||>>
  Icinga2::Object::User <<||>>
  Icinga2::Object::Usergroup <<||>>

  # Remove hosts that are deactivated in PuppetDB
  $deactivated = deactivated_nodes()

  define deactivated_node {
    ::icinga2::object::host { $title:
      target_dir         => '/etc/icinga2/objects/hosts',
      target_file_name   => "${title}.conf",
      target_file_ensure => 'absent'
    }
  }

  deactivated_node { $deactivated: }
}
