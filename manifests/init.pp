# == Class: sc_mysql
#
# Wrapper module for puppetlabs-mysql to install MySQL the ScaleCommerce way.
#
# === Variables
#
# [*use_supervisor*]
#   can be true or false, default is true.
#   determines if start script should be used with supervisor
#
# [*databases*]
#   array of databases in short form
#
# === Examples
#
#  class { 'sc_mysql':
#    databases => [ 
#      database1_name => {
#        user => 'username',
#        password => 'password',
#        host => 'host',
#        ...
#      }, 
#      database2_name => {
#        ...
#      }
#    ],
#  }
#
# hiera example:
# sc_mysql::databases:
#   database1_name:
#     user:     'user'
#     password: 'password'
#     host:     'host'
#     grant:    ['All']
#     charset:  'utf8'
#     collate:  'utf8_general_ci'
#
# === Authors
#
# Joscha Krug <jk@scale.sc>
# Andreas Ziethen <az@scale.sc>
#
# === Copyright
#
# Copyright 2016 ScaleCommerce GmbH
#
class sc_mysql(
  $use_supervisor = true,
  $databases = undef,
) {

  if $use_supervisor {

    class {'::sc_mysql::supervisor':}

  }

  include mysql::server
  Package <| |> -> Class['Mysql::Server']
  create_resources('::mysql::db',$databases)
}
