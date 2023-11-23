import 'package:flutter/material.dart';
import 'login.dart'; // Supondo que este é o arquivo que contém a tela de catálogo

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink, // Define a cor principal como rosa
        // Outras propriedades do tema...
      ),
      home: LoginScreen(), // ou outra tela inicial
    );
  }
}
