import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
          child: ListView(children: [
            Container(
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
          ]),
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
          child: const Text("Registrarse"),
        )
      ],
    );
  }

  Widget btnRegistro() {
    return Row(
      children: [
        TextButton(
            onPressed: toogleRegistro,
            child: const Text(
              "Iniciar Sesion",
            )),
        const Text(
          "o ",
          style: TextStyle(color: Colors.white),
        ),
        const Text(
          "Registrarse",
          style: TextStyle(color: Colors.amber),
        )
      ],
    );
  }

  Widget loginWg() {
    final controlEmail = TextEditingController();
    final controlPass = TextEditingController();

    return Column(
      children: [
        TextField(
            controller: controlEmail,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
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
        TextField(
          controller: controlPass,
          style: const TextStyle(color: Colors.white),
          obscureText: true,
          decoration: const InputDecoration(
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
          onPressed: () async {
            try {
              final credential = await FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: controlEmail.text, password: controlPass.text)
                  .then((value) =>
                      {Navigator.pushReplacementNamed(context, "/home")});
            } on FirebaseAuthException catch (e) {
              if (e.code == 'user-not-found') {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Error: El usuario inicado no existe."),
                ));
              } else if (e.code == 'wrong-password') {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content:
                      Text("Error: La contraseña indicada no es correcta."),
                ));
              }
            }
          },
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
    final controlEmail = TextEditingController();
    final controlPass = TextEditingController();
    return Column(
      children: [
        TextField(
            controller: controlEmail,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
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
        TextField(
          controller: controlPass,
          style: const TextStyle(color: Colors.white),
          obscureText: true,
          decoration: const InputDecoration(
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
          onPressed: () async {
            print("Registrando ${controlEmail.text} ${controlPass.text}");
            try {
              final credential = await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                    email: controlEmail.text,
                    password: controlPass.text,
                  )
                  .then((value) => {print("registrado")});
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                      "Error: La contraseña debe contener 12 caracteres entre letras y signos."),
                ));
              } else if (e.code == 'email-already-in-use') {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Error: Ya existe una cuenta con ese correo."),
                ));
              }
            } catch (e) {
              print(e);
            }
            toogleRegistro();
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.amber,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          ),
          child: const Text("Registrarse"),
        ),
      ],
    );
  }

  void toogleRegistro() {
    setState(() {
      print("cambiando de estado");
      registro = !registro;
    });
  }
}
