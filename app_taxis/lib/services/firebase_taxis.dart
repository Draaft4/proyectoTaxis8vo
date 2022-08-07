import 'package:app_taxis/models/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/carrera.dart';

class firebase_taxis {
  var db = FirebaseFirestore.instance;

  void registarUsario(usuario usr) {
    db.collection("usuarios").add(usr.toJson());
  }

  Future<usuario> obtenerUsrMail(String correo) async {
    usuario usr = usuario(id: "", correo: correo, nombre: "", taxista: false);
    await db
        .collection("usuarios")
        .where("correo", isEqualTo: correo)
        .get()
        .then(
            (QuerySnapshot querySnapshot) => querySnapshot.docs.forEach((data) {
                  usr = usuario(
                      id: data.id,
                      correo: data["correo"],
                      nombre: data["nombre"],
                      taxista: data["taxista"]);
                }));
    return usr;
  }

  void registrarCarrera(carrera c) {
    db.collection("carrera").add(c.toJson());
  }

  Future<List<carrera>> obtenerCarreras() async {
    List<carrera> carreras = [];
    await db.collection("carrera").get().then(
        (QuerySnapshot querySnapshot) => querySnapshot.docs.forEach((data) {
              String usuario = data["usuario"];
              String direccion = data["direccion"];
              String encargado = data["encargado"];
              bool activo = data["activo"];
              if (activo) {
                carreras.add(carrera(
                    id: data.id,
                    encargado: encargado,
                    usuario: usuario,
                    direccion: direccion,
                    activo: activo,
                    precio: 0));
              }
            }));
    return carreras;
  }

  tomarCarrera(usuario taxista, carrera seleccionada, double precio) async {
    await db.collection("carrera").doc(seleccionada.id).update(
        {"encargado": taxista.nombre, "activo": false, "precio": precio});
  }

  Future<List<carrera>> obtenerPendientes(String id) async {
    List<carrera> carreras = [];
    await db.collection("carrera").get().then(
        (QuerySnapshot querySnapshot) => querySnapshot.docs.forEach((data) {
              if (data["id"] == id) {
                String usuario = data["usuario"];
                String direccion = data["direccion"];
                String encargado = data["encargado"];
                bool activo = data["activo"];
                if (activo) {
                  carreras.add(carrera(
                      id: data.id,
                      encargado: encargado,
                      usuario: usuario,
                      direccion: direccion,
                      activo: activo,
                      precio: 0));
                }
              }
            }));
    return carreras;
  }
  Future<List<carrera>> obtenerPagadas(String id) async {
    List<carrera> carreras = [];
    await db.collection("carrera").get().then(
        (QuerySnapshot querySnapshot) => querySnapshot.docs.forEach((data) {
              if (data["id"] == id) {
                String usuario = data["usuario"];
                String direccion = data["direccion"];
                String encargado = data["encargado"];
                bool activo = data["activo"];
                double precio = data["precio"];
                if (!activo) {
                  carreras.add(carrera(
                      id: data.id,
                      encargado: encargado,
                      usuario: usuario,
                      direccion: direccion,
                      activo: activo,
                      precio: precio));
                }
              }
            }));
    return carreras;
  }
}
