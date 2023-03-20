class cultuurnet::route53::client () {

  if versioncmp( $facts['os']['release']['major'], '20.04') < 0 {
    @@route53_a_record { "${::hostname}.machines.publiq.be.":
      zone	=> 'publiq.be.',
      ttl	=> '300',
      values	=> [ "${::ec2_metadata['public-ipv4']}" ]
    }
  }
}
