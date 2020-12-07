class cultuurnet::resources::media_download_manager {
  file { '/var/www/media-download-manager':
      ensure => 'directory',
      owner =>  'www-data',
      group =>  'www-data',
      }
  file { '/var/www/media-download-manager/web':
      ensure => 'directory',
      owner =>  'www-data',
      group =>  'www-data',
      }
}
