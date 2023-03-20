class cultuurnet::route53::client (
  String $zone_name = 'publiq.be'
) {
  $zone = regsubst($zone_name, '\.$', '')

  if versioncmp( $facts['os']['release']['major'], '20.04') < 0 {
    @@route53_a_record { "${::hostname}.machines.publiq.be.":
      zone	 => "${zone}.",
      ttl	   => '300',
      values => [ "${::ec2_metadata['public-ipv4']}" ]
    }
  }
}
