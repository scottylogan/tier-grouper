class shibsp::RedHat {
  file { '/etc/yum.repos.d/security-shibboleth.repo':
    ensure => file,
    source => "http://download.opensuse.org/repositories/security://shibboleth/${::operatingsystem}_${::operatingsystemmajrelease}/security:shibboleth.repo",
  }
  ->
  package { 'shibboleth.x86_64':
    ensure  => 'latest',
  }
}
