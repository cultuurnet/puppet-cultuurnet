# == Class: cultuurnet::php
#
class cultuurnet::php {

  case $::environment {
  'testing':
    {
      include php::globals
      include php

      Class['php::globals'] -> Class['php']
    }
  'production':
    {
      include php
      include php::extension::curl
      include php::extension::gd
      include php::extension::intl
      include php::extension::mysql
      include php::extension::tidy
    }
  }
}
