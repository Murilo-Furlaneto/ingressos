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

## Vídeo do Projeto
- O vídeo abaixo mostra a V1 do projeto, ele ainda não esta finalizado, são apenas as primeiras páginas mostrando seu funcionamento básico.


https://github.com/user-attachments/assets/3f55696a-2782-4fa1-a978-1f99c7d486b9

