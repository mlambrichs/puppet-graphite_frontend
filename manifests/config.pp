# == Class graphite_web::config
#
#
class graphite_web::config {

  file { "${graphite_web::gw_webapp_dir}/local_settings.py":
    ensure  => file,
    content => template('graphite_web/etc/graphite-web/local_settings.py.erb'),
    group   => $graphite_web::gw_group,
    mode    => '0644',
    owner   => $graphite_web::gw_user,
    require => Package[$graphite_web::gw_graphite_web_pkg]
  }

  file { "${graphite_web::gw_webapp_dir}/graphite.wsgi":
    ensure  => file,
    content => template('graphite_web/etc/graphite-web/graphite.wsgi.erb'),
    group   => $graphite_web::gw_group,
    mode    => '0644',
    owner   => $graphite_web::gw_user,
    require => Package[$graphite_web::gw_graphite_web_pkg]
  }

  file { "${graphite_web::gw_webapp_dir}/dashboard.conf":
    ensure  => file,
    content => template('graphite_web/etc/graphite-web/dashboard.conf.erb'),
    group   => $graphite_web::gw_group,
    mode    => '0644',
    owner   => $graphite_web::gw_user,
    require => Package[$graphite_web::gw_graphite_web_pkg]
  }

  exec { 'init django db':
    command     => '/bin/python ./manage.py syncdb --noinput',
    cwd         => '/usr/lib/python2.7/site-packages/graphite',
    refreshonly => true,
    require     => File["${graphite_web::gw_webapp_dir}/local_settings.py"]
  }

  include apache

  $vhost_defaults = {
    vhost_name     => '*',
    port           => 80,
    error_log      => true,
    ssl            => false,
    ssl_protocol   => ['All', '-SSLv2', '-SSLv3'],
    ssl_cipher     => 'AES128+EECDH:AES128+EDH',
  }

  create_resources( 'apache::vhost', $graphite_web::vhosts, $vhost_defaults )

  class { 'graphite_web::config::auth': }

}
