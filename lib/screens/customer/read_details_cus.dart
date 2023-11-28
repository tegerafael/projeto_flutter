import 'package:api_flutter/main.dart';
import 'package:api_flutter/screens/customer/buy_cus.dart';
import 'package:flutter/material.dart';

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
                  MaterialPageRoute(
                      builder: (context) =>
                          Cep()),
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
