class php::config {
    file { $php::params::extra_dir:
        owner   => root,
        group   => root,
        purge   => true,
        recurse => true,
        force   => true,
        require => Class["php::install"],
        ensure  => directory,
    }

    file { $php::params::conf_dir:
        owner   => root,
        group   => root,
        purge   => true,
        recurse => true,
        force   => true,
        require => Class["php::install"],
        ensure  => directory,
    }

    file { $php::params::cli_ini:
        owner   => root,
        group   => root,
        require => Class["php::install"],
        ensure  => file,
        source  => [
            "puppet:///files/hosts/${hostname}/php/cli_php.ini",
            "puppet:///files/hosts/${fqdn}/php/cli_php.ini",
            "puppet:///files/domains/${domain}/php/cli_php.ini",
            "puppet:///files/global/php/cli_php.ini",
            undef,
        ],
    }
}
