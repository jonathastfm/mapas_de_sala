// lib/services/firestore_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/aluno_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // READ (Ler Alunos em tempo real)
  Stream<List<Aluno>> getAlunosStream() {
    return _db.collection('alunos').orderBy('nomeCompleto').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Aluno.fromMap(doc.id, doc.data())).toList());
  }

  // CREATE (Criar Aluno)
  Future<void> addAluno(Aluno aluno) {
    return _db.collection('alunos').add(aluno.toMap());
  }

  // UPDATE (Atualizar Aluno)
  Future<void> updateAluno(Aluno aluno) {
    return _db.collection('alunos').doc(aluno.id).update(aluno.toMap());
  }

  // DELETE (Excluir Aluno)
  Future<void> deleteAluno(String alunoId) {
    return _db.collection('alunos').doc(alunoId).delete();
  }
}