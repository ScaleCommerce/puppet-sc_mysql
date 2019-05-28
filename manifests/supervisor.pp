class sc_mysql::supervisor(
  $supervisor_exec_path   = '/usr/local/bin',
){

  include sc_supervisor

  file { '/etc/init.d/mysql':
    ensure => absent,
    require => Supervisord::Program['mysql'],
  }

  /**
   * to maintain backwards compatibility [1] and avoid uneccessary restarts of
   * mysql we fixate the content of the mysql supervisor config
   * - define supervisord::program
   * - remove old supervisorconfig file
   * - change content of the supervisord::program resource
   *
   * [1] https://gitlab.scale.sc/sc-puppet/puppet-sc_mysql/blob/022615369ea78fc6eac52f67abd76eb75b680630/manifests/supervisor.pp#L12-18
   */
  supervisord::program { 'mysql':
    command     => '/placeholder',
    require     => Class['Mysql::Server::Config'],
    before      => Service['mysql'],
  }

  file { "${supervisord::config_include}/mysql.conf":
    ensure  => absent,
    notify  => Class['supervisord::reload'],
  }

  File <| title == "/etc/supervisor.d/program_mysql.conf" |> {
    source  => "puppet:///modules/sc_mysql/supervisor.d/mysql.conf",
    content => undef,
  }

  # override default service provider
  Service <| title == "mysql"|> {
    provider => supervisor,
  }

}
