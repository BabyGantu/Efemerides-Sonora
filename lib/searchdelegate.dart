import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:tutorial1/ventanacompartir.dart';
import 'modelo/efemerides_fun.dart';

class EventoSearchDelegate extends SearchDelegate<EventoHistorico> {
  double _fontSize =16.0;

  final List<EventoHistorico> eventosAcontecimientos;
  final List<EventoHistorico> eventosDefunciones;
  final List<EventoHistorico> eventosNacimientos;

  EventoSearchDelegate({
    required this.eventosAcontecimientos,
    required this.eventosDefunciones,
    required this.eventosNacimientos,
  });
  String removeAccents(String text) {
    final accentMap = {
      'á': 'a',
      'é': 'e',
      'í': 'i',
      'ó': 'o',
      'ú': 'u',
      'Á': 'A',
      'É': 'E',
      'Í': 'I',
      'Ó': 'O',
      'Ú': 'U',
      // Agrega más mapeos
    };

    final normalizedText = StringBuffer();

    for (var i = 0; i < text.length; i++) {
      final character = text[i];
      final replacement = accentMap[character] ?? character;
      normalizedText.write(replacement);
    }

    return normalizedText.toString();
  }

  @override
  String get searchFieldLabel => 'Buscar eventos...';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    final EventoHistorico defaultEvento = EventoHistorico(
      titulo: '',
      ano: 0,
      fecha: DateTime.now(),
    );
    return IconButton(
      onPressed: () {
        close(context, defaultEvento);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    
    final List<EventoHistorico> resultados = []
      ..addAll(eventosAcontecimientos)
      ..addAll(eventosDefunciones)
      ..addAll(eventosNacimientos);

    final List<EventoHistorico> filteredResults = resultados
        .where((evento) => removeAccents(evento.titulo.toLowerCase())
            .contains(removeAccents(query.toLowerCase())))
        .toList();

    return ListView.builder(
      itemCount: filteredResults.length,
      itemBuilder: (context, index) {
        EventoHistorico evento = filteredResults[index];
    
        return Card(
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
                fontSize: _fontSize,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            title: Text(DateFormat('dd/MMMM/yyyy', 'es').format(evento.fecha),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                )),
            onLongPress: () {
              mostrarVentanaFlotante(
                context,
                evento,
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<EventoHistorico> sugerencias = []
      ..addAll(eventosAcontecimientos)
      ..addAll(eventosDefunciones)
      ..addAll(eventosNacimientos);

    final List<EventoHistorico> filteredSuggestions = sugerencias
        .where((evento) => removeAccents(evento.titulo.toLowerCase())
            .contains(removeAccents(query.toLowerCase())))
        .toList();

    return ListView.builder(
      itemCount: filteredSuggestions.length,
      itemBuilder: (context, index) {
        EventoHistorico evento = filteredSuggestions[index];
        return Card(
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
                fontSize: _fontSize,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            title: Text(DateFormat('dd/MMMM/yyyy', 'es').format(evento.fecha),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                )),
            onTap: () {
              mostrarVentanaFlotante(
                context,
                evento,
              );
            },
          ),
        );
      },
    );
  }
}
