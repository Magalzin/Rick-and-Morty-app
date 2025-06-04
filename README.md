
# Rick and Morty Characters App

Este projeto Flutter consome a [Rick and Morty API](https://rickandmortyapi.com/) para exibir uma lista de personagens da série. Os dados são apresentados em cards e o usuário pode buscar personagens por nome em tempo real.

## 🔧 Funcionalidades

- Listagem dos personagens com:
  - **Nome**
  - **Status** (ex: Alive, Dead, Unknown)
  - **Espécie**
  - **Tipo**
  - **Gênero**
  - **Imagem**
- Campo de busca para filtrar os personagens por **nome**
- Layout responsivo para **mobile** e **web**
- Pop-up com mais detalhes ao clicar em um personagem

## 📦 Modelo de Dados

Cada personagem é representado com o seguinte modelo:

## 🔍 Busca
A busca funciona por nome do personagem. Ao digitar no campo de busca, a lista de personagens é atualizada dinamicamente com os resultados correspondentes.

## 🖼️ Imagem
As imagens dos personagens são carregadas diretamente da URL fornecida pela API e exibidas no card e no pop-up de detalhes.

## 💡 Tecnologias
Flutter

Consumo de API com http ou Dio

Gerenciamento de estado com GetX, Cubit ou Provider (dependendo da implementação)

Responsividade com LayoutBuilder e MediaQuery

## ▶️ Como rodar
bash
Copiar
Editar
flutter pub get
flutter run
Certifique-se de ter um emulador aberto ou dispositivo conectado.