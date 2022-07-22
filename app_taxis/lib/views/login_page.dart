import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crazy Taxi"),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Container(
          alignment: Alignment.center,
          child: Column(children: [
            campoDeTexto(),
            const SizedBox(height: 50),
            campoDeTexto(),
            const TextButton(
                onPressed: _onPresedInit, child: Text("Iniciar Sesion")),
          ]),
        ),
      ),
    );
  }
}

_onPresedInit() {}

Widget campoDeTexto() {
  return const TextField(
    decoration: InputDecoration(hintText: ""),
  );
}
