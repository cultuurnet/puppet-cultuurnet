class cultuurnet::resources::udb3_cert {
    file { '/etc/ssl/certs/uitdatabank.be.crt':
      ensure => 'file',
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => 'puppet:///private/certs/uitdatabank.be.crt',
      }
    file { '/etc/ssl/private/uitdatabank.be.key':
      ensure => 'file',
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => 'puppet:///private/certs/uitdatabank.be.key',
      }
    file { '/etc/ssl/certs/comodo_bundle_intermediate.pem':
      ensure => 'file',
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => 'puppet:///private/certs/comodo_bundle_intermediate.pem',
      }
    notify { 'kanarie':
      message => 'this server is using udb3_cert class to install the udb3 cert'
    } 
}

