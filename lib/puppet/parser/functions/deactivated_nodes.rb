module Puppet::Parser::Functions
  newfunction(:deactivated_nodes, :type => :rvalue, :doc => <<-EOS
    Returns an array with the certnames of the nodes that are disabled in PuppetDB.
    Does not take any arguments.
    EOS
  ) do |arguments|

    raise(Puppet::ParseError, "deactivated_nodes(): Wrong number of arguments " +
          "given (#{arguments.size} for 0)") if arguments.size != 0

    begin
      require 'postgres-pr'
      require 'inifile'

      DATABASE_CONFIG_FILE = '/etc/puppetdb/conf.d/database.ini'
      config = IniFile.load(DATABASE_CONFIG_FILE).to_h

      conn = PostgresPR::Connection.new(
        config['database']['subname'][/.*\/(.*)$/,1],
        config['database']['username'],
        config['database']['password'],
        "tcp://#{config['database']['subname'][/^\/\/[^\/]+/]}"
      )

      conn.query('select name from certnames where deactivated is not null').rows.flatten
    end
  end
end
