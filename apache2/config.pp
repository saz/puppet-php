class php::apache2::config {
    file { $php::apache2::params::apache_ini:
        owner   => root,
        group   => root,
        require => Class["php::apache2::install"],
        notify  => Class["php::apache2::service"],
        ensure  => file,
        source  => [
            "puppet:///files/hosts/$hostname/php/apache2_php.ini",
            "puppet:///files/hosts/$fqdn/php/apache2_php.ini",
            "puppet:///files/domains/$domain/php/apache2_php.ini",
            "puppet:///files/global/php/apache2_php.ini",
            undef,
        ],
    }
}
