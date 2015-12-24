class cultuurnet::backup(
  $repositories       = { 'default' => { path => '/var/backups/borgbackup' } },
  $configurations     = { 'filesystem' => { source_directories => '/root', repository => '/var/backups/borgbackup' } },
  $server             = false,
  $server_user        = 'root',
  $server_backupdir   = '/var/backups',
  $server_pubkey      = undef,
  $server_pubkey_type = 'rsa',
  $server_hostname    = undef
)
{
  class { 'borgbackup':
    repositories => $repositories
  }

  Sshkey <<| title == 'backup' |>>

  class { 'atticmatic':
    configurations => $configurations
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
}
