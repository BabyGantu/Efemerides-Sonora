import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';

import 'package:tutorial1/modelo/efemerides_fun.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';



void mostrarVentanaFlotante(BuildContext context, EventoHistorico evento) {
  final Size screenSize = MediaQuery.of(context).size;
  final double menuWidth = 200; // Ancho deseado para el menú
  final double menuHeight = 100; // Alto deseado para el menú

  final double left = (screenSize.width - menuWidth) / 2;
  final double top = (screenSize.height - menuHeight) / 2;
  final RelativeRect position = RelativeRect.fromLTRB(left, top, left + menuWidth, top + menuHeight);

  showMenu(
    context: context,
    position: position,
    items: const[
      PopupMenuItem(
        value: 'share',
        child: ListTile(
          leading:  Icon(Icons.share),
          title:  Text('Compartir'),
        ),
      ),
      PopupMenuItem(
        value: 'copy',
        child: ListTile(
          leading: Icon(Icons.copy),
          title:  Text('Copiar'),
        ),
      ),
    ],
  ).then((value) {
    if (value == 'share') {
      _compartirEvento(evento);
    } else if (value == 'copy') {
      _copiarEvento(context,evento);
    }
  });
}


void _copiarEvento(BuildContext context, EventoHistorico evento) {
  initializeDateFormatting('es', null);
  final DateFormat dateFormat = DateFormat('dd MMMM ', 'es');
  final String fecha = dateFormat.format(evento.fecha);
  final String mensaje = 
      '$fecha''${evento.ano}\n\n'
      '${evento.titulo}\n\n'
      '¡Evento histórico compartido con la app Efemerides Sonora "url:"!'
      ;
  Clipboard.setData(ClipboardData(text: mensaje));

  final snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: Color.fromARGB(255, 132, 225, 141),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    content: const Center(
      child: Text(
        'Evento copiado con éxito',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}


void _compartirEvento(EventoHistorico evento) {
  initializeDateFormatting('es', null);
  final DateFormat dateFormat = DateFormat('dd MMMM ', 'es');
  final String fecha = dateFormat.format(evento.fecha);
  final String mensaje = 
      '$fecha''${evento.ano}\n\n'
      '${evento.titulo}\n\n'
      '¡Evento histórico del estado de Sonora compartido con la app Efemerides Sonora "url:"!'
      ;
  Share.share(mensaje);
}

void compartirApp() {
  const  String playStoreLink = 'https://play.google.com/store/apps/details?id=<ID DE APP>'; // Reemplazar 'tu_package_name'
  const  String mensaje = 
    '$playStoreLink\n\n'
    'Descarga nuestra app para estar al tanto de los eventos mas importantes de sonora!';
  Share.share(mensaje);
}