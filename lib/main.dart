import 'package:flutter/material.dart';
import 'cep_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Consulta de CEP'),
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
  Map<String, dynamic> cepInfo = {};

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              });
            },
            child: const Text('Consultar CEP'),
          ),
          const SizedBox(height: 50),
          const Text('Endereço:'),
          Text('CEP: ${cepInfo['cep']}'),
          Text('Logradouro: ${cepInfo['logradouro']}'),
          Text('Bairro: ${cepInfo['bairro']}'),
          Text('Cidade: ${cepInfo['localidade']}'),
          Text('Estado: ${cepInfo['uf']}'),
        ],
      ),
    );
  }
}
