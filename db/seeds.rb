Company.create!(name: 'Secal', cnpj: '47.335.662/0001-86', domain: 'secal.com', website: 'www.secal.com')
Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com', website: 'www.rotes.com')

User.create!(email: 'eduardo@rotes.com', password: 'erotes')
User.create!(email: 'felipe@rotes.com', password: 'frotes')
User.create!(email: 'ana@rotes.com', password: 'arotes')
User.create!(email: 'domingos@rotes.com', password: 'drotes')
User.create!(email: 'camila@secal.com', password: 'csecal')
User.create!(email: 'fabiola@secal.com', password: 'fsecal')
User.create!(email: 'pedro@secal.com', password: 'psecal')

Department.create!(name: 'Administração')
Department.create!(name: 'Comercial')
Department.create!(name: 'Operacional')
Department.create!(name: 'Tecnologia')
Department.create!(name: 'Jurídico')
Department.create!(name: 'Limpeza')
Department.create!(name: 'RH')

ProductCategory.create!(name: 'Alimentos e bebidas')
ProductCategory.create!(name: 'Aparelhos eletrônicos')
ProductCategory.create!(name: 'Beleza')
ProductCategory.create!(name: 'Eletrodomésticos')
ProductCategory.create!(name: 'Esportes e lazer')
ProductCategory.create!(name: 'Jogos e colecionáveis')
ProductCategory.create!(name: 'Móveis')
ProductCategory.create!(name: 'Papelaria')
ProductCategory.create!(name: 'Vestuário')
ProductCategory.create!(name: 'Outras categorias')

ProductSubcategory.create!(name: 'Doces', 
                           product_category: ProductCategory.find_by(name: 'Alimentos e bebidas'))
ProductSubcategory.create!(name: 'Salgados', 
                           product_category: ProductCategory.find_by(name: 'Alimentos e bebidas'))
ProductSubcategory.create!(name: 'Vegano', 
                           product_category: ProductCategory.find_by(name: 'Alimentos e bebidas'))
ProductSubcategory.create!(name: 'Vegetariano', 
                           product_category: ProductCategory.find_by(name: 'Alimentos e bebidas'))
ProductSubcategory.create!(name: 'Refrigerantes', 
                           product_category: ProductCategory.find_by(name: 'Alimentos e bebidas'))
ProductSubcategory.create!(name: 'Sucos', 
                           product_category: ProductCategory.find_by(name: 'Alimentos e bebidas'))
ProductSubcategory.create!(name: 'Outros', 
                           product_category: ProductCategory.find_by(name: 'Alimentos e bebidas'))
ProductSubcategory.create!(name: 'Celulares', 
                           product_category: ProductCategory.find_by(name: 'Aparelhos eletrônicos'))
ProductSubcategory.create!(name: 'Câmeras', 
                           product_category: ProductCategory.find_by(name: 'Aparelhos eletrônicos'))
ProductSubcategory.create!(name: 'Televisão', 
                           product_category: ProductCategory.find_by(name: 'Aparelhos eletrônicos'))
ProductSubcategory.create!(name: 'Outros', 
                           product_category: ProductCategory.find_by(name: 'Aparelhos eletrônicos'))
ProductSubcategory.create!(name: 'Maquiagem', 
                           product_category: ProductCategory.find_by(name: 'Beleza'))
ProductSubcategory.create!(name: 'Perfumes', 
                           product_category: ProductCategory.find_by(name: 'Beleza'))
ProductSubcategory.create!(name: 'Higiene pessoal', 
                           product_category: ProductCategory.find_by(name: 'Beleza'))
ProductSubcategory.create!(name: 'Barbearia', 
                           product_category: ProductCategory.find_by(name: 'Beleza'))
ProductSubcategory.create!(name: 'Outros', 
                           product_category: ProductCategory.find_by(name: 'Beleza'))
ProductSubcategory.create!(name: 'Fogão', 
                           product_category: ProductCategory.find_by(name: 'Eletrodomésticos'))
ProductSubcategory.create!(name: 'Geladeira', 
                           product_category: ProductCategory.find_by(name: 'Eletrodomésticos'))
ProductSubcategory.create!(name: 'Microondas', 
                           product_category: ProductCategory.find_by(name: 'Eletrodomésticos'))
ProductSubcategory.create!(name: 'Batedeira', 
                           product_category: ProductCategory.find_by(name: 'Eletrodomésticos'))
ProductSubcategory.create!(name: 'Outros', 
                           product_category: ProductCategory.find_by(name: 'Eletrodomésticos'))
ProductSubcategory.create!(name: 'Basquete', 
                           product_category: ProductCategory.find_by(name: 'Esportes e lazer'))
ProductSubcategory.create!(name: 'Futebol', 
                           product_category: ProductCategory.find_by(name: 'Esportes e lazer'))
ProductSubcategory.create!(name: 'Ciclismo', 
                           product_category: ProductCategory.find_by(name: 'Esportes e lazer'))
ProductSubcategory.create!(name: 'Musculação', 
                           product_category: ProductCategory.find_by(name: 'Esportes e lazer'))
ProductSubcategory.create!(name: 'Natação', 
                           product_category: ProductCategory.find_by(name: 'Esportes e lazer'))
ProductSubcategory.create!(name: 'Tênis', 
                           product_category: ProductCategory.find_by(name: 'Esportes e lazer'))
ProductSubcategory.create!(name: 'Outros', 
                           product_category: ProductCategory.find_by(name: 'Esportes e lazer'))
ProductSubcategory.create!(name: 'Jogos tabuleiro', 
                           product_category: ProductCategory.find_by(name: 'Jogos e colecionáveis'))
ProductSubcategory.create!(name: 'Cartas', 
                           product_category: ProductCategory.find_by(name: 'Jogos e colecionáveis'))
ProductSubcategory.create!(name: 'Jogos eletrônicos', 
                           product_category: ProductCategory.find_by(name: 'Jogos e colecionáveis'))
ProductSubcategory.create!(name: 'Outros', 
                           product_category: ProductCategory.find_by(name: 'Jogos e colecionáveis'))
ProductSubcategory.create!(name: 'Armários', 
                           product_category: ProductCategory.find_by(name: 'Móveis'))
ProductSubcategory.create!(name: 'Mesas', 
                           product_category: ProductCategory.find_by(name: 'Móveis'))
ProductSubcategory.create!(name: 'Cadeiras', 
                           product_category: ProductCategory.find_by(name: 'Móveis'))
ProductSubcategory.create!(name: 'Sofás', 
                           product_category: ProductCategory.find_by(name: 'Móveis'))
ProductSubcategory.create!(name: 'Outros', 
                           product_category: ProductCategory.find_by(name: 'Móveis'))
ProductSubcategory.create!(name: 'Agendas', 
                           product_category: ProductCategory.find_by(name: 'Papelaria'))
ProductSubcategory.create!(name: 'Canetas e lápis', 
                           product_category: ProductCategory.find_by(name: 'Papelaria'))
ProductSubcategory.create!(name: 'Tesouras', 
                           product_category: ProductCategory.find_by(name: 'Papelaria'))
ProductSubcategory.create!(name: 'Grampeadores', 
                           product_category: ProductCategory.find_by(name: 'Papelaria'))
ProductSubcategory.create!(name: 'Outros', 
                           product_category: ProductCategory.find_by(name: 'Papelaria'))
ProductSubcategory.create!(name: 'Calçados', 
                           product_category: ProductCategory.find_by(name: 'Vestuário'))
ProductSubcategory.create!(name: 'Bolsas', 
                           product_category: ProductCategory.find_by(name: 'Vestuário'))
ProductSubcategory.create!(name: 'Roupa casual', 
                           product_category: ProductCategory.find_by(name: 'Vestuário'))
ProductSubcategory.create!(name: 'Roupa social', 
                           product_category: ProductCategory.find_by(name: 'Vestuário'))
ProductSubcategory.create!(name: 'Outros', 
                           product_category: ProductCategory.find_by(name: 'Vestuário'))
ProductSubcategory.create!(name: 'Serviços', 
                           product_category: ProductCategory.find_by(name: 'Outras categorias'))
ProductSubcategory.create!(name: 'Outros', 
                           product_category: ProductCategory.find_by(name: 'Outras categorias'))

Profile.create!(full_name: 'Eduardo Felipo', birthday: '10/04/1990', position: 'Assistente', 
                sector: 'Desenvolvimento de pessoas', department: Department.find_by(name: 'RH'), 
                user: User.find_by(email: 'eduardo@rotes.com'), work_address: 'Rua Nilza, 30')
Profile.create!(full_name: 'Felipe Pires', birthday: '20/07/1991', position: 'Gerente', 
                sector: 'Financeiro', department: Department.find_by(name: 'Administração'), 
                user: User.find_by(email: 'felipe@rotes.com'), work_address: 'Rua Nilza, 30')
Profile.create!(full_name: 'Guilherme Alves', chosen_name: 'Ana Alves', birthday: '10/04/1991', 
                position: 'Auxiliar', sector: 'Desenvolvimento de pessoas', 
                department: Department.find_by(name: 'Administração'), user: User.find_by(email: 'ana@rotes.com'), 
                work_address: 'Rua Evans, 40')
Profile.create!(full_name: 'Camila Antunes', birthday: '10/05/1989', position: 'Assistente', 
                sector: 'Vendas', department: Department.find_by(name: 'Comercial'), 
                user: User.find_by(email: 'camila@secal.com'), work_address: 'Rua Mirandinha, 50')
Profile.create!(full_name: 'Fabiola Cardoso', birthday: '08/07/1993', position: 'Gerente', 
                sector: 'Vendas', department: Department.find_by(name: 'Comercial'), 
                user: User.find_by(email: 'fabiola@secal.com'), work_address: 'Rua Mirandinha, 50')
Profile.create!(full_name: 'Joicy Sousa', chosen_name: 'Pedro Sousa', birthday: '23/03/1990', 
                position: 'Auxiliar', sector: 'Desenvolvimento de pessoas', 
                department: Department.find_by(name: 'RH'), user: User.find_by(email: 'pedro@secal.com'), 
                work_address: 'Rua Mirandinha, 50')

ProductCondition.create!(name: 'Usado')
ProductCondition.create!(name: 'Novo')

product1 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', 
                       product_subcategory: ProductSubcategory.find_by(name: 'Futebol'), 
                       description: 'Bola de futebol oficial da Copa do Mundo Fifa de 2002, ano em que o Brasil foi campeão mundial.', 
                       price: '240', product_condition: ProductCondition.find_by(name: 'Usado'), quantity: '2', 
                       profile: Profile.find_by(full_name: 'Eduardo Felipo'))
product1.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images','fevernova1.jpg')), filename: 'fevernova1.jpg')
product1.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images','fevernova2.jpg')), filename: 'fevernova2.jpg')
product1.save!
product2 = Product.new(name: 'Touca natação Speedo', 
                       product_subcategory: ProductSubcategory.find_by(name: 'Natação'), 
                       description: 'Touca de natação Speedo confortável, cor cinza, de ótima qualidade', 
                       price: '15', product_condition: ProductCondition.find_by(name: 'Usado'), quantity: '3', 
                       profile: Profile.find_by(full_name: 'Eduardo Felipo'))
product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images','speedo1.jpg')), filename: 'speedo1.jpg')
product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images','speedo2.jpg')), filename: 'speedo2.jpg')
product2.save!
product3 = Product.new(name: 'Sega Saturn', 
                       product_subcategory: ProductSubcategory.find_by(name: 'Jogos eletrônicos'), 
                       description: 'Console Sega Saturn com 2 controles, em perfeito estado.', 
                       price: '300', product_condition: ProductCondition.find_by(name: 'Usado'), quantity: '2', 
                       profile: Profile.find_by(full_name: 'Eduardo Felipo'))
product3.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images','sega1.jpg')), filename: 'sega1.jpg')
product3.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images','sega2.jpg')), filename: 'sega2.jpg')
product3.save!
product4 = Product.new(name: 'Bolo de cenoura', 
                       product_subcategory: ProductSubcategory.find_by(name: 'Doces'), 
                       description: 'Bolo de cenoura com recheio caprichado de chocolate, caseiro.', 
                       price: '30', product_condition: ProductCondition.find_by(name: 'Novo'), quantity: '4', 
                       profile: Profile.find_by(full_name: 'Felipe Pires'))
product4.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images','cenoura1.png')), filename: 'cenoura1.png')
product4.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images','cenoura2.jpg')), filename: 'cenoura2.jpg')
product4.save!
product5 = Product.new(name: 'Bolo de brigadeiro', 
                       product_subcategory: ProductSubcategory.find_by(name: 'Doces'), 
                       description: 'Bolo de brigadeiro com recheio caprichado de chocolate, caseiro', 
                       price: '30', product_condition: ProductCondition.find_by(name: 'Novo'), quantity: '5', 
                       profile: Profile.find_by(full_name: 'Felipe Pires'))
product5.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images','brigadeiro1.png')), filename: 'brigadeiro1.png')
product5.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images','brigadeiro2.jpg')), filename: 'brigadeiro2.jpg')
product5.save!
product6 = Product.new(name: 'Coxinha de frango', 
                       product_subcategory: ProductSubcategory.find_by(name: 'Salgados'), 
                       description: 'Coxinha de frango cremosa, com bastante recheio.', 
                       price: '3', product_condition: ProductCondition.find_by(name: 'Novo'), quantity: '5', 
                       profile: Profile.find_by(full_name: 'Guilherme Alves'))
product6.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images','coxinha1.png')), filename: 'coxinha1.png')
product6.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images','coxinha2.jpeg')), filename: 'coxinha2.jpeg')
product6.save!
product7 = Product.new(name: 'Fogão 5 bocas', 
                       product_subcategory: ProductSubcategory.find_by(name: 'Fogão'), 
                       description: 'Fogão Consul 5 bocas em perfeito estado', 
                       price: '170', product_condition: ProductCondition.find_by(name: 'Usado'), quantity: '1', 
                       profile: Profile.find_by(full_name: 'Guilherme Alves'))
product7.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images','fogao1.jpg')), filename: 'fogao1.jpg')
product7.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images','fogao2.jpg')), filename: 'fogao2.jpg')
product7.save!
product8 = Product.new(name: 'Camiseta branca', 
                       product_subcategory: ProductSubcategory.find_by(name: 'Roupa casual'), 
                       description: 'Camiseta branca de algodão', 
                       price: '30', product_condition: ProductCondition.find_by(name: 'Novo'), quantity: '20', 
                       profile: Profile.find_by(full_name: 'Guilherme Alves'))
product8.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images','camiseta1.jpg')), filename: 'camiseta1.jpg')
product8.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images','camiseta2.jpg')), filename: 'camiseta2.jpg')
product8.save!

Question.create!(product: product1, profile: Profile.find_by(full_name: 'Felipe Pires'), 
                 question_message: 'A bola foi utilizada em jogos da copa?')
Question.create!(product: product1, profile: Profile.find_by(full_name: 'Guilherme Alves'), 
                 question_message: 'Tem alguma marca na bola?')
Question.create!(product: product2 , profile: Profile.find_by(full_name: 'Felipe Pires'), 
                 question_message: 'A touca serve para cabeça grande?')
Question.create!(product: product2, profile: Profile.find_by(full_name: 'Guilherme Alves'), 
                 question_message: 'Só tem touca dessa cor?')
Question.create!(product: product3, profile: Profile.find_by(full_name: 'Felipe Pires'), 
                 question_message: 'Os controles estão em bom funcionamento?')
Question.create!(product: product3, profile: Profile.find_by(full_name: 'Guilherme Alves'), 
                 question_message: 'Quantos anos de uso tem o console?')
Question.create!(product: product4, profile: Profile.find_by(full_name: 'Eduardo Felipo'), 
                 question_message: 'Pode colocar granulado em cima?')
Question.create!(product: product4, profile: Profile.find_by(full_name: 'Guilherme Alves'), 
                 question_message: 'Qual peso do bolo?')
Question.create!(product: product5, profile: Profile.find_by(full_name: 'Eduardo Felipo'), 
                 question_message: 'Qual peso?')
Question.create!(product: product5, profile: Profile.find_by(full_name: 'Guilherme Alves'), 
                 question_message: 'Pode colocar granulado colorido?')
Question.create!(product: product6 , profile: Profile.find_by(full_name: 'Eduardo Felipo'), 
                 question_message: 'Vem com catupiry?')
Question.create!(product: product6, profile: Profile.find_by(full_name: 'Felipe Pires'), 
                 question_message: 'Poderia tirar cebola, caso tenha?')
Question.create!(product: product7, profile: Profile.find_by(full_name: 'Eduardo Felipo'), 
                 question_message: 'Algum dano no fogão?')
Question.create!(product: product7, profile: Profile.find_by(full_name: 'Felipe Pires'), 
                 question_message: 'Quantos anos de uso?')
Question.create!(product: product8, profile: Profile.find_by(full_name: 'Eduardo Felipo'), 
                 question_message: 'Tem no tamanho G?')
Question.create!(product: product8, profile: Profile.find_by(full_name: 'Felipe Pires'), 
                 question_message: 'Tem no tamanho P?')

Answer.create!(question: Question.find_by(question_message: 'A bola foi utilizada em jogos da copa?'), 
               answer_message: 'Somente na copa do meu bairro.')
Answer.create!(question: Question.find_by(question_message: 'Tem alguma marca na bola?'), 
               answer_message: 'Nenhuma marca presente.')
Answer.create!(question: Question.find_by(question_message: 'A touca serve para cabeça grande?'), 
               answer_message: 'A touca se adequa bem ao tamanho da cabeça.')
Answer.create!(question: Question.find_by(question_message: 'Só tem touca dessa cor?'), 
               answer_message: 'Só tenho nessa mesmo.')
Answer.create!(question: Question.find_by(question_message: 'Os controles estão em bom funcionamento?'), 
               answer_message: 'Estão em perfeito funcionamento.')
Answer.create!(question: Question.find_by(question_message: 'Quantos anos de uso tem o console?'), 
               answer_message: 'O console tem 10 anos de uso.')
Answer.create!(question: Question.find_by(question_message: 'Pode colocar granulado em cima?'), 
               answer_message: 'Posso sim.')
Answer.create!(question: Question.find_by(question_message: 'Qual peso do bolo?'), 
               answer_message: 'O bolo tem 1,5 kg.')
Answer.create!(question: Question.find_by(question_message: 'Qual peso?'), 
               answer_message: 'Tem 1,5 kg.')
Answer.create!(question: Question.find_by(question_message: 'Pode colocar granulado colorido?'), 
               answer_message: 'Posso sim.')
Answer.create!(question: Question.find_by(question_message: 'Vem com catupiry?'), 
               answer_message: 'Vem sim.')
Answer.create!(question: Question.find_by(question_message: 'Poderia tirar cebola, caso tenha?'), 
               answer_message: 'A coxinha é feita sem cebola.')
Answer.create!(question: Question.find_by(question_message: 'Algum dano no fogão?'), 
               answer_message: 'Somente algumas marcas na lateral dele.')
Answer.create!(question: Question.find_by(question_message: 'Quantos anos de uso?'), 
               answer_message: 'Ele tem 3 anos de uso.')
Answer.create!(question: Question.find_by(question_message: 'Tem no tamanho G?'), 
               answer_message: 'Tenho sim.')
Answer.create!(question: Question.find_by(question_message: 'Tem no tamanho P?'), 
               answer_message: 'Tenho nos tamanhos P, M e G.')

purchased1 = PurchasedProduct.create!(product: product4 , profile: Profile.find_by(full_name: 'Eduardo Felipo'), total_quantity: '1', start_date: '10/09/2020', status: 'iniciada', initial_value: '30')
purchased2 = PurchasedProduct.create!(product: product1 , profile: Profile.find_by(full_name: 'Felipe Pires'), total_quantity: '1', start_date: '10/09/2020', status: 'iniciada', initial_value: '240')
purchased3 = PurchasedProduct.create!(product: product5, profile: Profile.find_by(full_name: 'Eduardo Felipo'), total_quantity: '1', start_date: '10/09/2020', status: 'recusada', initial_value: '30', end_date: '11/09/2020')
purchased4 = PurchasedProduct.create!(product: product1 , profile: Profile.find_by(full_name: 'Guilherme Alves'), total_quantity: '1', start_date: '10/09/2020', status: 'recusada', initial_value: '240', end_date: '11/09/2020')
purchased5 = PurchasedProduct.create!(product: product6 , profile: Profile.find_by(full_name: 'Eduardo Felipo'), total_quantity: '2', start_date: '10/09/2020', status: 'andamento', initial_value: '6')
purchased6 = PurchasedProduct.create!(product: product2 , profile: Profile.find_by(full_name: 'Felipe Pires'), total_quantity: '1', start_date: '10/09/2020', status: 'andamento', initial_value: '15')
purchased7 = PurchasedProduct.create!(product: product7, profile: Profile.find_by(full_name: 'Eduardo Felipo'), total_quantity: '1', start_date: '10/09/2020', status: 'cancelada', initial_value: '170', end_date: '11/09/2020')
purchased8 = PurchasedProduct.create!(product: product2, profile: Profile.find_by(full_name: 'Guilherme Alves'), total_quantity: '1', start_date: '10/09/2020', status: 'cancelada', initial_value: '15', end_date: '11/09/2020')
purchased9 = PurchasedProduct.create!(product: product8 , profile: Profile.find_by(full_name: 'Eduardo Felipo'), total_quantity: '1', start_date: '10/09/2020', status: 'finalizada', initial_value: '30', end_date: '11/09/2020', freight_cost: '2', discount: '0', final_value: '32')
purchased10 = PurchasedProduct.create!(product: product3, profile: Profile.find_by(full_name: 'Felipe Pires'), total_quantity: '1', start_date: '10/09/2020', status: 'finalizada', initial_value: '300', end_date: '11/09/2020', freight_cost: '0', discount: '20', final_value: '280')

Negotiation.create!(profile: Profile.find_by(full_name: 'Guilherme Alves'), purchased_product: purchased5 , 
                    negotiation_message: 'Bom dia Eduardo, tudo bem? Qual o endereço para entrega das coxinhas?')
Negotiation.create!(profile: Profile.find_by(full_name: 'Eduardo Felipo'), purchased_product: purchased5, 
                    negotiation_message: 'Eu trabalho na unidade da Rua Nilza, 30. Você consegue entregar lá?')
Negotiation.create!(profile: Profile.find_by(full_name: 'Eduardo Felipo'), purchased_product: purchased6, 
                    negotiation_message: 'Bom dia, tudo bem? A entrega poderia ser feita semana que vem?')
Negotiation.create!(profile: Profile.find_by(full_name: 'Felipe Pires'), purchased_product: purchased6, 
                    negotiation_message: 'Pode sim, sem problemas. Você faz frete gratuito, já que estamos no mesmo endereço de empresa?')
Negotiation.create!(profile: Profile.find_by(full_name: 'Eduardo Felipo'), purchased_product: purchased7, 
                    negotiation_message: 'Bom dia. Você faz 50 reais de desconto no fogão? Está um pouco pesado para mim.')
Negotiation.create!(profile: Profile.find_by(full_name: 'Guilherme Alves'), purchased_product: purchased7, 
                    negotiation_message: 'Infelizmente só posso fazer por esse preço mesmo. Já está um preço bom.')
Negotiation.create!(profile: Profile.find_by(full_name: 'Eduardo Felipo'), purchased_product: purchased7, 
                    negotiation_message: 'É um desconto de 50 reais apenas, está difícil para mim.')
Negotiation.create!(profile: Profile.find_by(full_name: 'Guilherme Alves'), purchased_product: purchased7, 
                    negotiation_message: 'Não tem como baixar o preço. Irei cancelar a venda.')
Negotiation.create!(profile: Profile.find_by(full_name: 'Eduardo Felipo'), purchased_product: purchased8, 
                                             negotiation_message: 'Bom dia Ana, tudo bem? Qual seria o endereço de entrega da touca de natação?')
Negotiation.create!(profile: Profile.find_by(full_name: 'Guilherme Alves'), purchased_product: purchased8, 
                    negotiation_message: 'Desculpe Eduardo, eu tive um imprevisto. Não irei mais realizar a compra.')
Negotiation.create!(profile: Profile.find_by(full_name: 'Guilherme Alves'), purchased_product: purchased9, 
                    negotiation_message: 'Bom dia, tudo bem? Em qual endereço você quer que entregue?')
Negotiation.create!(profile: Profile.find_by(full_name: 'Eduardo Felipo'), purchased_product: purchased9, 
                    negotiation_message: 'No meu endereço de trabalho mesmo, na Rua Nilza, 30.')
Negotiation.create!(profile: Profile.find_by(full_name: 'Guilherme Alves'), purchased_product: purchased9, 
                    negotiation_message: 'Beleza, só tem uma coisa. Eu trabalho na Rua Evans, 40. Então terei que cobrar frete de 2 reais. Pode ser?')
Negotiation.create!(profile: Profile.find_by(full_name: 'Eduardo Felipo'), purchased_product: purchased9, 
                    negotiation_message: 'Está ótimo. Fechado então.')
Negotiation.create!(profile: Profile.find_by(full_name: 'Eduardo Felipo'), purchased_product: purchased10, 
                    negotiation_message: 'Bom dia, tudo bem? Qual endereço de entrega?')
Negotiation.create!(profile: Profile.find_by(full_name: 'Felipe Pires'), purchased_product: purchased10, 
                    negotiation_message: 'Pode ser na Rua Rua Nilza, 30? É o local onde trabalho.')
Negotiation.create!(profile: Profile.find_by(full_name: 'Eduardo Felipo'), purchased_product: purchased10, 
                    negotiation_message: 'Claro. Eu trabalho no mesmo prédio, então sem custo de frete.')
Negotiation.create!(profile: Profile.find_by(full_name: 'Felipe Pires'), purchased_product: purchased10, 
                    negotiation_message: 'Poderia fazer um desconto de 50 reais? Ficaria menos pesado para mim.')
Negotiation.create!(profile: Profile.find_by(full_name: 'Eduardo Felipo'), purchased_product: purchased10, 
                    negotiation_message: 'Posso fazer somente 20, tudo bem?')
Negotiation.create!(profile: Profile.find_by(full_name: 'Felipe Pires'), purchased_product: purchased10, 
                    negotiation_message: 'Beleza, fechado.')
product8.suspenso!
product5.quantity = 0
product5.status = 'indisponível'
product5.save!