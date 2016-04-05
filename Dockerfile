FROM   tier/base
MAINTAINER Scotty Logan <swl@stanford.edu>

USER root

#
# Shibboleth IDP
#
RUN mkdir /opt/grouper
RUN curl -q http://software.internet2.edu/grouper/release/2.2.2/grouper.apiBinary-2.2.2.tar.gz | tar -C /opt/grouper -xzf -

EXPOSE 8080
