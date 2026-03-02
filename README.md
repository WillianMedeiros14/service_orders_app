# 📋 App de Ordens de Serviço - Técnico Field

> Aplicativo mobile desenvolvido em **Flutter** para que técnicos possam visualizar e executar suas ordens de serviço de forma rápida e organizada.

---

## 🚀 Tecnologias Utilizadas

| Tecnologia                                    | Descrição                                              |
| --------------------------------------------- | ------------------------------------------------------ |
| [Flutter](https://flutter.dev) 3.41.2         | Framework principal para desenvolvimento mobile        |
| [Dart](https://dart.dev)                      | Linguagem de programação base do Flutter               |
| [MobX](https://pub.dev/packages/mobx)         | Gerenciamento de estado reativo baseado em observáveis |
| [Provider](https://pub.dev/packages/provider) | Injeção de dependências e compartilhamento de estado   |
| [Dio](https://pub.dev/packages/dio)           | Cliente HTTP para consumo de APIs REST                 |

---

## ✨ Funcionalidades

| Funcionalidade               | Descrição                                         |
| ---------------------------- | ------------------------------------------------- |
| 📝 Criar Conta               | Cadastro de novo técnico no sistema               |
| 🔐 Login                     | Autenticação segura com Usuário e senha           |
| 📋 Listar Ordens de Serviço  | Visualização de todas as OS atribuídas ao técnico |
| ▶️ Executar Ordem de Serviço | Registrar a execução e atualizar o status da OS   |

---

## 📁 Estrutura do Projeto

O projeto segue a arquitetura de **mini módulos** — cada feature é auto-contida. Componentes que se tornam globais sobem para dentro de `features/` ou `shared/`.

```
lib/
├── main.dart
└── features/
    ├── auth/                        # Módulo de autenticação
    │   ├── data/
    │   │   ├── model/               # Modelos de dados
    │   │   └── repositories/        # Repositórios e acesso a dados
    │   └── presentation/
    │       ├── pages/               # Telas
    │       ├── stores/              # Gerenciamento de estado
    │       └── widgets/             # Widgets exclusivos do módulo
    │
    └── home/                        # Módulo de Ordens de Serviço
        ├── data/
        │   ├── model/               # Modelos de dados
        │   └── repositories/        # Repositórios e acesso a dados
        └── presentation/
            ├── pages/               # Telas de listagem e execução de OS
            ├── stores/              # Gerenciamento de estado
            └── widgets/             # Widgets exclusivos do módulo
```

---

## ⚙️ Pré-requisitos

Antes de rodar o projeto, certifique-se de ter instalado:

- [Flutter SDK 3.41.2](https://docs.flutter.dev/get-started/install)
- [Dart SDK](https://dart.dev/get-dart) (incluso no Flutter)
- [Android Studio](https://developer.android.com/studio) ou [Xcode](https://developer.apple.com/xcode/) (para iOS)
- Um emulador ou dispositivo físico conectado

## 🛠️ Como rodar o projeto

### 1. Clone o repositório

```bash
git clone https://github.com/WillianMedeiros14/service_orders_app.git
cd service_orders_app
```

### 2. Instale as dependências

```bash
flutter pub get
```

### 3. Execute o aplicativo

```bash
flutter run
```

---

## 🔄 Fluxo da Aplicação

```
Tela Inicial
    ├── Criar Conta → Formulário de cadastro → Home
    └── Login → Home
                    └── Lista de Ordens de Serviço
                                └── Detalhes da OS → Executar OS → Confirmação
```

---

## 📱 Telas

- **Tela de Login** — Autenticação com e-mail e senha
- **Tela de Cadastro** — Criação de conta para o técnico
- **Tela de Ordens de Serviço** — Lista com todas as OS do técnico logado
- **Tela de Execução** — Detalhes da OS e registro da execução

---
