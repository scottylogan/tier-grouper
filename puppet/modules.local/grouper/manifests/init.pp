# == Class: grouper
#
# Full description of class base here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'base':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class grouper (
  # default values are in grouper/data
  $version,
  $base_dir,
  $api_dir,
  $ui_dir,
  $ws_dir,
  $client_dir,
  $psp_dir,
  $db_dialect,
  $db_class,
  $db_type,
  $db_host,
  $db_port,
  $db_name,
  $db_user,
  $db_pass,
  $tomcat_group,
  $tomcat_user,
  $tomcat_context_dir
) {

  $db_url = "jdbc:${db_type}://${db_host}:${db_port}/${db_name}"

  file { "${api_dir}/conf/grouper.hibernate.properties":
    ensure  => file,
    owner   => 'grouper',
    group   => 'grouper',
    mode    => '0640',
    content => template("${module_name}/grouper.hibernate.properties.erb"),
  }

  file { "${api_dir}/conf/grouper.properties":
    ensure  => file,
    owner   => 'grouper',
    group   => 'grouper',
    mode    => '0640',
    content => template("${module_name}/grouper.properties.erb"),
  }
  
  group { $tomcat_group:
    ensure => present,
    system => true,
  }

  user { $tomcat_user:
    ensure  => present,
    groups  => [ $tomcat_group, 'grouper' ],
    require => [ Group[$tomcat_group] ],
  }

  file { "${tomcat_context_dir}/grouper.xml":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/grouper-context.xml.erb"),
  }

  file { "${tomcat_context_dir}/grouper-ws.xml":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/grouper-ws-context.xml.erb"),
  }

}
