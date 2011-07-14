class php::apache2::install {
    package { $php::apache2::params::package_name:
        ensure  => present,
        require => Package["apache"],
        notify  => Service["apache"],
    }
}
