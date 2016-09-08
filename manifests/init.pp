# == Class: sc_mysql
#
# Module to install MySQL the ScaleCommerce way.
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*use_supervisor*]
#   can be true or false, default is true.
#   determines if start script should be used with supervisor
#
# === Examples
#
#  class { 'dummy':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# ScaleCommerce <info@scale.sc>
#
# === Copyright
#
# Copyright 2016 ScaleCommerce GmbH
#
class sc_mysql(
  $use_supervisor = true,
) {

  if $use_supervisor {

    class {'::sc_mysql::supervisor':}

  }

  include mysql::server
  Package <| |> -> Class['Mysql::Server']
  create_resources('::mysql::db', hiera_hash('mysql::databases', {}))
}
