define php::module($ensure = present, $source = undef, $content = undef, $require = undef, $notify = undef, $package_prefix = 'php5-') {
    include php

    $file_name = "${name}.ini"

    if $require {
      $real_require = [ Class['php::install'], $require, ]
    } else {
      $real_require = Class['php::install']
    }

    package { "php-${name}":
        name => "${package_prefix}${name}",
        ensure  => $ensure,
        require => $real_require,
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
