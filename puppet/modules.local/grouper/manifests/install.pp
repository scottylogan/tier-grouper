# == Class: grouper::install
#
# Puppet class to install Grouper using the grouperInstaller
#
# === Parameters
#
# Parameter values should be defined in hiera
#
# [version]
#   The version of grouper to install
#
# [jdk_name]
#   The name of the JDK package to install
#
# [java_home]
#   The value of $JAVA_HOME to use with the JDK
#
# [tomcat_group]
#   The name of the tomcat group
#
# [tomcat_user]
#   The name of tomcat user
#
# [tomcat_context_dir]
#   The path of the directory containing Tomcat
#   context definitions
#
# === Examples
#
#  include grouper::install
#
# === Authors
#
# Scotty Logan <swl@stanford.edu>
#
# === Copyright
#
# Copyright 2016 ...
#
class grouper::install (
  $version,
  $base_dir,
  $jdk_name,
  $java_home,
) {
  package {
    [
      'dos2unix',
      $jdk_name,
    ]:
    ensure => latest,
  }

  group { 'grouper':
    ensure => present,
    system => true,
  }

  user { 'grouper':
    ensure     => present,
    comment    => 'Grouper User',
    gid        => 'grouper',
    home       => $base_dir,
    managehome => true,
    shell      => '/bin/bash',
    require    => Group['grouper'],
  }

  file { '/tmp/grouperInstaller.jar':
    ensure  => file,
    owner   => 'grouper',
    group   => 'grouper',
    mode    => '0600',
    source  => "http://software.internet2.edu/grouper/release/${version}/grouperInstaller.jar",
    require => User['grouper'],
  }

  file { '/tmp/grouper.installer.properties':
    ensure  => file,
    owner   => 'grouper',
    group   => 'grouper',
    mode    => '0600',
    require => User['grouper'],
    content => template("${module_name}/grouper.installer.properties.erb"),
  }

  exec { 'install grouper':
    cwd         => '/tmp',
    environment => [ "JAVA_HOME=${java_home}" ],
    command     => '/usr/bin/java -cp .:grouperInstaller.jar edu.internet2.middleware.grouperInstaller.GrouperInstaller',
    require     => [
      File['/tmp/grouperInstaller.jar'],
      File['/tmp/grouper.installer.properties'],
    ],
  }
  ->
  exec { 'cleanup':
    cwd         => '/opt/grouper',
    command     => '/bin/rm -rf *.tar *.tar.gz *_patch_[0-9]* apache-ant-* apache-tomcat-* hsqlDb*',
  }
}