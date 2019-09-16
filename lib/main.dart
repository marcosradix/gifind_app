import 'package:flutter/material.dart';
import 'package:gifind_app/ui/homePage.dart';

void main(){
  runApp(MaterialApp(
    home: HomePage(),
    title: "GifindApp",
    theme: ThemeData(
      inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    ),
  )));
}
