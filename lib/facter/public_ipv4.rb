Facter.add('public_ipv4') do
  confine do
    Facter.value(:ec2_metadata)
  end

  setcode do
    Facter.value(:ec2_metadata)['public-ipv4']
  end
end
