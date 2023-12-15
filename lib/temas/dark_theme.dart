
import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black12, //colort de la appbar
  ),
  colorScheme: const ColorScheme.dark(
    background: Color.fromARGB(255,39, 55, 77), //color de fondo
    primary: Color.fromARGB(255, 42, 117, 125), //color de elementos
    secondary: Color.fromARGB(255,157, 178, 191), // color de detalles
    tertiary: Color.fromARGB(255,221, 230, 237), //color de letra
    ),
  tabBarTheme: const TabBarTheme(
    indicator: BoxDecoration(
      color: Color.fromARGB(255, 42, 117, 125), // Color del indicador del TabBar
    ),
    labelColor:  Colors.white, // Color del texto de la pestaña activa
    unselectedLabelColor: Colors.white, // Color del texto de la pestaña inactiva

    labelStyle: TextStyle(fontSize: 20), // Estilo del texto de la pestaña activa
    unselectedLabelStyle: TextStyle(fontSize: 20),
    // Estilo del texto de la pestaña inactiva
    //iconTheme: IconThemeData(color: Colors.black), // Color de los iconos de la pestaña
  ),

    datePickerTheme: const DatePickerThemeData(
      cancelButtonStyle: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 42, 117, 125)),
        foregroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 255, 255, 255)),
      ),
      confirmButtonStyle: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 42, 117, 125)),
        foregroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 255, 255, 255)),
      ),

    )

);
    
     