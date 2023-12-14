import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import 'package:tutorial1/datos/efemerides_nac.dart';
import 'package:tutorial1/modelo/efemerides_fun.dart';
import 'package:tutorial1/ventanacompartir.dart';
import 'package:tutorial1/main.dart';

class PagNacimientos extends StatefulWidget {
  final DateTime? fechaElegida;
  final double fontSize;

  const PagNacimientos({Key? key, this.fechaElegida, required this.fontSize})
      : super(key: key);

  @override
  _PagNacimientosState createState() => _PagNacimientosState();
}

class _PagNacimientosState extends State<PagNacimientos> {
  late final Function(bool) actualizarNotNac;
  List<EventoHistorico> getEventosFiltrados() {
    if (widget.fechaElegida == null) {
      return eventosNacimientos;
    } else {
      return eventosNacimientos
          .where((evento) =>
              evento.fecha.month == widget.fechaElegida!.month &&
              evento.fecha.day == widget.fechaElegida!.day)
          .toList();
    }
  }

  String capitalize(String s) {
    if (s == null || s.isEmpty) {
      return s;
    }
    return s[0].toUpperCase() + s.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final eventosFiltrados = getEventosFiltrados();

    List<Widget> listViewItems = [];

    // Agrupar eventos por mes
    Map<int, List<EventoHistorico>> eventosPorMes = {};
    for (final evento in eventosFiltrados) {
      final month = evento.fecha.month;
      if (!eventosPorMes.containsKey(month)) {
        eventosPorMes[month] = [];
      }
      eventosPorMes[month]!.add(evento);

    }

    // Construir lista de widgets
    eventosPorMes.forEach((month, eventos) {
      if (widget.fechaElegida != null) {
        // Encabezado con día seleccionado


        final selectedDate = widget.fechaElegida!;
        listViewItems.add(
          Card(
            color: Theme.of(context).colorScheme.primary,
            child: ListTile(
              title: Center(
                child: Text(
                  capitalize(DateFormat('d MMMM ', 'es').format(selectedDate))
                      .replaceAllMapped(RegExp(r'(^\w)|(\s\w)'),
                          (match) => match.group(0)!.toUpperCase()),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
            ),
          ),
        );
      } else {
        // Encabezado del mes
        listViewItems.add(
          Card(
            color: Theme.of(context).colorScheme.primary,
            child: ListTile(
              title: Center(
                child: Text(
                  capitalize(DateFormat('MMMM ', 'es')
                      .format(DateTime(DateTime.now().year, month))),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
            ),
          ),
        );
      }

      // Eventos del mes
      eventos.forEach((evento) {
        listViewItems.add(
          Card(
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
              leading: CircleAvatar(
                radius: 22,
                backgroundColor: Theme.of(context).colorScheme.primary,
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
                  fontSize: widget.fontSize,
                  color: Theme.of(context).colorScheme.tertiary,
                  letterSpacing: -0.6,
                ),
              ),
              title: Text(
                DateFormat('dd/MMMM/yyyy', 'es').format(evento.fecha),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  //color:Colors.black,
                ),
              ),
              onLongPress: () {
                mostrarVentanaFlotante(context, evento);
              },
            ),
          ),
        );
      });
    });

    return listViewItems.isEmpty
        ? Center(
            child: Text('No se encontraron nacimientos con esta fecha'),
          )
        : ListView.builder(
            itemCount: listViewItems.length,
            itemBuilder: (context, index) {
              return listViewItems[index];
            },
          );
  }
}
