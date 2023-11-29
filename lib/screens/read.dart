import 'package:api_flutter/screens/login.dart';
import 'package:flutter/material.dart';
import 'update.dart';
import 'create.dart';
import 'dart:io';

class Show extends StatefulWidget {
  @override
  _ShowState createState() => _ShowState();
}

class _ShowState extends State<Show> {
  List<Map<String, dynamic>> items = [];

  Future<void> _updateItem(int index) async {
    final updatedItem = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Update(
          item: items[index],
          onUpdate: (int updatedIndex, Map<String, dynamic> updatedItem) {
            setState(() {
              items[updatedIndex] = updatedItem;
            });
          },
          items: items,
        ),
      ),
    );
  }

  Future<void> _createItem() async {
    final newItem = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Create(items: items),
      ),
    );

    if (newItem != null) {
      setState(() {
        items.add(newItem);
      });
    }
  }

  Future<void> _navigateToLogin() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.arrow_back), // Ícone de seta para trás
            SizedBox(width: 8),
            Text('Catálogo'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app), // Ícone de saída
            onPressed: _navigateToLogin,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(File(item['imagePath'])),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Text(
                        item['name'],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _updateItem(index);
                        },
                        child: Icon(Icons.edit, color: Colors.pink),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _createItem();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
