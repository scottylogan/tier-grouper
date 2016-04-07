all: grouper
  
grouper:
	cd puppet && librarian-puppet install --clean --verbose --path=./modules
	docker build -t tier/grouper .
