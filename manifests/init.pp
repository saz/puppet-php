class php(
  $cli_ini_content = undef,
  $cli_ini_source = undef
) {
  include php::params, php::install, php::config
}
