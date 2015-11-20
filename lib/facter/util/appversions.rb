require 'json'

module Facter
  module Util
    module AppVersions
      def self.get_version(prefix)
	versions = Facter::Core::Execution.exec("dpkg-query -f='${binary:Package}:${Version}\n' -W #{prefix}*")

	versions.split('\n').map do |string|
	  component = string[/(.*):/,1]
	  version = string[/:(.*)$/,1]
	  commit = version[/\+sha.(.*)$/,1] || ""

          { component => { :version => version, :commit => commit} }
        end
      end
    end
  end
end
