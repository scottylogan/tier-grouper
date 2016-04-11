all: grouper
  
grouper:
	docker build -t tier/grouper --no-cache .
