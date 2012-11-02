class php::apache2::config {
  file { $php::params::apache_dir:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    purge   => true,
    recurse => true,
    force   => true,
    require => Class['php::apache2::install'],
    notify  => Service[$php::params::apache_service_name],
  }

  file { "${php::params::apache_dir}conf.d":
    ensure  => link,
    target  => '../conf.d',
    force   => true,
    require => File[$php::params::apache_dir],
    notify  => Service[$php::params::apache_service_name],
  }

  file { $php::params::apache_ini:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    require => Class['php::apache2::install'],
    notify  => Service[$php::params::apache_service_name],
    content => $php::apache2::apache2_ini_content,
    source  => $php::apache2::apache2_ini_source,
  }
}
