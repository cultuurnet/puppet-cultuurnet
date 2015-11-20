require 'facter/util/appversions.rb'

Facter.add(:udb3_version) do
  setcode do
    Facter::Util::AppVersions.get_version 'udb3'
  end
end
