require 'json'

module Facter
  module Util
    module CultuurNetApps
      def self.get_version(prefix)
        command = "dpkg-query -f='\$\{binary:Package\}:\$\{Version\}\\n' -W '#{prefix}*' 2> /dev/null"
        versions = Facter::Core::Execution.exec(command)

        if versions.empty?
          nil
        else
          versions.split("\n").inject({}) do |result, string|
            component = string[/(.*):/,1]
            version = string[/:(.*)$/,1]
            commit = version[/\+sha.(.*)$/,1] || ""

            result.merge({ component => { 'version' => version, 'commit' => commit} })
          end
        end
      end
    end
  end
end
