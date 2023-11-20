import 'package:flutter/material.dart';

// Tela do Catálogo
class CatalogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catálogo'),
      ),
      body: ListView.builder(
        itemCount: 10, // Número de cards no catálogo
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailPage()),
              );
            },
            child: Card(
              child: Container(
                height: 200, // Altura do espaço reservado para a imagem
                color: Colors.grey, // Cor do espaço reservado (cinza)
              ),
            ),
          );
        },
      ),
    );
  }
}

// Tela de Detalhes
class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes'),
      ),
      body: Center(
        child: Text('Página de Detalhes'),
      ),
    );
  }
}
