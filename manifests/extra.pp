define php::extra($ensure = present, $source = undef, $content = undef, $require = undef, $notify = undef) {
    # Puppet will bail out if both source and content is set,
    # hence we don't have to deal with it.

    $file_name = "${name}.ini"

    file { $file_name:
        path    => "${php::params::extra_dir}${file_name}",
        mode    => 644,
        owner   => root,
        group   => root,
        ensure  => $ensure,
        notify  => $notify,
        require => [
            Class["php"],
            $require,
        ],
        source  => $source ? {
            undef   => undef,
            true    => [
                "puppet:///files/${fqdn}/etc/php5/extra/${file_name}",
                "puppet:///files/${hostgroup}/etc/php5/extra/${file_name}",
                "puppet:///files/${domain}/etc/php5/extra/${file_name}",
                "puppet:///files/global/etc/php5/extra/${file_name}",
            ],
            default => "${source}${file_name}",
        },
        content => $content ? {
            undef   => undef,
            default => template("${content}${file_name}.erb"),
        },
    }
}
