class cultuurnet::backup(
  $configurations     = { 'filesystem' => { source_directories => '/root', encryption => 'none', repository => '/var/backups/borgbackup' } },
  $privkey            = '',
  $server             = false,
  $server_user        = 'root',
  $server_backupdir   = '/var/backups',
  $server_pubkey      = undef,
  $server_pubkey_type = 'rsa',
  $server_hostname    = undef
)
{


  class { 'borgbackup':
    repositories => $configurations
  }

  Sshkey <<| title == 'backup' |>>

  class { 'atticmatic':
    configurations => $configurations
  }

  file { '/root/.ssh':
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '0700'
  }

  file { '/root/.ssh/backup_rsa':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0400',
    content => $privkey
  }

  if $server {
    @@sshkey { 'backup':
      name => $server_hostname,
      key  => $::sshrsakey,
      type => 'rsa'
    }

    ssh_authorized_key { 'backup':
      key     => $server_pubkey,
      type    => $server_pubkey_type,
      options => "command=\"borg serve --restrict-to-path ${server_backupdir}\"",
      user    => $server_user
    }
  }

  Class['borgbackup'] -> Class['atticmatic']
}
