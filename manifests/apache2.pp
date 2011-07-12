class php::apache2 {
    require apache

    include php::apache2::params, php::apache2::install, php::apache2::config
}
