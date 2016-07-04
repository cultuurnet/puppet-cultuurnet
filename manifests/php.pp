# == Class: cultuurnet::php
#
class cultuurnet::php {

  include ::php::globals
  include ::php

  Class['php::globals'] -> Class['php']
}
