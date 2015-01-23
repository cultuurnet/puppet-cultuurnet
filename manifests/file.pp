# == Class: cultuurnet::file
#
class cultuurnet::file {
  create_resources(file, hiera_hash('files', {}))
}
