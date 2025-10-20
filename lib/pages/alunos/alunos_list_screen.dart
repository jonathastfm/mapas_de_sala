// lib/screens/alunos/alunos_list_screen.dart

import 'package:flutter/material.dart';
import '../../models/aluno_model.dart';
import '../../services/firestore_service.dart';
import 'aluno_form_screen.dart';

class AlunosListScreen extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Alunos'),
      ),
      body: StreamBuilder<List<Aluno>>(
        stream: _firestoreService.getAlunosStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum aluno cadastrado.'));
          }
          if (snapshot.hasError) {
            return Center(child: Text('Ocorreu um erro: ${snapshot.error}'));
          }

          List<Aluno> alunos = snapshot.data!;

          return ListView.builder(
            itemCount: alunos.length,
            itemBuilder: (context, index) {
              Aluno aluno = alunos[index];
              return ListTile(
                title: Text(aluno.nomeCompleto),
                subtitle: Text('Matrícula: ${aluno.matricula}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    // Adicionar um diálogo de confirmação antes de excluir
                    await _firestoreService.deleteAluno(aluno.id!);
                  },
                ),
                onTap: () {
                  // Navegar para a tela de formulário para EDITAR
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AlunoFormScreen(aluno: aluno),
                  ));
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Navegar para a tela de formulário para CRIAR
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AlunoFormScreen(),
          ));
        },
      ),
    );
  }
}