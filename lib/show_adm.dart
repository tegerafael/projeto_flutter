import 'package:flutter/material.dart';
import 'update.dart'; // Certifique-se de que o caminho esteja correto
import 'create.dart'; // Importe a tela de criação

// Tela do Catálogo
class ShowAdm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                Container(
                  height: 200,
                  color: Colors.grey,
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UpdateScreen()),
                      );
                    },
                    child: Icon(Icons.edit, color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateScreen()),
          );
        },
        child: Icon(Icons.add), // Ícone de adição
        backgroundColor: Colors.pink, // Cor do botão
      ),
    );
  }
}
