import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class appbar{
  final auth = FirebaseAuth.instance;

  PreferredSizeWidget getAppBar(){
    return AppBar(
        title: const Text("Crazy Taxi"),
        backgroundColor: Colors.amber,
      );
  }
}