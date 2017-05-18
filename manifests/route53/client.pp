class cultuurnet::route53::client () {
  @@route53_a_record { "${::hostname}.machines.publiq.be":
      zone	=> 'publiq.be.',
      ttl	=> '300', 
      values	=> [$::ec2_metadata['public_ipv4']]
  }
}


