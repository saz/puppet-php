class php::apache2::service {
    service { $php::apache2::params::service_name:
        ensure     => running,
        hasstatus  => true,
        hasrestart => true,
        enable     => true,
        require    => Class["php::apache2::install"],
    }
}
