import 'package:app_taxis/models/carrera.dart';
import 'package:app_taxis/models/usuario.dart';
import 'package:app_taxis/services/firebase_taxis.dart';
import 'package:app_taxis/views/menu/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';


class cobradasPage extends StatefulWidget {
  const cobradasPage({Key? key, required this.usr}) : super(key: key);
  final usuario usr;
  @override
  State<cobradasPage> createState() => _cobradasPageState(usr);
}

class _cobradasPageState extends State<cobradasPage> {
  final usuario usr;
  
  List<carrera> carreras = [];
  _cobradasPageState(this.usr);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(child: const Icon(Icons.refresh),onPressed: () {
        actualizarLista();
      }),
      appBar: appbar().getAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: carreras.isNotEmpty
              ? ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: carreras.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                      children: [
                          Text("Nombre del Cliente: ${carreras[index].usuario}"),
                          Text("Direccion: ${carreras[index].direccion}"),
                          Text("Encargado: ${carreras[index].encargado}"),
                          Text("Precio cobrado: ${carreras[index].precio}"),
                      ],
                    ),
                        )),
                  ),
                )
              : const Center(
                  child: Text("No existen carreras disponibles"),
                ),
        ),
      ),
    );
  }

  actualizarLista() async {
    carreras = await firebase_taxis().obtenerPagadas(usr.id);
    setState(() {});
  }

}