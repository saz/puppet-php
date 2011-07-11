class php::install {
    package { $php::params::package_name:
        ensure => present,
    }
}
