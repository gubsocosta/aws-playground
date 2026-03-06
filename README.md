# aws-playground

Ambiente de desenvolvimento local para testar integrações com AWS.

Nesse ambiente, temos as seguintes aplicações:
- uma aplicacao com php/laravel
- uma aplicação com python/chalice
- LocalStack para simular os serviços da AWS
- AWS CLI para interagir com o LocalStack

O objetivo é criar um ambiente de desenvolvimento completo para testar integrações com AWS sem precisar de uma conta real.

## Requisitos
- Docker
- Docker Compose

## Como usar
1. Clone este repositório:
```bash
git clone https://github.com/gubsocosta/aws-playground.git
cd aws-playground
```

2. De permissão de execução para o script de configuração:
```bash
chmod +x setup.sh
```

3. Execute o script de configuração:
```bash
./setup.sh
```
4. Apos a configuração, o ambiente estará pronto para uso. Você pode acessar as aplicações Laravel e Chalice nos seguintes endereços:

- Laravel: http://localhost:8001
- Chalice: http://localhost:8000

Ou acessar os containers diretamente:
```bash
docker compose exec -it laravel-app ash
docker compose exec -it chalice-app bash
```
  
## Visualizando os logs no CloudWatch
1. Acesse o container do aws-cli:
```bash
docker compose exec -it aws-cli sh
```

2. Liste os grupos de logs para verificar se o grupo do Laravel foi criado:
```bash
aws logs describe-log-groups
```

3. Liste os streams de logs dentro do grupo do Laravel para verificar se o stream foi criado:
```bash
aws logs describe-log-streams --log-group-name laravel_app
```

4. Visualize os logs do stream para verificar se os logs estão sendo enviados corretamente:
```bash
aws logs get-log-events --log-group-name laravel_app --log-stream-name laravel_app
```

5. Para visualizar os logs em tempo real, você pode usar o comando `aws logs tail`:
```bash
aws logs tail laravel_app --follow
```