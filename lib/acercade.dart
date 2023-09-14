import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child:const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Efemerides Sonora',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Versión: 1.0',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Desarrollado por',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Descripción: ',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
