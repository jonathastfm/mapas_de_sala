// lib/models/aluno_model.dart

class Aluno {
  final String? id; // O ID do documento no Firestore
  final String nomeCompleto;
  final String matricula;
  final String turmaId; // Para vincular o aluno a uma turma

  Aluno({
    this.id,
    required this.nomeCompleto,
    required this.matricula,
    required this.turmaId,
  });

  // Converte um objeto Aluno em um Map para o Firestore
  Map<String, dynamic> toMap() {
    return {
      'nomeCompleto': nomeCompleto,
      'matricula': matricula,
      'turmaId': turmaId,
    };
  }

  // Cria um objeto Aluno a partir de um Map vindo do Firestore
  factory Aluno.fromMap(String id, Map<String, dynamic> map) {
    return Aluno(
      id: id,
      nomeCompleto: map['nomeCompleto'] ?? '',
      matricula: map['matricula'] ?? '',
      turmaId: map['turmaId'] ?? '',
    );
  }
}