# README

## Versões utilizadas

Ruby 3.1.2

Rails 7.0.5

MySQL

## Execução e Testes

Instalar as gems:
```
bundle install
```

Crias as bases de dados - development e test:
```
rails db:create
```

Executar migrações:
```
rails db:migrate
```

Executar a task de importação dos links:
```
rails import_urls
```

Executar a aplicação:
```
rails s
```

Executar testes:
```
rspec
```

Rotas disponíveis:
```
rails routes
```
