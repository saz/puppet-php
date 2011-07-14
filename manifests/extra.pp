define php::extra($source = undef, $content = undef, $require = undef, $notify = undef) {
    # Puppet will bail out if both source and content is set,
    # hence we don't have to deal with it.

    file { "${name}":
        path    => "${php::params::extra_dir}${name}.ini",
        mode    => 644,
        owner   => root,
        group   => root,
        ensure  => present,
        notify  => $notify,
        require => [
            Class["php::config"],
            $require,
        ],
        source  => $source,
        content => $content,
    }

    # Subscribe to services
    File[$name] ~> Class["php::fpm::service"]
    File[$name] ~> Service["apache"]
}
