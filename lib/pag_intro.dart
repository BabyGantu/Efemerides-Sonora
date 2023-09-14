
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tutorial1/main.dart';
import 'package:tutorial1/pant_intro/intro_pan_1.dart';
import 'package:tutorial1/pant_intro/intro_pan_2.dart';
import 'package:tutorial1/pant_intro/intro_pan_3.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PagIntro extends StatefulWidget {
  const PagIntro({Key? key}) : super(key: key);

  @override
  State<PagIntro> createState() => _PagIntroState();
}

class _PagIntroState extends State<PagIntro> {
  // Controlador para el PageView
  PageController _controller = PageController();
  bool onLastPage = false;

  @override
  void initState() {
    super.initState();
    _checkIfFirstTime();
  }

  void _checkIfFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    //bool isFirstTime = true;

    if (isFirstTime) {
      // Es la primera vez que se abre la aplicación
      // Guardar el valor para indicar que ya se mostró la página de introducción
      await prefs.setBool('isFirstTime', false);
    } else {
      // No es la primera vez, redirigir a la página principal
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PagPrincipal()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [
              PantIntro1(),
              PantIntro2(),
              PantIntro3(),
            ],
          ),

          Positioned(
            bottom: 20.0, // Ajusta esta posición según tus necesidades
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _controller.jumpToPage(2);
                    },
                    child: Text('Saltar'),
                  ),
                  SmoothPageIndicator(controller: _controller, count: 3),
                  onLastPage
                      ? ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => PagPrincipal()),
                      );
                    },
                    child: Text('Listo'),
                  )
                      : ElevatedButton(
                    onPressed: () {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    child: Text('Siguiente'),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
