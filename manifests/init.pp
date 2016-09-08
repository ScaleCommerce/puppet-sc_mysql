# == Class: dummy
#
# Full description of class dummy here.
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
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2016 ScaleCommerce GmbH
#
class sc_mysql(
  $use_supervisor = true,
) {

  if $use_supervisor {
    # supervisor
    file { '/etc/init.d/mysql':
      ensure => link,
      target => '/etc/supervisor.init/supervisor-init-wrapper',
    }

    file { '/etc/supervisor.d/mysql.conf':
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template("${module_name}/mysql.supervisor.conf.erb"),
      notify  => Exec['supervisorctl_mysql_update'],
    }->

    exec { 'supervisorctl_mysql_update':
      command     => '/usr/bin/supervisorctl update',
      refreshonly => true,
    }
  }

  include mysql::server
  Package <| |> -> Class['Mysql::Server']
  create_resources('::mysql::db', hiera_hash('mysql::databases', {}))
}
