import 'package:flutter/material.dart';

late bool cargando;

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    cargando = true;
    cargarDatos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Column(
            children: [
              SizedBox(
                width: 300,
                height: 500,
                child: Image.asset('static/img/logo.png'),
              ),
              const CircularProgressIndicator(),
            ],
          )),
        ],
      ),
    );
  }

  cargarDatos() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      cargando = !cargando;
    });
    navegar();
  }

  navegar() async {
    Navigator.pushReplacementNamed(context, '/login');
  }
}
