class php::fpm::params {
    include php::params

    case $operatingsystem {
        /(Ubuntu|Debian)/: {
            $package_name = 'php5-fpm',
            $service_name = 'php5-fpm',
            $fpm_ini = '${php::params::base_dir}fpm/php.ini',
        }
    }
}
