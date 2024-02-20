make fmt: 
	cd terraform && terraform fmt

make init: 
	cd terraform && terraform init

make apply: 
	cd terraform && terraform apply