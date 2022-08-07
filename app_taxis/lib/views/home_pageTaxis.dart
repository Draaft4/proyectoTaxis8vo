import 'dart:async';
import 'dart:developer';

import 'package:app_taxis/services/firebase_taxis.dart';
import 'package:app_taxis/views/menu/sidemenu.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/usuario.dart';
import 'menu/appbar.dart';

class HomeTaxisPage extends StatefulWidget {
  const HomeTaxisPage({Key? key}) : super(key: key);

  @override
  State<HomeTaxisPage> createState() => _HomeTaxisPageState();
}

class _HomeTaxisPageState extends State<HomeTaxisPage> {
  final auth = FirebaseAuth.instance;

  final appb = appbar();

  late GoogleMapController mapsController;

  LatLng posicion = LatLng(-2.8974, -79.0045);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: sideMenu().getMenu(context, posicion,true),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _getCurrentLocation();
          },
          child: const Icon(Icons.gps_fixed)),
      appBar: appb.getAppBar(),
      body: GoogleMap(
        onMapCreated: (controller) {
          mapsController = controller;
        },
        initialCameraPosition:
            const CameraPosition(target: LatLng(-2.8974, -79.0045), zoom: 15.0),
        markers: {
          Marker(markerId: const MarkerId("actual"), position: posicion)
        },
      ),
    );
  }

  _getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    permission = await Geolocator.requestPermission();
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        posicion = LatLng(position.latitude, position.longitude);
        mapsController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: posicion, zoom: 17.0)));
      });
    }).catchError((e) {
      print(e);
    });
  }
}
