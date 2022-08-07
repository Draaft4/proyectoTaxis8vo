import 'package:app_taxis/models/usuario.dart';
import 'package:app_taxis/services/firebase_taxis.dart';
import 'package:app_taxis/views/menu/appbar.dart';
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
  bool isTaxista = false;
  final fb = firebase_taxis();

  final appb = appbar();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: appb.getAppBar(),
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
              usuario usr = await firebase_taxis().obtenerUsrMail(controlEmail.text);
              if(usr.taxista){
                final credential = await FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: controlEmail.text, password: controlPass.text)
                  .then((value) => {
                        Navigator.pushReplacementNamed(context, "/homeT"),
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Bienvenido: ${usr.nombre}"),
                        ))
                      });
              }else{
                final credential = await FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: controlEmail.text, password: controlPass.text)
                  .then((value) => {
                        Navigator.pushReplacementNamed(context, "/home"),
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Bienvenido: ${usr.nombre}"),
                        ))
                      });
              }
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
    final controlNombre = TextEditingController();

    return Column(
      children: [
        TextField(
            controller: controlNombre,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 5),
                ),
                hintStyle: TextStyle(color: Colors.white),
                hintText: "Nombre",
                filled: true,
                fillColor: Color.fromARGB(255, 30, 34, 33)),
            keyboardType: TextInputType.emailAddress),
        SizedBox(height: pad),
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
        Row(
          children: <Widget>[
            const Text(
              "Es usted un Taxista?",
              style: TextStyle(color: Colors.white),
            ),
            Checkbox(
                fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Colors.orange.withOpacity(.32);
                  }
                  return Colors.orange;
                }),
                value: isTaxista,
                onChanged: (bool? value) {
                  toogleTaxista(value!);
                })
          ],
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
              fb.registarUsario(usuario(id:"",
                  correo: controlEmail.text,
                  nombre: controlNombre.text,
                  taxista: isTaxista));
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

  void toogleTaxista(bool value) {
    setState(() {
      isTaxista = value;
    });
  }

  void toogleRegistro() {
    setState(() {
      print("cambiando de estado");
      registro = !registro;
    });
  }
}
