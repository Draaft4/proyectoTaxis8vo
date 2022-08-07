import 'package:app_taxis/models/carrera.dart';
import 'package:app_taxis/models/usuario.dart';
import 'package:app_taxis/services/firebase_taxis.dart';
import 'package:app_taxis/views/menu/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class carreraPage extends StatefulWidget {
  const carreraPage({Key? key, required this.usr, required this.ubiacion})
      : super(key: key);
  final usuario usr;
  final LatLng ubiacion;
  @override
  State<carreraPage> createState() => _carreraPageState(usr, ubiacion);
}

class _carreraPageState extends State<carreraPage> {
  final usuario usr;
  final LatLng ubiacion;

  final controlNombre = TextEditingController();
  final controlDireccion = TextEditingController();

  _carreraPageState(this.usr, this.ubiacion);
  String direccion = '';
  @override
  Widget build(BuildContext context) {
    controlNombre.text = usr.nombre;
    controlDireccion.text = direccion;
    obtenerDireccion();
    return Scaffold(
      appBar: appbar().getAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const Text("A quien esta dirijido el Taxi?"),
              TextField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.account_circle)),
                controller: controlNombre,
              ),
              const SizedBox(
                height: 15.0,
              ),
              const Text("Direccion: "),
              TextField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.gps_fixed)),
                controller: controlDireccion,
              ),
              ElevatedButton.icon(onPressed: (){
                firebase_taxis().registrarCarrera(carrera(id:usr.id,usuario: usr.nombre, direccion: direccion, activo: true, encargado: '',precio: 0));
                Navigator.pop(context);
              }, icon: const Icon(Icons.directions_car_filled_outlined),label: const Text("Solicitar Taxi"))
            ],
          ),
        ),
      ),
    );
  }

  obtenerDireccion() async {
    List placemarks =
        await placemarkFromCoordinates(ubiacion.latitude, ubiacion.longitude);
    Placemark place = placemarks[0];
    direccion =
        '${place.subLocality}, ${place.locality}, ${place.country}';
        setState(() {
          
        });
  }
}
