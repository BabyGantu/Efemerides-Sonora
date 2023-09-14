
import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black12, //colort de la appbar
  ),
  colorScheme: ColorScheme.dark(
    background: Color.fromARGB(255,39, 55, 77), //color de fondo
    primary: Color.fromARGB(255, 42, 117, 125), //color de elementos
    secondary: Color.fromARGB(255,157, 178, 191), // color de detalles
    tertiary: Color.fromARGB(255,221, 230, 237), //color de letra
    ),
   
    

);
    
     