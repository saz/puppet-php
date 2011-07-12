class php::fpm::install {
    package { $php::fpm::params::package_name:
        ensure => present,
    }
}
