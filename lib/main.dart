import 'package:flutter/material.dart';
import 'show.dart'; // Importando o arquivo show.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: CatalogPage(), // Chama a tela do catálogo definida em show.dart
    );
  }
}
