import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciamento de Alunos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bem-vindo ao Gerenciamento de Alunos'),
        ),
        body: Center(
          child: Text('Tela inicial do aplicativo de gerenciamento de alunos.'),
        ),
      ),
    );
  }
}
