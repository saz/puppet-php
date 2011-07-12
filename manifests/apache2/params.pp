class php::apache2::params {
    include php::params

    case $operatingsystem {
        /(Ubuntu|Debian)/: {
            $package_name = "libapache2-mod-php5"
            $service_name = "apache2"
            $apache_ini = "${php::params::base_dir}apache2/php.ini"
        }
    }
}
