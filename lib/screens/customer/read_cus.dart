import 'package:flutter/material.dart';
import 'read_details_cus.dart'; // Importe a tela de detalhes

class ReadCus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de Leitura'),
      ),
      body: ListView.builder(
        itemCount: 10, // Exemplo com 10 itens
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item $index'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReadDetailsCus(itemIndex: index)),
              );
            },
          );
        },
      ),
    );
  }
}
