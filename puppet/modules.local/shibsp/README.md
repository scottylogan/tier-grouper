# Shibboleth SP Configuration

This puppet module creates a very simple Shibboleth configuration
for Stanford SPs.  To configure a node to authenticate against
Stanford's production IdP, and using the default webmaster@fqdn
contact email, use this:

    node webapp {
      class { 'shibboleth_sp': }
    }

To customize the supportContact email address, use the contact
parameter:

    node webapp {
      class { 'shibboleth_sp':
        contact => 'admin@webapp.stanford.edu',
      }
    }

You can also choose a different IdP - set the IdP parameter to 'dev'
for idp-dev.stanford.edu, or 'itlab' for idp.itlab.stanford.edu:

    node default {
      class { 'shibboleth_sp':
        idp     => 'itlab',
        contact => 'admin@itlab.stanford.edu',
      }
    }



