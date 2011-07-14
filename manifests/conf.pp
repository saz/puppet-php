define php::conf($source = undef, $content = undef, $require = undef, $notify = undef) {
    include php

    $file_name = "${name}.ini"

    # Puppet will bail out if both source and content is set,
    # hence we don't have to deal with it.
    file { $file_name:
        path    => "${php::params::conf_dir}${file_name}",
        mode    => 644,
        owner   => root,
        group   => root,
        ensure  => present,
        notify  => $notify,
        require => [
            Class["php::config"],
            $require,
        ],
        source  => $source ? {
            undef   => undef,
            default => "${source}${file_name}",
        },
        content => $content ? {
            undef   => undef,
            default => template("${content}${file_name}.erb"),
        },
    }
}
