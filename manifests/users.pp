# == Class: cultuurnet::user
#
class cultuurnet::user {
 create_resources(file, hiera_hash('unix_user_dirs', {}))
 create_resources(user, hiera_hash('unix_users', {}))
}
