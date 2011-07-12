class php::params {
    case $operatingsystem {
        /(Ubuntu|Debian)/: {
            $package_name = 'php5-cli',
            $base_dir = '/etc/php5/',
            $cli_ini = '${base_dir}cli/php.ini',
            $extra_dir = '${base_dir}extra',
            $conf_dir = '${base_dir}conf.d',
        }
    }
}
