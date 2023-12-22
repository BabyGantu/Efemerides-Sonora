import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';

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


    List<String> alfabeto = List.generate(26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index));

    return Scaffold(
      appBar: AppBar(
        title: Text('Municipio'),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(top: 10.0, left: 20,bottom: 50,right: 20),
            child: Column(
              children: [
                Padding(padding: EdgeInsets.all(8.0),
                  child: Text("Seleccione la letra inicial del municipio",
                  style: TextStyle(fontSize: widget.tam_letra+3,fontWeight: FontWeight.bold)),
                ),
                Container(
                  height: 655, // Establece la altura deseada
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 7.0,
                      mainAxisSpacing: 7.0,
                    ),
                    itemCount: alfabeto.length,
                    itemBuilder: (context, index) => ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MunicipioFiltradoLetra(
                              letra: alfabeto[index],
                              tam_letra: widget.tam_letra,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(5.0),
                      ),
                      child: Text(
                        alfabeto[index],
                        style: TextStyle(
                          fontSize: widget.tam_letra,fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

        ),
      ),
    );
  }
}

class MunicipioFiltradoLetra extends StatelessWidget {
  final String letra;
  final double tam_letra;

   MunicipioFiltradoLetra({required this.tam_letra, required this.letra});

  @override
  final List<String> municipios = [
    'Aconchi',
    'Agua Prieta',
    'Alamos',
    'Altar',
    'Arivechi',
    'Arizpe',
    'Atil',
    'Bacadéhuachi',
    'Bacanora',
    'Bacerac',
    'Bacoachi',
    'Bácum',
    'Banámichi',
    'Baviácora',
    'Bavispe',
    'Benjamín Hill',
    'Caborca',
    'Cajeme',
    'Cananea',
    'Carbó',
    'La Colorada',
    'Cucurpe',
    'Cumpas',
    'Divisaderos',
    'Empalme',
    'Etchojoa',
    'Fronteras',
    'Granados',
    'Guaymas',
    'Hermosillo',
    'Huachinera',
    'Huásabas',
    'Huatabampo',
    'Huépac',
    'Imuris',
    'Magdalena',
    'Mazatán',
    'Moctezuma',
    'Naco',
    'Nácori Chico',
    'Nacozari de García',
    'Navojoa',
    'Nogales',
    'Ónavas',
    'Opodepe',
    'Oquitoa',
    'Pitiquito',
    'Puerto Peñasco',
    'Quiriego',
    'Rayón',
    'Rosario',
    'Sahuaripa',
    'San Felipe de Jesús',
    'San Javier',
    'San Luis Río Colorado',
    'San Miguel de Horcasitas',
    'San Pedro de la Cueva',
    'Santa Ana',
    'Santa Cruz',
    'Sáric',
    'Soyopa',
    'Suaqui Grande',
    'Tepache',
    'Trincheras',
    'Tubutama',
    'Ures',
    'Villa Hidalgo',
    'Villa Pesqueira',
    'Yécora',
    'General Plutarco Elías Calles',
    'Benito Juárez',
    'San Ignacio Río Muerto',
  ];

  Widget build(BuildContext context) {

    List<String> municipiosFiltrados = municipios
        .where((municipio) => municipio.startsWith(letra))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Municipio con la letra: ${letra}'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 10.0,right: 25,left: 25,bottom:10 ),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(8.0),
                child: Text("Seleccione un municipio",
                    style: TextStyle(fontSize: tam_letra+3,fontWeight: FontWeight.bold)),
              ),
              Container(
                height: 700, // Establece la altura deseada
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 7.0,
                      mainAxisSpacing: 7.0,
                      mainAxisExtent: 50,
                      childAspectRatio: 2
                  ),
                  itemCount: municipiosFiltrados.length,
                  itemBuilder: (context, index) => ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MunicipioFiltrado(
                            tam_letra: tam_letra,
                            municipio: municipiosFiltrados[index],
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(5.0),
                    ),
                    child: Text(
                      municipiosFiltrados[index],
                      style: TextStyle(
                          fontSize: tam_letra,fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.tertiary,
                      ),textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ],
          ),

        ),
      ),
    );
  }
}

class MunicipioFiltrado extends StatelessWidget {
  final String municipio;
  final double tam_letra;

  const MunicipioFiltrado({required this.tam_letra, required this.municipio});

  @override
  Widget build(BuildContext context) {
    List<EventoHistorico> todosLosEventos = [...eventosAcontecimientos, ...eventosDefunciones, ...eventosNacimientos];
    List<EventoHistorico> eventosFiltrados = todosLosEventos
        .where((evento) =>
            evento.titulo.toLowerCase().contains(municipio.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title:
        Container(
          height: 25.0,
          width: 700,
          child: Marquee(
            text: 'Municipio de ${municipio}',
            style: TextStyle(fontSize: 20),
            scrollAxis: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            blankSpace: 20.0,
            velocity: 40.0, // Ajusta la velocidad según sea necesario
            pauseAfterRound: Duration(seconds: 1),
            startPadding: 10.0,
            accelerationDuration: Duration(seconds: 1),
            accelerationCurve: Curves.linear,
            decelerationDuration: Duration(milliseconds: 500),
            decelerationCurve: Curves.easeOut,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(7.0),
          child: Column(
            children: eventosFiltrados.map((evento) {
              return Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0),
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
                      fontSize: tam_letra,
                      color: Theme.of(context).colorScheme.tertiary,
                      letterSpacing: -0.6,
                    ),
                  ),
                  title: Text(
                    DateFormat('dd/MMMM/yyyy', 'es').format(evento.fecha),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      //color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  onLongPress: () {
                    mostrarVentanaFlotante(context, evento);
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
