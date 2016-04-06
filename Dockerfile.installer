FROM tier/base
MAINTAINER Scotty Logan <swl@stanford.edu>

#
# Grouper
#
USER root
RUN yum install -q -y dos2unix java-1.7.0-openjdk-headless java-1.7.0-openjdk-devel
RUN useradd -d /opt/grouper -c 'Grouper' -m -r -s /bin/bash grouper

USER grouper
WORKDIR /tmp
RUN curl -q -O http://software.internet2.edu/grouper/release/2.2.2/grouperInstaller.jar
COPY grouper.installer.properties .
