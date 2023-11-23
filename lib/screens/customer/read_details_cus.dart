import 'package:flutter/material.dart';
import 'buy_cus.dart'; // Importe a tela de compra

class ReadDetailsCus extends StatelessWidget {
  final int itemIndex;

  ReadDetailsCus({required this.itemIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Item $itemIndex'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Exibindo detalhes do Item $itemIndex'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BuyCus()),
                );
              },
              child: Text('Comprar'),
            ),
          ],
        ),
      ),
    );
  }
}
