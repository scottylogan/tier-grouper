VERSION	  = 2.2.2
BASE	  = http://software.internet2.edu/grouper/release/$(VERSION)
VTGZ	  = $(VERSION).tar.gz
API	  = grouper.apiBinary-$(VTGZ)
PSP	  = grouper.psp-$(VTGZ)
INSTALLER = grouper.installer-$(VTGZ)
DIST	  = dist

download:
	mkdir -p $(DIST)
	curl -o $(DIST)/$(API) $(BASE)/$(API)

