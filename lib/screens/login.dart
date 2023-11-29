import 'package:api_flutter/screens/read.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Usuário'),
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            ElevatedButton(
              child: Text('Login'),
              onPressed: () {
                String username = usernameController.text;
                String password = passwordController.text;

                if (username == 'vinicius' && password == '123') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Show()),
                  );
                }
                if (username == 'tiago' && password == '123') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Show()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Usuário ou senha inválidos')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
