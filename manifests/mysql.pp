# == Class: cultuurnet::mysql
#
class cultuurnet::mysql {
 create_resources(mysql::server::databases, hiera_hash('mysql::server::databases', {}))
}
