class sc_mysql::supervisor(){

  include sc_supervisor

  file { '/etc/init.d/mysql':
    ensure => link,
    target => "${sc_supervisor::init_path}/supervisor-init-wrapper",
  }

  file { "${supervisord::config_include}/mysql.conf":
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/mysql.supervisor.conf.erb"),
    notify  => Class[supervisord::reload],
  }

  file { "${supervisord::config_include}/mysql-backup-instance.conf":
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/mysql-backup-instance.supervisor.conf.erb"),
    notify  => Class[supervisord::reload],
  }
}