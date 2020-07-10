class cultuurnet::resources::logrotate {

    logrotate::rule { 'apache2':
      path          => '/var/log/apache2/*.log',
      rotate        => '30',
      rotate_every  => 'day',
      missingok     => true,
      compress      => true,
      delaycompress => true,
      ifempty       => false,
      create        => true,
      create_mode   => '0640',
      create_owner  => 'root',
      create_group  => 'adm',
      sharedscripts => true,
      postrotate    => '/etc/init.d/apache2 status > /dev/null && /etc/init.d/apache2 reload > /dev/null',
      prerotate     => 'if [ -d /etc/logrotate.d/httpd-prerotate ]; then run-parts /etc/logrotate.d/httpd-prerotate; fi'
    }
}
