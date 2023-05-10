# == Class: cultuurnet::apache::monitor
#
class cultuurnet::apache::monitor {
  include ::apache
  include ::collectd

  class { '::apache::mod::status':
    allow_from      => [ '127.0.0.1', '::1', ],
    extended_status => 'On',
    status_path     => '/server-status',
  }

  class { '::collectd::plugin::apache':
    instances => {
      localhost => {
        url => 'http://localhost/server-status?auto',
      },
    },
  }
}
