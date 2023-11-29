import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'update_adm.dart'; // Certifique-se de que o caminho esteja correto
import 'create_adm.dart'; // Importe a tela de criação

class ShowAdm extends StatefulWidget {
  @override
  _ShowAdmState createState() => _ShowAdmState();
}

class _ShowAdmState extends State<ShowAdm> {
  List<Map<String, dynamic>> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo'),
      ),
      body: ListView.builder(
        itemCount: items.length,
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
                        MaterialPageRoute(
                            builder: (context) =>
                                UpdateScreen(item: items[index])),
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
        onPressed: () async {
          final newItem = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateScreen()),
          );

          if (newItem != null) {
            setState(() {
              items.add(newItem);
            });
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _kgController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _image;

  Future<Map<String, dynamic>> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }

    return {
      'imagePath': _image != null ? _image!.path : '',
    };
  }

  Future<Map<String, dynamic>> _saveItem() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final file = File('$path/saved_data.json');

    final itemData = {
      'name': _nameController.text,
      'kg': _kgController.text,
      'description': _descriptionController.text,
      ...await _pickImage(),
    };

    final jsonData = json.encode(itemData);
    await file.writeAsString(jsonData);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Item salvo com sucesso!')),
    );

    return itemData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Novo Item'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _kgController,
              decoration: InputDecoration(labelText: 'Peso em Kg'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descrição'),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            if (_image != null)
              Container(
                width: double.infinity,
                height: 200,
                child: Image.file(_image!, fit: BoxFit.cover),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final createdItem = await _saveItem();
                Navigator.pop(context, createdItem);
              },
              child: Text('Criar Item'),
            ),
          ],
        ),
      ),
    );
  }
}
