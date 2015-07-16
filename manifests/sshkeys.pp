# == Class: cultuurnet::sshkeys
#
class cultuurnet::sshkeys {
  create_resources(ssh_authorized_key, hiera_hash('ssh_keys', {}))
}
