## UFFMailService
Um serviço online para criação de email do dominio id.uf

#### Features:
##### Serviço de geração de opções para email
A partir do nome completo do usuário, combinações com do primeiro nome com os outros são criadas para serem usadas no cadastro do novo email.
> GET /student/:id/uffmail_options  

<br>
##### Criação de registro no banco de dado a partir de arquivo CSV
É possivel enviar um arquivo CSV para o sistema a fim de cadastrar multiplos usuário no banco de dados.
> POST /create_with_csv  

<br>
##### Cadastro de usuário individualmente
Enviando informações de cadastro via HTTP Request, é possivel cadastra um usuário no sistema.
> POST /students

<br>
#### Atualização de resgitro de usuário
Enviando as informações novas via HTTP Request, é possivel atualizar as informações de uma usuário já cadastrado.
> PUT/PATCH /student/:id

<br>
#### Especificações:  

* Ruby version: 2.6.6  

System dependencies:
- Faker (2.19.0)
- Rspec Rails (5.1.0)
- Factory Bot Rails (6.2.0)
- Rails (5.2.6)

