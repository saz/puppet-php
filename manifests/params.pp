class php::params {
    case $operatingsystem {
        /(Ubuntu|Debian)/: {
            $package_name = "php5-cli"
            $base_dir = "/etc/php5/"
            $cli_dir = "${base_dir}cli/"
            $cli_ini = "${cli_dir}php.ini"
            $cli_package_name = "php5-cli"
            $extra_dir = "${base_dir}extra/"
            $conf_dir = "${base_dir}conf.d/"
            $fpm_dir = "${base_dir}fpm/"
            $fpm_ini = "${fpm_dir}php.ini"
            $fpm_package_name = "php5-fpm"
            $fpm_conf = "${fpm_dir}php-fpm.conf"
            $apache_dir = "${base_dir}apache2/"
            $apache_ini = "${apache_dir}php.ini"
            $apache_package_name = "libapache2-mod-php5"
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
