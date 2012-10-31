class php::fpm::install {
  package { $php::params::fpm_package_name:
    ensure  => present,
    require => Class['php'],
  }
}
