define php::extra (
  $ensure = present,
  $source = undef,
  $content = undef,
  $require = undef,
  $notify = undef
) {
  # Puppet will bail out if both source and content is set,
  # hence we don't have to deal with it.

  $file_name = "${name}.ini"

  $source_real = $source ? {
    undef   => undef,
    true    => [
      "puppet:///files/${::fqdn}/etc/php5/extra/${file_name}",
      "puppet:///files/${::hostgroup}/etc/php5/extra/${file_name}",
      "puppet:///files/${::domain}/etc/php5/extra/${file_name}",
      "puppet:///files/global/etc/php5/extra/${file_name}",
    ],
    default => $source,
  }

  $content_real = $content ? {
    undef   => undef,
    default => template("${content}${file_name}.erb"),
  }

  file { $file_name:
    ensure  => $ensure,
    path    => "${php::params::extra_dir}${file_name}",
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    notify  => $notify,
    source  => $source_real,
    content => $content_real,
    require => [
      Class['php'],
      $require,
    ],
  }
}
