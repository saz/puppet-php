class php::fpm($fpm_ini_content = undef, $fpm_ini_source = undef, $fpm_conf_content = undef, $fpm_conf_source = undef) {
    include php::params, php::fpm::install, php::fpm::config, php::fpm::service
}
