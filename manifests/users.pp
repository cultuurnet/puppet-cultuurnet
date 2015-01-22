# == Class: cultuurnet::users
#
class cultuurnet::users {
 create_resources(file, hiera_hash('unix_user_dirs', {}))
 create_resources(user, hiera_hash('unix_users', {}))
}
