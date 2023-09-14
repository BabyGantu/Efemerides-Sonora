import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class PantIntro1 extends StatelessWidget {
  const PantIntro1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[30],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            Lottie.asset(
              'assets/animaciones/alguienleyendo.json',
              // Ajusta la altura de la animación según sea necesario
            ),
            const SizedBox(
              height: 60,
            ),
// Espacio vertical entre la animación y el texto
          Padding(
              padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Text(
                  '¡Cientos de Efemérides en un solo lugar!',
                  style: TextStyle(
                    fontSize:
                    38, // Ajusta el tamaño de la fuente según sea necesario
                    color: Colors.orangeAccent, // Color de fuente anaranjado
                    fontWeight: FontWeight.bold, // Fuente en negrita
                  ),
                ),
              ],
            ),
          )

          ],
        ),
      ),
    );
  }
}
