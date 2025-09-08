# Simplifit - Sistema de Gestão de Academia

## Configuração

1. **Backend**: Certifique-se de que o backend está rodando em `http://192.168.3.166:3000` (é meu porém tem q trocar para sincronizar )

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

## Login do Usuário

- **Login e Senha**: admin@admin.com / 123456
