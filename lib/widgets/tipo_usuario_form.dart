import 'package:flutter/material.dart';
import '../models/tipo_usuario.dart';
import '../services/api_service.dart';

class TipoUsuarioForm extends StatefulWidget {
  final TipoUsuario? tipo;
  final VoidCallback onSaved;

  const TipoUsuarioForm({
    super.key,
    this.tipo,
    required this.onSaved,
  });

  @override
  State<TipoUsuarioForm> createState() => _TipoUsuarioFormState();
}

class _TipoUsuarioFormState extends State<TipoUsuarioForm> {
  final _formKey = GlobalKey<FormState>();
  final _descricaoController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.tipo != null) {
      _descricaoController.text = widget.tipo!.descricao;
    }
  }

  @override
  void dispose() {
    _descricaoController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      if (widget.tipo == null) {
        // Criar novo tipo
        await ApiService.createTipoUsuario(_descricaoController.text.trim());
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Tipo de usuário criado com sucesso!'), backgroundColor: Colors.green,),
          );
        }
      } else {
        // Atualizar tipo existente
        await ApiService.updateTipoUsuario(
          widget.tipo!.id!,
          _descricaoController.text.trim(),
        );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Tipo de usuário atualizado com sucesso!'), backgroundColor: Colors.green,),
          );
        }
      }
      widget.onSaved();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.tipo == null ? 'Novo Tipo de Usuário' : 'Editar Tipo de Usuário'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _descricaoController,
              decoration: const InputDecoration(
                labelText: 'Descrição',
                hintText: 'Ex: Personal Trainer, Professor, etc.',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Por favor, insira uma descrição';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _save,
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(widget.tipo == null ? 'Criar' : 'Salvar'),
        ),
      ],
    );
  }
}
