# Deploy EC2 (Terraform)

Deploy de aplicação spring em uma instância EC2 baseado em IaC

## Antes de rodar

Criar um usuário via IAM com as seguintes permissões, nesse caso foi usado o acesso total, porem recomenda-se usar apenas o necessário:

- *AmazonEC2ContainerRegistryFullAccess*
- *AmazonEC2FullAccess*
- *AmazonVPCFullAccess*
- *AWSMarketplaceAmiIngestion*

Após criado o usuário, gere as chaves de acesso do mesmo, salvando o arquivo .csv em um lugar seguro. Feito isso, configure o usuário via CLI, usando a *access key* e s*ecret key* que estão no arquivo.

```sh
aws configure --profile <nome do usuário no IAM>
```

> Para confirmar se o perfil foi configurado, consulte os arquivos em `~/.aws`.

Gere uma chave ssh com o nome de `terraform-key-ec2` e salve ela em `~/.ssh`:

```sh
ssh-keygen -t ed25519
```

## Subindo a infra

Rode os seguintes comandos dentro do diretório do projeto:

```sh
terraform init # inicia o terraform e faz o download do provider
terraform plan # faz uma validação dos recurso e informa se está tudo certo ou não
terraform apply # cria os recursos dentro da AWS, esse comando necessita de uma aprovação manual para fazer a implantação de tudo
```

## Conectando à instância
Quando terminar a execução dos comandos do terraform, conecte-se via ssh:

```sh
ssh -i ~/.ssh/terraform-key-ec2 ubuntu@<IPv4 publico da instância>  
```

> `ubuntu` é nome do usuário da instância.

## Testando localmente

Para acessar a aplicação que está rodando no EC2, basta pegar o DNS publico da instância.

**Rotas de exemplo**

- `/actuator`: acessa os dados do actuator, contendo métricas da API
- `/contactbook/swagger-ui.html`: acessa a lista de enpoints da aplicação via Swagger-UI

## Destruindo a infra

Rode o comando:

```sh
terraform destroy # semelhante ao 'apply', também precisa de aprovação manual para concluir
```
## Fonte

ARAUJO, M. MarceloAraujo14/tutorial-spring-docker-terraform-aws. Disponível em: <https://github.com/MarceloAraujo14/tutorial-spring-docker-terraform-aws>.
