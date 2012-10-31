class php::fpm (
  $fpm_ini_content = undef,
  $fpm_ini_source = undef,
  $fpm_conf_content = undef,
  $fpm_conf_source = undef
) {
  include php
  include php::fpm::install
  include php::fpm::config
  include php::fpm::service

  Class['php::config'] ~> Class['php::fpm::service']
}
