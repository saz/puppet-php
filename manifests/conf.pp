define php::conf(
  $ensure = present,
  $source = undef,
  $content = undef,
  $require = undef,
  $notify = undef
) {
  include php

  $file_name = "${name}.ini"

  $require_real = $require ? {
    undef   => Class['php'],
    default => [
      Class['php'],
      $require,
    ],
  }

  $content_real = $content ? {
    undef   => undef,
    default => template("${content}${file_name}.erb"),
  }

  $source_real = $source ? {
    undef   => undef,
    true    => [
      "puppet:///files/${::fqdn}/etc/php5/conf.d/${file_name}",
      "puppet:///files/${::hostgroup}/etc/php5/conf.d/${file_name}",
      "puppet:///files/${::domain}/etc/php5/conf.d/${file_name}",
      "puppet:///files/global/etc/php5/conf.d/${file_name}",
    ],
    default => $source,
  }

  # Puppet will bail out if both source and content is set,
  # hence we don't have to deal with it.
  file { $file_name:
    ensure  => $ensure,
    path    => "${php::params::conf_dir}${file_name}",
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    notify  => $notify,
    require => $require_real,
    source  => $source_real,
    content => $content_real,
  }
}
