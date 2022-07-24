import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool registro = false;
  final double pad = 25.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crazy Taxi"),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Container(
            alignment: Alignment.center,
            child: Column(children: [
              SizedBox(
                  width: 150,
                  height: 150,
                  child: Image.asset("static/img/gpsTaxi.png")),
              SizedBox(height: pad / 2),
              registro ? btnRegistro() : btnInicioSesion(),
              registro ? registroWg() : loginWg(),
            ]),
          ),
        ),
      ),
    );
  }

  Widget btnInicioSesion() {
    return Row(
      children: [
        const Text(
          "Iniciar Sesion",
          style: TextStyle(color: Colors.amber),
        ),
        const Text(
          " o",
          style: TextStyle(color: Colors.white),
        ),
        TextButton(
          onPressed: toogleRegistro,
          child:const Text("Registrarse"),
        )
      ],
    );
  }

  Widget btnRegistro() {
    return Row(
      children: [
        TextButton(onPressed: toogleRegistro, child: const Text("Iniciar Sesion",)),
        const Text("o ",style: TextStyle(color: Colors.white),),
        const Text("Registrarse", style: TextStyle(color: Colors.amber),)
      ],
    );
  }

  Widget loginWg() {
    return Column(
      children: [
        const TextField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 5),
                ),
                hintStyle: TextStyle(color: Colors.white),
                hintText: "Correo electronico",
                filled: true,
                fillColor: Color.fromARGB(255, 30, 34, 33)),
            keyboardType: TextInputType.emailAddress),
        SizedBox(height: pad),
        const TextField(
          style: TextStyle(color: Colors.white),
          obscureText: true,
          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 5),
              ),
              hintStyle: TextStyle(color: Colors.white),
              hintText: "Contraseña",
              filled: true,
              fillColor: Color.fromARGB(255, 30, 34, 33)),
        ),
        SizedBox(height: pad),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            primary: Colors.amber,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          ),
          child: const Text("Iniciar Sesion"),
        ),
      ],
    );
  }

  Widget registroWg() {
    return Column(
      children: [Container()],
    );
  }

  void toogleRegistro(){
    setState(() {
      registro = !registro;
    });
  }
}
