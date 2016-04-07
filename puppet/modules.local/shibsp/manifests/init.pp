# configure a Simple Shibboleth SP

class shibsp (
  # defaults for the following params are in data/common.yaml,
  $entity_id,
  $idp_entity_id,
  $idp_metadata_url,
  $base_dir,
  $contact,
){

  $os_class = inline_template("shibsp::<%= @osfamily.downcase %>")
  include $os_class

  file { '/etc/shibboleth/shibboleth2.xml':
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => template("${module_name}/shibboleth2.xml.erb"),
  }

  file { '/etc/shibboleth/attribute-map.xml':
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    source  => "puppet:///modules/${module_name}/attribute-map.xml",
  }

}

