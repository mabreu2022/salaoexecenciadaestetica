💇‍♀️ Salão Excelência Estética
Sistema de gerenciamento para salões de beleza e clínicas de estética, desenvolvido em Delphi 12.3 com banco de dados Firebird 5.0, seguindo o padrão de arquitetura MVC (Model-View-Controller).

🚀 Funcionalidades Principais
• 	Gerenciamento de Clientes
• 	Cadastro de clientes com dados de contato e histórico
• 	Registro de procedimentos realizados
• 	Cadastro de Categorias
• 	Definição de categorias de serviços (ex: Tratamento Facial, Tratamento Corporal)
• 	Serviços
• 	Cadastro e associação de serviços às categorias
• 	Definição de preços e tempo estimado por serviço
• 	Procedimentos
• 	Agendamento e controle de procedimentos realizados
• 	Vinculação de cliente + serviço + data/hora
• 	Fotos de Procedimentos
• 	Upload e armazenamento de imagens vinculadas ao procedimento
• 	Suporte para múltiplas fotos por atendimento
• 	Controle de Usuários
• 	Login com controle de acesso
• 	Exibição de usuário logado na interface principal
• 	Relatórios e Consultas
• 	Visão geral de atendimentos por cliente
• 	Filtro de serviços por categoria
• 	Infraestrutura
• 	Acesso a dados via FireDAC
• 	Design responsivo com VCL
• 	Armazenamento de imagens por BLOB ou caminho de arquivo

🛠️ Tecnologias Utilizadas
• 	Delphi 12.3 (VCL)
• 	Firebird 5.0
• 	IBExpert
• 	Git/GitHub para versionamento
• 	Arquitetura MVC

📁 Estrutura de Pastas (sugerida)
/Model
/Controller
/View
/DAO
/Utils

Tipos de pesquisa disponíveis
- Por nome do cliente
→ Digitar no edtPesquisar busca por trechos do nome (ex: "mar" encontra "Mauricio").
- Por data do procedimento
→ Usando dtInicial e dtFinal, você pode restringir o intervalo de busca (ex: de 01/06 a 23/06).
- Por categoria do serviço (tipo)
→ Selecionando no cbCategoria, você pode ver apenas fotos de procedimentos da categoria "Estética", "Clínica", "Odonto", etc.
- Combinação de critérios
→ O usuário pode buscar, por exemplo, todos os procedimentos da categoria “Clínica” feitos por clientes com nome “Ana” entre duas datas.


👥 Desenvolvedor
Projeto em desenvolvimento por Mauricio Abreu.
Repositório oficial: GitHub - mabreu2022/salaoexecenciadaestetica
