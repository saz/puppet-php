define php::conf($source = undef, $content = undef, $require = undef) {
    # Puppet will bail out if both source and content is set,
    # hence we don't have to deal with it.

    file { "${name}":
        path    => "${php::params::conf_dir}${name}.ini",
        mode    => 644,
        owner   => root,
        group   => root,
        ensure  => present,
        require => [
            Class["php::config"],
            $require,
        ],
        source  => $source ? {
            undef   => undef,
            default => "${source}${name}.ini",
        },
        content => $content ? {
            undef   => undef,
            default => template("${content}${name}.ini.erb"),
        },
    }

    # Subscribe to services
    File[${name}] ~> Class["php::fpm::service"]
    File[${name}] ~> Service["apache"]
}
