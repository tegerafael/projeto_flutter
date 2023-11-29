import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CepService {
  final String baseUrl = 'https://viacep.com.br/ws/';

  Future<Map<String, dynamic>> fetchCepInfo(String cep) async {
    final response = await http.get(Uri.parse('$baseUrl$cep/json'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao buscar o CEP');
    }
  }
}

class Cep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.pink),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Entrega'),
        ),
        body: CepSearchPage(),
      ),
    );
  }
}

class CepSearchPage extends StatefulWidget {
  @override
  _CepSearchPageState createState() => _CepSearchPageState();
}

class _CepSearchPageState extends State<CepSearchPage> {
  final cepController = TextEditingController();
  TextEditingController logradouroController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController estadoController = TextEditingController();
  Map<String, dynamic> cepInfo = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: cepController,
                decoration: const InputDecoration(labelText: 'CEP'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final cep = cepController.text;
                  final service = CepService();
                  final info = await service.fetchCepInfo(cep);
                  setState(() {
                    cepInfo = info;
                    logradouroController.text = cepInfo['logradouro'] ?? '';
                    bairroController.text = cepInfo['bairro'] ?? '';
                    cidadeController.text = cepInfo['localidade'] ?? '';
                    estadoController.text = cepInfo['uf'] ?? '';
                  });
                },
                child: const Text('Consultar CEP'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: logradouroController,
                decoration: const InputDecoration(labelText: 'Logradouro'),
              ),
              TextField(
                controller: bairroController,
                decoration: const InputDecoration(labelText: 'Bairro'),
              ),
              TextField(
                controller: cidadeController,
                decoration: const InputDecoration(labelText: 'Cidade'),
              ),
              TextField(
                controller: estadoController,
                decoration: const InputDecoration(labelText: 'Estado'),
              ),
              const SizedBox(height: 30),
              Text(
                'Cliente: Vinicius',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),
              Text('Produtos: Bolo de Morango', style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
