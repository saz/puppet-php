define php::module($ensure = present, $source = undef, $content = undef, $require = undef, $notify = undef) {
    include php

    $file_name = "${name}.ini"

    package { "php-${name}":
        name => $operatingsystem ? {
            /(Ubuntu|Debian)/ => "php5-${name}",
            default           => "php-${name}",
        },
        ensure  => $ensure,
        require => $require,
    }

    file { $file_name:
        path    => "${php::params::conf_dir}${file_name}",
        mode    => 644,
        owner   => root,
        group   => root,
        ensure  => $ensure,
        notify  => $notify,
        source  => $source ? {
            undef   => undef,
            true    => [
                "puppet:///files/${fqdn}/etc/php5/conf.d/${file_name}",
                "puppet:///files/${hostgroup}/etc/php5/conf.d/${file_name}",
                "puppet:///files/${domain}/etc/php5/conf.d/${file_name}",
                "puppet:///files/global/etc/php5/conf.d/${file_name}",
            ], 
            default => "${source}${file_name}",
        },
        content => $content ? {
            undef   => undef,
            default => template("${content}${file_name}.erb"),
        },
        require => [
            Class["php"],
            Package["php-${name}"],
        ],
    }
}
