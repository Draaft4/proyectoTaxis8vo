import 'package:app_taxis/models/usuario.dart';
import 'package:app_taxis/views/secundarias/carreraTaxista.dart';
import 'package:app_taxis/views/secundarias/carrera_page.dart';
import 'package:app_taxis/views/secundarias/cobradas_page.dart';
import 'package:app_taxis/views/secundarias/pendientes._page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../services/firebase_taxis.dart';

class sideMenu {
  final auth = FirebaseAuth.instance;

  late usuario usr;

  Widget getMenu(context, LatLng ubicacion,bool isTaxista) {
    return isTaxista?menuTaxista(context,ubicacion):menuUsuario(context,ubicacion);
  }

  Widget menuUsuario(context,ubicacion){
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.amber,
              image: DecorationImage(
                image: AssetImage('static/img/banner.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Text('Crazy Taxi App'),
          ),
          ListTile(
            leading: const Icon(Icons.car_rental),
            title: const Text('Solicitar un taxi'),
            onTap: () async{
              await obtenerDatos();
              Navigator.push(context, MaterialPageRoute(builder: (context)  =>  carreraPage(usr: usr,ubiacion: ubicacion),));
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Visualizar Carreras Solicitadas'),
            onTap: () async{
              await obtenerDatos();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => pendientesPage(usr: usr,),));
            },
          ),
          ListTile(
            leading: const Icon(Icons.attach_money),
            title: const Text('Ver carreras cobradas'),
            onTap: () async{
                    await obtenerDatos();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => cobradasPage(usr: usr,),));
            },
          ),
          ListTile(
            leading: const Icon(Icons.close),
            title: const Text('Cerrar Sesion'),
            onTap: () {
              auth.signOut().then(
                  (value) => {Navigator.pushReplacementNamed(context, "/")});
            },
          ),
        ],
      ),
    );
  }

  Widget menuTaxista(context,ubicacion){
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.amber,
              image: DecorationImage(
                image: AssetImage('static/img/banner.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Text('Crazy Taxi App'),
          ),
          ListTile(
            leading: const Icon(Icons.car_rental),
            title: const Text('Visualizar carreras disponibles'),
            onTap: () async{
              await obtenerDatos();
              Navigator.push(context, MaterialPageRoute(builder: (context)  =>   carreraTaxista(usr: usr,),));
            },
          ),
          ListTile(
            leading: const Icon(Icons.close),
            title: const Text('Cerrar Sesion'),
            onTap: () {
              auth.signOut().then(
                  (value) => {Navigator.pushReplacementNamed(context, "/")});
            },
          ),
        ],
      ),
    );
  }

  obtenerDatos()async{
    usr = await firebase_taxis().obtenerUsrMail(auth.currentUser!.email!);
    print(usr.id);
  }

}
