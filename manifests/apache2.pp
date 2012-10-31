class php::apache2 (
  $apache2_ini_content = undef,
  $apache2_ini_source = undef
) inherits php::params {
  require apache

  include php
  include php::apache2::install
  include php::apache2::config

  Class['php::config'] ~> Service[$php::params::apache_service_name]
}
