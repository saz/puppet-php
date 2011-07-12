define php::extra($source = undef, $content = undef, $require = undef) {
    # Puppet will bail out if both source and content is set,
    # hence we don't have to deal with it.

    file { "${name}":
        path    => "${php::params::extra_dir}${name}.ini",
        mode    => 644,
        owner   => root,
        group   => root,
        ensure  => present,
        require => [
            Class["php::config"],
            $require,
        ],
        notify  => $php::params::service_notify,
        source  => $source,
        content => $content,
    }
}
