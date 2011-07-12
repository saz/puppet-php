define php::fpm::pool($source = undef, $content = undef, $require = undef) {
    include php::fpm

    file { "${name}.conf":
        path    => "${php::params::fpm_pool_dir}${name}.conf",
        owner   => root,
        group   => root,
        ensure  => file,
        source  => $source ? {
            undef   => undef,
            default => "${source}${name}.conf",
        },
        content => $content ? {
            undef   => undef,
            default => template("${source}${name}.conf.erb"),
        },
        require => [
            Class["php::fpm::install"],
            $require,
        ],
        before  => Class["php::fpm::service"],
        notify  => Class["php::fpm::service"],
    }
}
