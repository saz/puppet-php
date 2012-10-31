class php::apache2::install {
  package { $php::params::apache_package_name:
    ensure  => present,
    notify  => Service[$php::params::apache_service_name],
  }
}
