# Aplicativo Mobile de Venda de Ingressos de Cinema

## Descrição

Este projeto consiste em um aplicativo mobile para **compra online de ingressos de cinema**, desenvolvido com foco em escalabilidade, integração com APIs externas e uso de estruturas de dados avançadas. O app permite ao usuário visualizar filmes em cartaz, selecionar sessões, realizar pagamentos via Pix (simulados) e gerar ingressos digitais com cupom de pagamento.

## Funcionalidades

- Listagem dinâmica de filmes em cartaz, consumindo a API pública do [TMDb](https://www.themoviedb.org/documentation/api).
- Visualização detalhada dos filmes, incluindo sinopse, elenco e trailers.
- Seleção de sessões com horários e salas, integrando dados reais de programação.
- Pagamento via API simulada para Pix, com validação local.
- Gerenciamento de múltiplas solicitações de impressão usando estrutura de dados para garantir confiabilidade.
- Geração de ingressos digitais com QR code e cupom de pagamento para impressão ou salvamento.

## Tecnologias Utilizadas

- **Flutter** para desenvolvimento mobile multiplataforma.
- Consumo de APIs RESTful para filmes e pagamentos.
- Estrutura de dados fila para gerenciar requisições de impressão.
- Clean Architecture para organização do código.

## Estrutura do Projeto

- `screens/` — Telas do aplicativo (Home, Detalhes, Sessão, Pagamento, Confirmação).
- `models/` — Modelos de dados para filmes, sessões, pagamentos e ingressos.
- `services/` — Serviços para integração com APIs externas e gerenciamento da fila.
- `utils/` — Utilitários para geração de QR code, validação, etc.

## Como Rodar o Projeto

1. Clone este repositório.
2. Configure as chaves de API do TMDb no arquivo de configuração.
3. Execute `flutter pub get` para instalar as dependências.
4. Rode o app com `flutter run` em um dispositivo ou emulador.

## Próximos Passos

- Implementar integração real com APIs de pagamento.
- Adicionar autenticação e perfil de usuário.
- Melhorar o cache local para otimizar desempenho e reduzir chamadas externas.
- Implementar notificações push para confirmação e lembretes de sessão.

## Imagens

<img width="470" height="996" alt="Captura de tela 2025-08-10 144605" src="https://github.com/user-attachments/assets/d2bf9e31-96a1-4c49-8874-64235f7e22e4" />

<img width="442" height="972" alt="Captura de tela 2025-08-10 140940" src="https://github.com/user-attachments/assets/4b2e583e-5873-49bf-a4b6-59f9203b8ce4" />

<img width="447" height="961" alt="Captura de tela 2025-08-10 140951" src="https://github.com/user-attachments/assets/927f226d-011c-4e06-9699-0b2ea50fdbf9" />

<img width="465" height="987" alt="Captura de tela 2025-08-10 141009" src="https://github.com/user-attachments/assets/0d02977a-9c6d-4d32-bcb5-5b75f709e756" />

<img width="463" height="989" alt="Captura de tela 2025-08-10 141023" src="https://github.com/user-attachments/assets/46f4a589-01cc-4fa8-8aa1-47b0ff6ca49d" />

<img width="437" height="1004" alt="Captura de tela 2025-08-10 141043" src="https://github.com/user-attachments/assets/9d788201-c701-441c-8619-f0aee86242f9" />

<img width="454" height="1031" alt="Captura de tela 2025-08-10 141455" src="https://github.com/user-attachments/assets/573421bd-be80-40e6-9593-01db612aeb7f" />

<img width="445" height="982" alt="Captura de tela 2025-08-10 144625" src="https://github.com/user-attachments/assets/a20f7481-a228-4f98-ae71-252567136fa0" />


## Vídeo do Projeto
- O vídeo abaixo mostra a V1 do projeto, ele ainda não esta finalizado, são apenas as primeiras páginas mostrando seu funcionamento básico.


https://github.com/user-attachments/assets/3f55696a-2782-4fa1-a978-1f99c7d486b9

