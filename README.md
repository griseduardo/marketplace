<h1 align='center'> Marketplace </h1>
<p align='justify'> Aplicação de compras e vendas, onde funcionários de um mesma empresa podem negociar produtos. </p>

### Principais funcionalidades da aplicação

- Associação do email de usuário a empresa pré-cadastrada no sistema
  - Ao cadastrar usuário, ele é associado a sua empresa, a partir do domínio presente no email corporativo.
- Cadastrar perfil
  - O usuário precisará cadastrar o perfil para poder realizar anúncio de produtos e compras. Ao clicar em 'Meu perfil', caso não tenha cadastro será direcionado para página de realizar cadastro, caso já tenha será direcionado para página de visualização e edição de cadastro.
- Cadastrar produtos para venda
  - Após cadastrar perfil, o usuário pode anunciar produto para venda ao clicar em 'Cadastrar produto', colocando as informações principais e anexando imagens.
- Visualizar os produtos a venda
  - O comprador consegue visualizar todos os produtos de outras pessoas da mesma empresa na página principal, ver produtos de uma categoria específica, de uma subcategoria específica, por vendedor e pesquisar num campo de busca por nome, descrição e subcategoria de produto.
- Iniciar compra do produto
  - Ao clicar no anúncio do produto de outra pessoa, é possível ver as informações principais dele, tirar dúvidas e iniciar a compra colocando a quantidade que deseja comprar.  
- Gerenciamento de anúncio
  - Ao acessar 'Meus produtos', o usuário poderá ver seus produtos colocados à venda. Clicando em um deles, poderá ver as informações cadastradas e imagens, responder as perguntar de outros usuários sobre o produto, editar o produto ou suspender o produto para que outras pessoas não possam ver ele no sistema.
- Etapas de uma compra
  - Compra de um produto
    - Após ver um produto, o usuário coloca a quantidade que deseja comprar e inicia compra.
  - Confirmação da compra
    - Comprador aguarda o vendedor confirmar a venda ou recusá-la. 
  - Negociação
    - Caso o vendedor confirme a venda, começará a etapa de negociação onde comprador e vendedor combinam forma de entrega, frete e desconto.
  - Conclusão de compra
    - Chegado ao fim da etapa de negociação, o vendedor concluirá a venda (colocando frete e desconto) ou cancelará ela.
- Gerenciamento do vendedor
  - Ao acessar 'Vendas', o vendedor verá a lista de vendas aguardando confirmação, recusadas, em negociação, canceladas e concluídas.
  - Selecionando a venda na lista de recusadas, canceladas e concluídas é possível ver o histórico.
  - Selecionando a venda na lista de aguardando confirmação, é possível confirmar ou recusar a venda.
  - Selecionando a venda na lista de em negociação, é possível trocar mensagens com comprador para definir entrega, frete e desconto, por fim concluindo ou cancelando a venda.
- Gerenciamento do comprador
  - Ao acessar 'Compras', o comprador verá a lista de compras aguardando confirmação, recusadas, em negociação, canceladas e concluídas.
  - Selecionando a compra na lista de recusadas, canceladas e concluídas é possível ver o histórico.
  - Selecionando a compra na lista de aguardando confirmação, é possível somente ver informações da compra enquanto aguarda a confirmação do vendedor.
  - Selecionando a compra na lista de em negociação, é possível trocar mensagens com vendedor para definir entrega, frete e desconto.

> Status do Projeto: Em desenvolvimento

### Versões usadas na aplicação

- [Ruby](https://www.ruby-lang.org/en/documentation/installation/): versão 2.7.0 
- [Rails](https://guides.rubyonrails.org/v5.0/getting_started.html): versão 6.0.3.2
- [Node](https://nodejs.org/en/download/): versão 12.18.3

### Gems utilizadas

- [cpf_cnpj](https://github.com/fnando/cpf_cnpj) - validação de cnpj das empresas 
- [devise](https://github.com/heartcombo/devise) - cadastro, login e logout de usuário 
- [capybara](https://github.com/teamcapybara/capybara), [rspec-rails](https://github.com/rspec/rspec-rails) - utilizado para testes da aplicação 
- [bootstrap-sass](https://github.com/twbs/bootstrap-sass), [sassc-rails](https://github.com/twbs/bootstrap-sass) - framework front-end

# Comando para rodar testes

<p> rspec </p>

### Como rodar aplicação

<p> Clonar repositório: git clone https://github.com/griseduardo/marketplace.git </p>
<p> Entrar na pasta do projeto: cd marketplace </p>
<p> Instalar dependências: bundle install </p>
<p> Rodar migrations: rails db:migrate </p>
<p> Popular banco de dados: rails db:seed </p>
<p> Iniciar aplicação: rails s </p>
<p> Abrir aplicação no navegador: localhost:3000 </p>

### Ver funcionalidades da aplicação

- Entrar com usuário - email: eduardo@rotes.com, senha: erotes
  - Usuário com perfil cadastrado, ligado a uma empresa que tem outras três pessoas, com produtos já cadastrados.
  - Tanto para venda como para compra, tem um produto em cada cenário possível, possibilitando a visualização do gerenciamento de venda e de compra.
- Entrar com usuário - email: domingos@rotes.com, senha: drotes
  - Usuário sem perfil cadastrado, ligado a mesma empresa do Eduardo.
  - Possível ver o redirecionamento direto para tela de cadastro do perfil ao tentar cadastrar ou comprar produto.
- Entrar com usuário - email: camila@secal.com, senha: crotes
  - Empresa sem nenhum produto cadastrado, não deve ser possível ver produtos da empresa Rotes (do Eduardo e Domingos).