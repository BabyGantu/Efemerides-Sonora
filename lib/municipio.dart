import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:tutorial1/ventanacompartir.dart';
import 'modelo/efemerides_fun.dart';

import 'datos/efemerides_acont.dart';
import 'datos/efemerides_muer.dart';
import 'datos/efemerides_nac.dart';

class MunicipioPage extends StatefulWidget {
  final double tam_letra;
  MunicipioPage(this.tam_letra);


  @override
  _MunicipioState createState() => _MunicipioState();
}


class _MunicipioState extends State<MunicipioPage> {


  @override
  Widget build(BuildContext context) {
    // Filtrar eventos que contienen "Cajeme" en el título
    List<EventoHistorico> eventosFiltrados = eventosAcontecimientos
        .where((evento) => evento.titulo.toLowerCase().contains('cajeme'))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Municipio'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(7.0),
          child: Column(
            children: eventosFiltrados.map((evento) {
              return Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    mostrarVentanaFlotante(
                      context,
                      evento,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 6.0,
                      horizontal: 16.0,
                    ),
                    leading: CircleAvatar(
                      radius: 22,
                      backgroundColor:
                      Theme.of(context).colorScheme.primary,
                      child: Text(
                        '${evento.ano}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ),
                    subtitle: Text(
                      evento.titulo,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: widget.tam_letra,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    title: Text(
                      DateFormat('dd/MMMM/yyyy', 'es')
                          .format(evento.fecha),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        //color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }



}
