module Puppet::Parser::Functions
  newfunction(:deactivated_nodes, :type => :rvalue, :doc => <<-EOS
    Returns an array with the certnames of the nodes that are disabled in PuppetDB.
    Does not take any arguments.
    EOS
  ) do |arguments|

    raise(Puppet::ParseError, "deactivated_nodes(): Wrong number of arguments " +
          "given (#{arguments.size} for 0)") if arguments.size != 0

    begin
      require 'pg'
      require 'inifile'

      DATABASE_CONFIG_FILE = '/etc/puppetdb/conf.d/database.ini'
      config = IniFile.load(DATABASE_CONFIG_FILE).to_h

      conn = PGconn.connect(
        :host => config['database']['subname'][/\/\/(.*):/,1],
        :port => config['database']['subname'][/:(.*)\//,1],
        :dbname => config['database']['subname'][/.*\/(.*)$/,1],
        :user => config['database']['username'],
        :password => config['database']['password']
      )

      res  = conn.exec('select * from certnames where deactivated is not null')

      res.inject([]) { |nodes, row| nodes << row['name'] }
    end
  end
end
