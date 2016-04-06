VERSION	  = 2.2.2
BASE	  = http://software.internet2.edu/grouper/release/$(VERSION)
VTGZ	  = $(VERSION).tar.gz
API	  = grouper.apiBinary-$(VTGZ)
PSP	  = grouper.psp-$(VTGZ)
INSTALLER = grouper.installer-$(VTGZ)
DIST	  = dist
MYSQL_NAME = tierdb

all: grouper

installer-image: .installer_ts

.installer_ts: Dockerfile.installer
	docker build -t tier/grouper-installer -f Dockerfile.installer .

download:
	mkdir -p $(DIST)
	curl -o $(DIST)/$(API) $(BASE)/$(API)

grouper: installer-image
	docker run --rm \
	  -h tierdb --name tierdb \
	  -e MYSQL_DATABASE=grouper \
	  -e MYSQL_USER=grouper \
	  -e MYSQL_PASSWORD=grouper \
	  -e MYSQL_ALLOW_EMPTY_PASSWORD=true \
	  -p 3306:3306 \
	  tier/mysql >tierdb.out 2>tierdb.err &
	sleep 10
	docker run \
	  -h grouper \
	  --name grouper-installer \
	  -e JAVA_HOME=/usr/lib/jvm/java \
	  --link tierdb:tierdb \
	  tier/grouper-installer java -cp .:grouperInstaller.jar edu.internet2.middleware.grouperInstaller.GrouperInstaller
	docker kill tierdb
	docker commit grouper-installer tier/grouper
	docker rm grouper-installer
