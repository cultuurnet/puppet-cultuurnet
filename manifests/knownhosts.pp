class cultuurnet::knownhosts {

  if $settings::storeconfigs {
    @@sshkey { $::ipaddress_eth0:
      type => 'rsa',
      key  => $::sshrsakey
    }
  }
}
