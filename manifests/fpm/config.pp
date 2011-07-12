class php::fpm::config {
    file { $php::params::fpm_dir:
        owner   => root,
        group   => root,
        purge   => true,
        recurse => true,
        force   => true,
        require => Class["php::install"],
        ensure  => directory,
    }

    file { "${php::params::fpm_dir}conf.d":
        ensure => "../conf.d",
    }

    file { "${php::params::fpm_dir}pool.d":
        owner   => root,
        group   => root,
        purge   => true,
        recurse => true,
        force   => true,
        require => Class["php::fpm::install"],
        ensure  => directory,
    }

    file { $php::params::fpm_ini:
        owner   => root,
        group   => root,
        require => Class["php::fpm::install"],
        notify  => Class["php::fpm::service"],
        ensure  => file,
        content => $php::fpm::fpm_ini_content,
        source  => $php::fpm::fpm_ini_source,
    }

    file { $php::params::fpm_conf:
        owner   => root,
        group   => root,
        require => Class["php::fpm::install"],
        notify  => Class["php::fpm::service"],
        ensure  => file,
        content => $php::fpm::fpm_conf_content,
        source  => $php::fpm::fpm_conf_source,
    }
}
