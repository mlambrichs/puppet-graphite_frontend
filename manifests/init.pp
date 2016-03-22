# == Class: graphite_web
#
# Installs, configures and manages graphite-web service.
#
# === Parameters
#
# [*gw_django_version*]
#
# [*gw_django_pkg*]
#
# [*gw_django_tagging_version*]
#
# [*gw_django_tagging_pkg*]
#
# [*gw_graphite_web_pkg*]
#   Specifies the name of the graphite web package.
#   Default: 'graphite-web'
#
# [*gw_graphite_web_version*]
#   Specifies the version of the graphite web package.
#   Default: present
#
# [*gw_mod_wsgi_version*]
#
# [*gw_mod_wsgi_pkg*]
#
# [*gw_pycairo_version*]
#
# [*gw_pycairo_pkg*]
#
# [*gw_pytz_version*]
#
# [*gw_pytz_pkg*]
#
# [*manage_packages*]
#   Specifies if this module should or should not install packages.
#   Type: Boolean
#   Default: true
#
# === Examples
#
#  class { 'graphite_web': }
#
#
# === Authors
#
# Marc Lambrichs <marc.lambrichs@gmail.com>
#
# === Copyright
#
# Copyright 2016 Marc Lambrichs
#
class graphite_web (

  $gw_django_version         = $graphite_web::params::gw_django_version,
  $gw_django_pkg             = $graphite_web::params::gw_django_pkg,
  $gw_django_tagging_version = $graphite_web::params::gw_django_tagging_version,
  $gw_django_tagging_pkg     = $graphite_web::params::gw_django_tagging_pkg,
  $gw_graphite_web_version   = $graphite_web::params::gw_graphite_web_version,
  $gw_graphite_web_pkg       = $graphite_web::params::gw_graphite_web_pkg,
  $gw_mod_wsgi_version       = $graphite_web::params::gw_mod_wsgi_version,
  $gw_mod_wsgi_pkg           = $graphite_web::params::gw_mod_wsgi_pkg,
  $gw_pycairo_version        = $graphite_web::params::gw_pycairo_version,
  $gw_pycairo_pkg            = $graphite_web::params::gw_pycairo_pkg,
  $gw_pytz_version           = $graphite_web::params::gw_pytz_version,
  $gw_pytz_pkg               = $graphite_web::params::gw_pytz_pkg,
  $manage_packages           = $graphite_web::params::manage_packages,
) inherits graphite_web::params {

  validate_bool( $manage_packages )

  validate_re( $gw_django_version, '^(present|\d+\.\d+\.\d+)$' )
  validate_re( $gw_django_tagging_version, '^(present|\d+\.\d+\.\d+)$' )
  validate_re( $gw_graphite_web_version, '^(present|\d+\.\d+\.\d+)$' )
  validate_re( $gw_mod_wsgi_version, '^(present|\d+\.\d+\.\d+)$' )
  validate_re( $gw_pycairo_version, '^(present|\d+\.\d+\.\d+)$' )
  validate_re( $gw_pytz_version, '^(present|\d+\.\d+\.\d+)$' )

  validate_string(
    $gw_django_pkg,
    $gw_django_tagging_pkg,
    $gw_graphite_web_pkg,
    $gw_mod_wsgi_pkg,
    $gw_pycairo_pkg,
    $gw_pytz_pkg,
  )

  anchor { 'graphite_web::begin': } ->
  class { 'graphite_web::install': } ->
  class { 'graphite_web::config': } ~>
  class { 'graphite_web::service': } ->
  anchor { 'graphite_web::end': }

}
