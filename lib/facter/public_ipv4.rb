
Facter.add('public_ipv4') do
  setcode do
    Facter.value(:ec2metadata)['public-ipv4s']
  end
end
