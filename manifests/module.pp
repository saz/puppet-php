define php::module(
  $ensure = present,
  $package_prefix = 'php5-',
  $source = undef,
  $content = undef,
  $require = undef,
  $notify = undef
) {
  include php

  $file_name = "${name}.ini"

  if $require {
    $real_require = [
      Class['php::install'],
      $require,
    ]
  } else {
    $real_require = Class['php::install']
  }

  package { "php-${name}":
    ensure  => $ensure,
    name    => "${package_prefix}${name}",
    require => $real_require,
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

  $content_real = $content ? {
    undef   => undef,
    default => template("${content}${file_name}.erb"),
  }

  file { $file_name:
    ensure  => $ensure,
    path    => "${php::params::conf_dir}${file_name}",
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    notify  => $notify,
    source  => $source_real,
    content => $content_real,
    require => [
      Class['php'],
      Package["php-${name}"],
    ],
  }
}
