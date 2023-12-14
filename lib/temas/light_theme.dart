
import 'package:flutter/material.dart';


ThemeData lightTheme=ThemeData(
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 243, 238, 234), //colort de la appbar
  ),
  colorScheme: const ColorScheme.light(
    //background: Color.fromARGB(255, 116, 112, 106), //color de fondo
    primary: Color.fromARGB(255, 218, 217, 217), //color de elementos
    secondary: Color.fromARGB(255,236, 179, 144), // color de detalles
    tertiary: Colors.black, //color de letra
    onPrimary: Color.fromARGB(255, 149, 138, 127)
    ),
  tabBarTheme: const TabBarTheme(
    indicator: BoxDecoration(
      color: Color.fromARGB(255, 244, 191, 150), // Color del indicador del TabBar
    ),
    labelColor:  Colors.black, // Color del texto de la pestaña activa
    unselectedLabelColor: Colors.black, // Color del texto de la pestaña inactiva

    labelStyle: TextStyle(fontSize: 20), // Estilo del texto de la pestaña activa
    unselectedLabelStyle: TextStyle(fontSize: 20),
    // Estilo del texto de la pestaña inactiva
    //iconTheme: IconThemeData(color: Colors.black), // Color de los iconos de la pestaña
  ),

);
    
     