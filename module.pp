define php::module($require = undef) {
    include php

    if defined(Class["php::apache2"]) {
        $notify += Class["php::apache2::service"]
    }

    if defined(Class["php::fpm"]) {
        $notify += Class["php::fpm::service"]
    }

    package { "php-${name}":
        name => $operatingsystem ? {
            /(Ubuntu|Debian)/ => "php5-${name}",
            default           => "php-${name}",
        },
        ensure  => present,
        notify  => $notify,
        require => $require,
    }

    file { "${name}.ini":
        path    => "${php::params::conf_dir}${name}.ini",
        mode    => 644,
        owner   => root,
        group   => root,
        ensure  => present,
        require => Class["php::config"],
        source  => [
            "puppet:///files/hosts/${hostname}/php/conf.d/${name}.ini",
            "puppet:///files/hosts/${fqdn}/php/conf.d/${name}.ini",
            "puppet:///files/domains/${domain}/php/conf.d/${name}.ini",
            "puppet:///files/global/php/conf.d/${name}.ini",
            undef,
        ],
    }
}
