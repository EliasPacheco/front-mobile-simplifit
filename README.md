# Simplifit - Sistema de Gestão de Academia

Uma aplicação Flutter para gerenciar usuários e tipos de usuários de uma academia.

## Funcionalidades

- **Gestão de Tipos de Usuários**: Criar, editar, listar e excluir tipos de profissionais (Professor, Personal Trainer, Diretor, etc.)
- **Gestão de Usuários**: Cadastrar, editar, listar e excluir usuários da academia
- **Interface Intuitiva**: Design moderno e responsivo com Material Design 3
- **Validação de Dados**: Validação de formulários e tratamento de erros
- **Integração com API**: Comunicação com backend REST API

## Estrutura do Projeto

```
lib/
├── config.dart                 # Configurações da aplicação
├── main.dart                   # Ponto de entrada da aplicação
├── models/                     # Modelos de dados
│   ├── tipo_usuario.dart      # Modelo TipoUsuario
│   └── usuario.dart           # Modelo Usuario
├── screens/                    # Telas da aplicação
│   ├── home_screen.dart       # Tela principal
│   ├── tipos_usuario_screen.dart # Tela de tipos de usuários
│   └── usuarios_screen.dart   # Tela de usuários
├── services/                   # Serviços
│   └── api_service.dart       # Serviço de comunicação com API
└── widgets/                    # Widgets reutilizáveis
    ├── tipo_usuario_form.dart # Formulário de tipo de usuário
    └── usuario_form.dart      # Formulário de usuário
```

## Configuração

1. **Backend**: Certifique-se de que o backend está rodando em `http://localhost:3000`

2. **Endpoints da API**:
   - `GET /tipos-usuarios` - Listar tipos de usuários
   - `POST /tipos-usuarios` - Criar tipo de usuário
   - `PUT /tipos-usuarios/:id` - Atualizar tipo de usuário
   - `DELETE /tipos-usuarios/:id` - Excluir tipo de usuário
   - `GET /usuarios` - Listar usuários
   - `POST /usuarios` - Criar usuário
   - `PUT /usuarios/:id` - Atualizar usuário
   - `DELETE /usuarios/:id` - Excluir usuário

3. **Formato dos Dados**:

   **Tipo de Usuário**:
   ```json
   {
     "id": 1,
     "descricao": "Personal Trainer"
   }
   ```

   **Usuário**:
   ```json
   {
     "id": 1,
     "nome": "João Silva",
     "telefone": "(11) 99999-9999",
     "email": "joao@email.com",
     "tipoDeProfissional": 1,
     "situacao": true
   }
   ```

## Como Executar

1. **Instalar dependências**:
   ```bash
   flutter pub get
   ```

2. **Executar a aplicação**:
   ```bash
   flutter run
   ```

## Funcionalidades Detalhadas

### Gestão de Tipos de Usuários
- Visualizar lista de todos os tipos cadastrados
- Criar novos tipos de usuários
- Editar tipos existentes
- Excluir tipos (com confirmação)
- Atualizar lista em tempo real

### Gestão de Usuários
- Visualizar lista de todos os usuários cadastrados
- Criar novos usuários com validação de dados
- Editar usuários existentes
- Excluir usuários (com confirmação)
- Filtrar por tipo de profissional
- Indicador visual de status (ativo/inativo)

### Validações
- **Nome**: Campo obrigatório
- **Email**: Formato válido obrigatório
- **Telefone**: Formato válido obrigatório
- **Tipo de Profissional**: Seleção obrigatória

## Tecnologias Utilizadas

- **Flutter**: Framework de desenvolvimento
- **Dart**: Linguagem de programação
- **HTTP**: Comunicação com API REST
- **Material Design 3**: Design system

## Estrutura de Dados

### TipoUsuario
- `id`: Identificador único (int?)
- `descricao`: Descrição do tipo (String)

### Usuario
- `id`: Identificador único (int?)
- `nome`: Nome completo (String)
- `telefone`: Número de telefone (String)
- `email`: Endereço de email (String)
- `tipoDeProfissional`: ID do tipo de usuário (int)
- `situacao`: Status ativo/inativo (bool)

## Tratamento de Erros

A aplicação inclui tratamento robusto de erros:
- Conexão com API indisponível
- Dados inválidos
- Operações de CRUD falhadas
- Feedback visual para o usuário

## Interface do Usuário

- **Tela Principal**: Menu com opções para acessar tipos de usuários e usuários
- **Listagem**: Cards com informações organizadas e ações de edição/exclusão
- **Formulários**: Modais com validação em tempo real
- **Feedback**: Snackbars para confirmação de ações e notificação de erros

## Login do Usuário

- **Login e Senha**: admin@admin.com / 123456
