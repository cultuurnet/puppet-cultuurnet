class cultuurnet::knownhosts {

  @@sshkey { $::ipaddress_eth0:
    type => 'rsa',
    key  => $::sshrsakey
  }
}
