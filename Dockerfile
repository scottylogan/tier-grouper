FROM tier/base
MAINTAINER Scotty Logan <swl@stanford.edu>

USER root
COPY puppet/modules/ /etc/puppetlabs/code/environments/production/modules/
COPY puppet/manifests/ /etc/puppetlabs/code/environments/production/manifests/

RUN . /etc/profile.d/puppet-agent.sh && \
  puppet apply -v /etc/puppetlabs/code/environments/production/manifests/grouper-install.pp

RUN . /etc/profile.d/puppet-agent.sh && \
  puppet apply -v /etc/puppetlabs/code/environments/production/manifests/grouper.pp

#COPY start.sh /start.sh
#CMD /start.sh
