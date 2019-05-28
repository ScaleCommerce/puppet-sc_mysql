class sc_mysql::supervisor(
  $supervisor_exec_path   = '/usr/local/bin',
){

  include sc_supervisor

  file { '/etc/init.d/mysql':
    ensure => absent,
    require => Supervisord::Program['mysql'],
  }

  supervisord::program { 'mysql':
    command     => '/bin/bash -c "mkdir -p /var/run/mysqld && chown mysql /var/run/mysqld && exec /usr/sbin/mysqld --basedir=/usr --datadir=/var/lib/mysql --plugin-dir=/usr/lib/mysql/plugin --user=mysql --skip-log-error --socket=/var/run/mysqld/mysqld.sock --port=3306"',
    autostart   => true,
    autorestart => true,
    require     => Class['Mysql::Server::Config'],
    before      => Service['mysql'],
  }

  # override default service provider
  Service <| title == "mysql"|> {
    provider => supervisor,
  }

}
