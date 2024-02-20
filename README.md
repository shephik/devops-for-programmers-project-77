### Hexlet tests and linter status:
[![Actions Status](https://github.com/shephik/devops-for-programmers-project-77/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/shephik/devops-for-programmers-project-77/actions)


Форматировать файлы terraform \
`make fmt` \

Зашифровать файл с секретами terraform \
`ansible-vault encrypt terraform/secrets.tfvars --vault-password-file .vaultpass` \

Инициация terraform \
`make init` \

Выполнить terraform \
`make apply` \