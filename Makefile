tf-fmt: 
	cd terraform && terraform fmt

ansible-generate-tf-vars:
	ansible-playbook --vault-password-file .vaultpass ansible/terraform.yml

tf-init: 
	cd terraform && terraform init

tf-apply: 
	cd terraform && terraform apply 

ansible-setup:
	ansible-playbook --vault-password-file .vaultpass ansible/playbooks/playbook_setup.yml -i ansible/inventory.ini

ansible-redmine:
	ansible-playbook --vault-password-file .vaultpass ansible/playbooks/playbook_redmine.yml -i ansible/inventory.ini

ansible-datadog:
	ansible-playbook --vault-password-file .vaultpass ansible/playbooks/playbook_datadog.yml -i ansible/inventory.ini	


vault-terraform:
	ansible-vault encrypt terraform/secret.tfvars --vault-password-file .vaultpass

vault-ansible:
	ansible-vault encrypt ansible/group_vars/all/vault.yml --vault-password-file .vaultpass