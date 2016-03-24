# == Class graphite_web::params
#
#
class graphite_web::params {
  $apache_service_name       = 'httpd'
  $gw_django_version         = present
  $gw_django_pkg             = 'python-django'
  $gw_django_tagging_version = present
  $gw_django_tagging_pkg     = 'python-django-tagging'
  $gw_graphite_web_version   = present
  $gw_graphite_web_pkg       = 'graphite-web'
  $gw_mod_wsgi_version       = present
  $gw_mod_wsgi_pkg           = 'mod_wsgi'
  $gw_pycairo_version        = present
  $gw_pycairo_pkg            = 'pycairo'
  $gw_pytz_version           = present
  $gw_pytz_pkg               = 'pytz'
  $gw_webapp_dir             = '/etc/graphite-web'
  $manage_packages           = true
}
