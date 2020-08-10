class cultuurnet::resources::httpauth { 


   file { '/etc/apache2/uitmetvlieg-htpasswd':
      ensure => 'file',
      mod => '0644',
      } 
   httpauth { 'admin':
      file     => '/etc/apache2/uitmetvlieg-htpasswd',
      password => 'aiphei7Kie8e',
      require  => 'Class[Apache]',
      before   => 'File[/etc/apache2/uitmetvlieg-htpasswd]',
      }
    httpauth { 'uitmetvlieg':
      file     => '/etc/apache2/uitmetvlieg-htpasswd',
      password => 'Umewoo2e',
      require  => 'Class[Apache]',
      before   => 'File[/etc/apache2/uitmetvlieg-htpasswd]',
      }
    httpauth {'vlieg':
      file     => '/etc/apache2/uitmetvlieg-htpasswd',
      password => 'Fei5ooJu',
      require  => 'Class[Apache]',
      before   => 'File[/etc/apache2/uitmetvlieg-htpasswd]',
      }
    httpauth {'kanarie':
      file     => '/etc/apache2/uitmetvlieg-htpasswd',
      password => 'Fei5ooJuuwaco',
      require  => 'Class[Apache]',
      before   => 'File[/etc/apache2/uitmetvlieg-htpasswd]',
      }


}
