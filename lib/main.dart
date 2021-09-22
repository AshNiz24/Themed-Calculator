import 'package:calculator/calcUI.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: CalcUI(),
    theme: ThemeData(
      primaryColor: Colors.white,
      accentColor: Colors.black,
    ),
    debugShowCheckedModeBanner: false,
  ));
}
