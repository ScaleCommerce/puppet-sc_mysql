class sc_mysql::supervisor(){

  include supervisord

  file { '/etc/init.d/mysql':
    ensure => link,
    target => '/etc/supervisor.init/supervisor-init-wrapper',
  }

  file { "${supervisord::config_include}/mysql.conf":
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/mysql.supervisor.conf.erb"),
    notify  => Class[supervisord::reload],
  }
}