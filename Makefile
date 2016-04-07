all: grouper
  
grouper: 
	docker build -t tier/grouper .
