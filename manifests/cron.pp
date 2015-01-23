# == Class: cultuurnet::cron
#
class cultuurnet::cron {
  create_resources(cron, hiera_hash('cronjobs', {}))
}
