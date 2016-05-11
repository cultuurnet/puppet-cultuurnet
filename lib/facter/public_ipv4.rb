
Facter.add('public_ipv4') do
  setcode do
    Facter.value(:ec2_metadata)['public-ipv4']
  end
end
