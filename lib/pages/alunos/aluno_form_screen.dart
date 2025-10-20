// lib/screens/alunos/aluno_form_screen.dart

import 'package:flutter/material.dart';
import '../../models/aluno_model.dart';
import '../../services/firestore_service.dart';

class AlunoFormScreen extends StatefulWidget {
  final Aluno? aluno; // Se for nulo, é CREATE. Se não, é UPDATE.

  AlunoFormScreen({this.aluno});

  @override
  _AlunoFormScreenState createState() => _AlunoFormScreenState();
}

class _AlunoFormScreenState extends State<AlunoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firestoreService = FirestoreService();
  
  late TextEditingController _nomeController;
  late TextEditingController _matriculaController;
  String _turmaIdSelecionada = 'id_da_turma_exemplo'; // TODO: Substituir por um Dropdown

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.aluno?.nomeCompleto ?? '');
    _matriculaController = TextEditingController(text: widget.aluno?.matricula ?? '');
    // Se estiver editando, carregar a turma do aluno
    if (widget.aluno != null) {
        _turmaIdSelecionada = widget.aluno!.turmaId;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.aluno == null ? 'Novo Aluno' : 'Editar Aluno'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome Completo'),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _matriculaController,
                decoration: InputDecoration(labelText: 'Matrícula'),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              // TODO: Criar um DropdownButton para selecionar a turma de uma lista
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Salvar'),
                onPressed: _salvar,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _salvar() async {
    if (_formKey.currentState!.validate()) {
      final novoAluno = Aluno(
        id: widget.aluno?.id, // Mantém o ID se estiver editando
        nomeCompleto: _nomeController.text,
        matricula: _matriculaController.text,
        turmaId: _turmaIdSelecionada,
      );

      if (widget.aluno == null) {
        // CREATE
        await _firestoreService.addAluno(novoAluno);
      } else {
        // UPDATE
        await _firestoreService.updateAluno(novoAluno);
      }
      
      Navigator.of(context).pop(); // Volta para a lista
    }
  }
}