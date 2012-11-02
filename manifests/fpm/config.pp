class php::fpm::config {
  file { $php::params::fpm_dir:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    purge   => true,
    recurse => true,
    force   => true,
    require => Class['php::fpm::install'],
    notify  => Class['php::fpm::service'],
  }

  file { "${php::params::fpm_dir}conf.d":
    ensure  => link,
    target  => '../conf.d',
    force   => true,
    require => File[$php::params::fpm_dir],
    notify  => Class['php::fpm::service'],
  }

  file { "${php::params::fpm_dir}pool.d":
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    purge   => true,
    recurse => true,
    force   => true,
    require => Class['php::fpm::install'],
    notify  => Class['php::fpm::service'],
  }

  file { $php::params::fpm_ini:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    content => $php::fpm::fpm_ini_content,
    source  => $php::fpm::fpm_ini_source,
    require => Class['php::fpm::install'],
    notify  => Class['php::fpm::service'],
  }

  file { $php::params::fpm_conf:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    content => $php::fpm::fpm_conf_content,
    source  => $php::fpm::fpm_conf_source,
    require => Class['php::fpm::install'],
    notify  => Class['php::fpm::service'],
  }
}
