class php::apache2($apache2_ini_content = undef, $apache2_ini_source = undef) {
    require apache
    include php, php::apache2::install, php::apache2::config

    Class["php::config"] ~> Service["apache"]
}
