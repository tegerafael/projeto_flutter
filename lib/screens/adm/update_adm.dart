import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

class UpdateScreen extends StatefulWidget {
  final Map<String, dynamic> item;
  final Function(Map<String, dynamic>)? onUpdate;

  UpdateScreen({required this.item, this.onUpdate});

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _kgController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _image;

  @override
  void initState() {
    super.initState();

    // Preencha os controladores de texto e a imagem com os dados do item
    _nameController.text = widget.item['name'];
    _kgController.text = widget.item['kg'];
    _descriptionController.text = widget.item['description'];
    _image = File(widget.item['imagePath']);
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Future<void> _updateItem() async {
    // Lógica para atualizar os dados do item
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final file = File('$path/saved_data.json');

    final updatedItem = {
      'name': _nameController.text,
      'kg': _kgController.text,
      'description': _descriptionController.text,
      'imagePath': _image != null ? _image!.path : '',
    };

    // Lógica para salvar os dados atualizados no arquivo
    final jsonData = json.encode(updatedItem);
    await file.writeAsString(jsonData);

    if (widget.onUpdate != null) {
      widget.onUpdate!(updatedItem);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Item atualizado com sucesso!')),
    );

    Navigator.pop(context); // Volta para a tela anterior após a atualização
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Atualizar Item'),
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
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: Icon(Icons.image),
              label: Text('Selecionar Nova Imagem'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateItem,
              child: Text('Atualizar Item'),
            ),
          ],
        ),
      ),
    );
  }
}
