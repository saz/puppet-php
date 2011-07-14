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
        content => $php::cli_ini_content, 
        source  => $php::cli_ini_source,
    }

    file { $php::params::cli_dir:
        owner   => root,
        group   => root,
        purge   => true,
        recurse => true,
        force   => true,
        require => Class["php::install"],
        ensure  => directory,
    }

    file { "${php::params::cli_dir}conf.d":
        ensure => "../conf.d",
    }
}
