FROM tier/base
MAINTAINER Scotty Logan <swl@stanford.edu>

USER root
COPY Puppetfile /etc/puppetlabs/code
COPY *.pp /etc/puppetlabs/code/environments/production/manifests/

WORKDIR /etc/puppetlabs/code
RUN librarian-puppet install --verbose

WORKDIR /

RUN . /etc/profile.d/puppet-agent.sh && \
  puppet apply -v /etc/puppetlabs/code/environments/production/manifests/install.pp

RUN rm -f /etc/puppetlabs/code/environments/production/manifests/install.pp

RUN . /etc/profile.d/puppet-agent.sh && \
  puppet apply -v /etc/puppetlabs/code/environments/production/manifests/default.pp

#COPY start.sh /start.sh
#CMD /start.sh
