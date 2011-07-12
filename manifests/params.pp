class php::params {
    case $operatingsystem {
        /(Ubuntu|Debian)/: {
            $package_name = "php5-cli"
            $base_dir = "/etc/php5/"
            $cli_ini = "${base_dir}cli/php.ini"
            $cli_dir = "${base_dir}cli/"
            $extra_dir = "${base_dir}extra/"
            $conf_dir = "${base_dir}conf.d/"
        }
    }

    # Build list of services to notify
    if defined(Class["php::apache2"]) {
        $notify += Class["php::apache2::service"]
    }

    if defined(Class["php::fpm"]) {
        $notify += Class["php::fpm::service"]
    }

}
