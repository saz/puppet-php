define php::module($source = undef, $content = undef, $require = undef) {
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
        content => $content,
        source  => $source ? {
            undef   => undef,
            default => "${source}${name}.ini",
        },
        require => [
            Class["php::config"],
            Package["php-${name}"],
        ],
    }
}
