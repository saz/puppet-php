define php::fpm::pool(
  $pool_prefix = undef,
  $user = 'www-data',
  $group = 'www-data',
  $listen = '127.0.0.1:9000',
  $listen_backlog = undef,
  $listen_type = 'tcp',
  $socket_owner = undef,
  $socket_group = undef,
  $socket_mode = undef,
  $allowed_clients = undef,
  $pm = 'dynamic',
  $pm_max_children = 5,
  $pm_start_servers = 2,
  $pm_min_spare_servers = 1,
  $pm_max_spare_servers = 3,
  $pm_process_idle_timeout = '10s',
  $pm_max_requests = 0,
  $pm_status_path = undef,
  $ping_path = undef,
  $ping_response = undef,
  $access_log = undef,
  $access_log_format = undef,
  $slowlog = undef,
  $slowlog_timeout = 0,
  $terminate_timeout = 0,
  $chroot = undef,
  $php_settings = undef,
  $env_settings = undef
) {
  include php::fpm

  file { "${name}.conf":
    ensure  => file,
    path    => "${php::params::fpm_pool_dir}${name}.conf",
    owner   => 'root',
    group   => 'root',
    content => template('php/fpm-pool.conf.erb'),
    require => Class['php::fpm::install'],
    before  => Class['php::fpm::service'],
    notify  => Class['php::fpm::service'],
  }
}
