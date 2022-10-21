SHELL=/bin/bash
SUBNET_COUNT?=6
NAME?=galp-test
REGION?=us-east-1

init:
	cd terraform&&terraform init -reconfigure
apply: plan init
	cd terraform&&terraform apply -auto-approve=true 
plan:  init build
	cd terraform&&terraform plan -var="name=${NAME}" -var="subnet_count=${SUBNET_COUNT}" -var="region=${REGION}"
destroy: init
	cd terraform&&terraform destroy 
build: 
	cd packer && packer build -var "ami_name=${NAME}" -var "region=${REGION}" .
