import 'package:app_taxis/models/carrera.dart';
import 'package:app_taxis/models/usuario.dart';
import 'package:app_taxis/services/firebase_taxis.dart';
import 'package:app_taxis/views/menu/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';


class carreraTaxista extends StatefulWidget {
  const carreraTaxista({Key? key, required this.usr}) : super(key: key);
  final usuario usr;
  @override
  State<carreraTaxista> createState() => _carreraTaxistaState(usr);
}

class _carreraTaxistaState extends State<carreraTaxista> {
  List<carrera> carrerasActivas = [];
  final usuario usr;
  final controlPrecio=TextEditingController();
  _carreraTaxistaState(this.usr);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(child: const Icon(Icons.refresh),onPressed: (){
        actualizarLista();
      }),
      appBar: appbar().getAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: carrerasActivas.isNotEmpty?ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) => const Divider(),
            itemCount: carrerasActivas.length,
            itemBuilder: (context, index) => Card(child: Column(
              children: [
                Text("Nombre del Cliente: ${carrerasActivas[index].usuario}"),
                Text("Direccion: ${carrerasActivas[index].direccion}"),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: controlPrecio,
                  decoration: const InputDecoration(
                    hintText: "Precio a Pagar"
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: (){
                      print(controlPrecio.text);
                      firebase_taxis().tomarCarrera(usr, carrerasActivas[index],double.parse(controlPrecio.text));
                    }, child: const Text("Aceptar carrera"))
                  ],
                )
              ],
            )),
          ):const Center(child: Text("No existen carreras disponibles"),),
        ),
      ),
    );
  }

  actualizarLista() async {
    carrerasActivas = await firebase_taxis().obtenerCarreras();
    setState(() {});
  }
}
