class php::apache2::config {
    file { $php::params::apache_dir:
        owner   => root,
        group   => root,
        purge   => true,
        recurse => true,
        force   => true,
        require => Package["apache"],
        notify  => Service["apache"],
        ensure  => directory,
    }

    file { "${php::params::apache_dir}conf.d":
        ensure  => "../conf.d",
        require => File[$php::params::apache_dir],
        notify  => Service["apache"],
    }

    file { $php::apache2::params::apache_ini:
        owner   => root,
        group   => root,
        require => Package["apache"],
        notify  => Service["apache"],
        content => $php::apache2::apache2_ini_content,
        source  => $php::apache2::apache2_ini_source,
        ensure  => file,
    }
}
