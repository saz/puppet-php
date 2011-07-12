define php::module($source = undef, $content = undef, $require = undef) {
    include php

    $file_name = "${name}.ini"

    package { "php-${name}":
        name => $operatingsystem ? {
            /(Ubuntu|Debian)/ => "php5-${name}",
            default           => "php-${name}",
        },
        ensure  => present,
        require => $require,
    }

    file { $file_name:
        path    => "${php::params::conf_dir}${file_name}",
        mode    => 644,
        owner   => root,
        group   => root,
        ensure  => present,
        source  => $source ? {
            undef   => undef,
            default => "${source}${file_name}",
        },
        content => $content ? {
            undef   => undef,
            default => template("${content}${file_name}.erb"),
        },
        require => [
            Class["php::config"],
            Package["php-${name}"],
        ],
    }

    # Subscribe to services
    File[$file_name] ~> Class["php::fpm::service"]
    File[$file_name] ~> Service["apache"]
}
