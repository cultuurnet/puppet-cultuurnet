# == Class: cultuurnet::users
#
class cultuurnet::users {
 create_resources(user, hiera_hash('unix_users', {}))
}
