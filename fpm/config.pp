class php::fpm::config {
    file { $php::fpm::params::fpm_ini:
        owner   => root,
        group   => root,
        require => Class["php::fpm::install"],
        notify  => Class["php::fpm::service"],
        ensure  => file,
        source  => [
            "puppet:///files/hosts/$hostname/php/fpm_php.ini",
            "puppet:///files/hosts/$fqdn/php/fpm_php.ini",
            "puppet:///files/domains/$domain/php/fpm_php.ini",
            "puppet:///files/global/php/fpm_php.ini",
            undef,
        ],
    }
}
