class cultuurnet::backup(
  $configuration      = { 'filesystem' => { source_directories => '/root', encryption => 'none', repository => '/var/backups/borgbackup' } },
  $privkey            = '',
  $server             = false,
  $server_user        = 'root',
  $server_backupdir   = '/var/backups',
  $server_pubkey      = undef,
  $server_pubkey_type = 'rsa',
  $server_hostname    = undef
)
{
  # TODO: revisit when Puppet 4.0 is installed. This hash manipulation is
  # extremely ugly. Iteration will hopefully clean this.
  $repos = parsejson(regsubst(inline_template("<%= ${configuration}.each_pair { |key, value| value.keep_if { |k, v| k == 'repository' or k == 'encryption' or k == 'passphrase' or k == 'borg_rsh' } } %>"), '=>', ':', 'G'))

  class { 'borgbackup':
    repositories => $repos
  }

  Sshkey <<| title == 'backup' |>>

  $configs = parsejson(regsubst(inline_template("<%= ${configuration}.each_pair { |key, value| value.delete_if { |k, v| k == 'encryption' } } %>"), '=>', ':', 'G'))

  class { 'atticmatic':
    configurations => $configs
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

    user { $server_user:
      ensure     => 'present',
      home       => $server_backupdir,
      managehome => true
    }

    User[$server_user] -> Ssh_authorized_key['backup']
  }

  Class['borgbackup'] -> Class['atticmatic']
}
