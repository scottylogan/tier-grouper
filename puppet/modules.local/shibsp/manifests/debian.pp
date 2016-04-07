class shibsp::Debian {
  package { 'libapache2-mod-shib2':
    ensure  => 'latest',
  }
}