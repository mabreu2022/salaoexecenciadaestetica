# ✅ Projeto Salão Excelência da Estética – Checklist Técnico

Este arquivo serve como acompanhamento técnico do progresso do sistema. Aqui estão os itens implementados, ajustes recomendados e pendências identificadas.

---

## 🚀 Funcionalidades já implementadas

- [x] Cadastro de fotos de procedimentos com salvamento em BLOB
- [x] Galeria visual com miniaturas no FlowPanel
- [x] Duplo clique para ampliar imagem em tela separada
- [x] Filtro por nome/texto
- [x] Filtro por intervalo de datas (data inicial e final)
- [x] Filtro por categoria com opção "(Todas as categorias)"
- [x] Arquitetura MVC aplicada
- [x] Controle de banco via FireDAC
- [x] ComboBox com dados do banco via TFDMemTable

---

## 🔧 Melhorias recomendadas

- [ ] Remover variável global `FrmFotoAmpliada` (não está mais sendo usada)
- [ ] Criar um DataModule para centralizar as queries (ex: `qryCategorias`, `qryPesquisa`)
- [ ] Adicionar `FlowPanel1.DestroyComponents` antes de recarregar miniaturas (para evitar duplicidade)
- [ ] Criar pasta padrão (AppData ou `.\ImagensTeste`) para armazenar fotos temporárias (exportação/recuperação)
- [ ] Renomear `Unit2` para `uView.FotoAmpliada` no projeto (alinhando com o nome real do arquivo)
- [ ] Tratar exceções nas operações DAO
- [ ] Garantir uso correto de transações FireDAC nas operações críticas

---

## 📌 Pendências técnicas

- [ ] Separar toda lógica de negócio dos formulários (evitar código SQL ou DAO direto em Views)
- [ ] Evitar versionamento de arquivos temporários e de cache
  - Exemplo: `*.identcache`, `*.local`
  - Solução: revisar e atualizar o `.gitignore`
- [ ] Incluir testes unitários com DUnitX (ao menos para DAO e Model)
- [ ] Finalizar `FrmFotoAmpliada` com botão "Fechar" ou atalho Esc
- [ ] Incluir tratamento para erro ao carregar imagem inválida
- [ ] Criar documentação técnica mais completa no `README.md`, incluindo:
  - [ ] Mapa de funcionalidades
  - [ ] Print da estrutura do banco de dados
  - [ ] Passo a passo para compilar e configurar ambiente
- [ ] Testar carregamento com imagens de alta resolução (verificar consumo de memória)

---

## ✨ Extras sugeridos

- [ ] Criar classe visual para miniatura (`TMiniaturaFoto`) com ações nativas
- [ ] Adicionar filtros por nome do serviço, profissional ou status (se aplicável)
- [ ] Ativar pesquisa instantânea com `OnChange` ou `OnCloseUp` nos filtros

---

_Última atualização: {{data}}_