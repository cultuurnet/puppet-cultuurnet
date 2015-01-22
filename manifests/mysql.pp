# == Class: cultuurnet::mysql
#
class cultuurnet::mysql {
  create_resources(mysql::server::databases, hiera_hash('mysql::server::databases', {}))
  create_resources(mysql::server::grants, hiera_hash('mysql::server::grants', {}))
  create_resources(mysql::server::users, hiera_hash('mysql::server::users', {}))
}
