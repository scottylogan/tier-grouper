all: grouper
  
grouper:
	cd puppet && librarian-puppet install --verbose --path=./modules
	docker build -t tier/grouper .
