class php::fpm::service {
    service { $php::fpm::params::service_name:
        ensure     => running,
        hasstatus  => true,
        hasrestart => true,
        enable     => true,
        require    => Class["php::fpm::install"],
    }
}
