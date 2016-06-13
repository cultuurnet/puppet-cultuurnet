# == Class: cultuurnet::php
#
class cultuurnet::php {

  case $::environment {
  'testing':
    {
      class { 'php::globals': }
      class { 'php':
        manage_repos => false,
        fpm          => false,
        dev          => false,
        composer     => false,
        pear         => false,
        extensions   => {
          curl  => { },
          gd    => { },
          intl  => { },
          mysql => { },
          tidy  => { }
        }
      }
    }
  'production':
    {
      class { 'php': }
      class { 'php::extension::curl': }
      class { 'php::extension::gd': }
      class { 'php::extension::intl': }
      class { 'php::extension::mysql': }
      class { 'php::extension::tidy': }
    }
  }
}
