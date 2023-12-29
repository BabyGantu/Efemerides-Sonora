import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:marquee/marquee.dart';
//import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:tutorial1/acercade.dart';
import 'package:tutorial1/modelo/efemerides_fun.dart';

import 'package:tutorial1/pag_acont.dart';
import 'package:tutorial1/pag_intro.dart';
import 'package:tutorial1/pag_nac.dart';
import 'package:tutorial1/pag_def.dart';
import 'package:tutorial1/participa.dart';
import 'package:tutorial1/searchdelegate.dart';
import 'package:tutorial1/temas/dark_theme.dart';
import 'package:tutorial1/temas/light_theme.dart';
import 'package:tutorial1/temas/theme_manager.dart';
import 'package:tutorial1/ventanacompartir.dart';

import 'ayuda.dart';
import 'datos/efemerides_acont.dart';
import 'datos/efemerides_muer.dart';
import 'datos/efemerides_nac.dart';
import 'municipio.dart';
import 'SplashScreen.dart';

void main() {
  initializeDateFormatting('es', 'MX').then((_) {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => MyApp(),
      },
      onUnknownRoute: (settings) {
        print('ERROR: no se encuentra ${settings.name}');
      },
    ));
  });
}

ThemeManager _themeManager = ThemeManager();
bool mostrarFiltro = false;
bool notAcon = false;
bool notNac = false;
bool notDef = false;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final keyOne = GlobalKey();

  /*@override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ShowCaseWidget.of(context).startShowCase([
        keyOne,
      ]),
    );
  }*/

  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate, // Agrega este delegado
      ],
      supportedLocales: const [
        Locale('es', 'MX'),
      ],
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      home: const PagPrincipal(),
      initialRoute: '/',
      routes: {
        '/home': (context) => const PagPrincipal(),
      },
    );
  }
}

class PagPrincipal extends StatefulWidget {
  const PagPrincipal({super.key});

  @override
  State<PagPrincipal> createState() => _PagMainState();
}

class _PagMainState extends State<PagPrincipal> with SingleTickerProviderStateMixin{
  DateTime? fechaElegida;
  TextEditingController searchController = TextEditingController();
  double _fontSize = 16.0; // Tamaño de letra inicial
  bool isDarkMode = false;

  void _showDatePicker() async {
    final fechaSeleccionada = await showDatePicker(
      context: context,
      locale: const Locale('es', 'MX'),
      initialDate: DateTime.now(),
      firstDate: DateTime(1400),
      lastDate: DateTime.now(),

    );

    if (fechaSeleccionada != null) {
      setState(() {
        fechaElegida = fechaSeleccionada;
        mostrarFiltro = true; // Muestra el Card cuando se selecciona una fecha

        List<EventoHistorico> getEventosFiltrados() {
          if (fechaElegida == null) {
            return eventosNacimientos;
          } else {
            return eventosNacimientos
                .where((evento) =>
                    evento.fecha.month == fechaElegida!.month &&
                    evento.fecha.day == fechaElegida!.day)
                .toList();
          }
        }

        List<EventoHistorico> getEventosFiltradosAcon() {
          if (fechaElegida == null) {
            return eventosAcontecimientos;
          } else {
            return eventosAcontecimientos
                .where((evento) =>
                    evento.fecha.month == fechaElegida!.month &&
                    evento.fecha.day == fechaElegida!.day)
                .toList();
          }
        }

        List<EventoHistorico> getEventosFiltradosDef() {
          if (fechaElegida == null) {
            return eventosDefunciones;
          } else {
            return eventosDefunciones
                .where((evento) =>
                    evento.fecha.month == fechaElegida!.month &&
                    evento.fecha.day == fechaElegida!.day)
                .toList();
          }
        }

        final eventosFiltrados = getEventosFiltrados();
        final eventosFiltradosAcon = getEventosFiltradosAcon();
        final eventosFiltradosDef = getEventosFiltradosDef();
        if (eventosFiltrados.isNotEmpty) {
          notNac = true;
        } else {
          notNac = false;
        }

        if (eventosFiltradosAcon.isNotEmpty) {
          notAcon = true;
        } else {
          notAcon = false;
        }

        if (eventosFiltradosDef.isNotEmpty) {
          notDef = true;
        } else {
          notDef = false;
        }
      });
    }
  }

  void actualizarNotNac(bool nuevoValor) {
    setState(() {
      notNac = nuevoValor;
    });
  }

  void verifica(DateTime? fechaElegida) {}

  void resetFiltros() {
    setState(() {
      fechaElegida = null;
      notDef = false;
      notAcon = false;
      notNac = false;
    });
  }

  Future<void> resetFiltros1() async {
    setState(() {
      fechaElegida = null;
      notDef = false;
      notAcon = false;
      notNac = false;
    });

    const snackBar = SnackBar(
      backgroundColor: Color.fromARGB(255, 132, 225, 141),
      behavior: SnackBarBehavior.floating,
      // Establecer el color de fondo morado
      content: Text(
        'Mostrando todos los eventos',
        style: TextStyle(
            color: Colors.white), // Establecer el color del texto en blanco
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _changeFontSize() async {
    final fontSize = await showDialog<double>(
      context: context,
      builder: (BuildContext context) {
        double selectedFontSize =
            _fontSize; // Valor inicial del tamaño de letra seleccionado

        return AlertDialog(
          title: const Text('Seleccionar tamaño de letra'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                RadioListTile<double>(
                  title: const Text('Pequeño'),
                  value: 16.0,
                  groupValue: selectedFontSize,
                  onChanged: (double? value) {
                    Navigator.of(context).pop(value);
                  },
                ),
                RadioListTile<double>(
                  title: const Text('Mediano'),
                  value: 20.0,
                  groupValue: selectedFontSize,
                  onChanged: (double? value) {
                    Navigator.of(context).pop(value);
                  },
                ),
                RadioListTile<double>(
                  title: const Text('Grande'),
                  value: 24.0,
                  groupValue: selectedFontSize,
                  onChanged: (double? value) {
                    Navigator.of(context).pop(value);
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );

    if (fontSize != null) {
      setState(() {
        _fontSize = fontSize;
      });
    }
  }

  Future<void> _showMonthAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Selecciona un Mes'),
          content: Column(
            children: [
              _buildMonthButton(context, 'Enero'),
              _buildMonthButton(context, 'Febrero'),
              _buildMonthButton(context, 'Marzo'),
              _buildMonthButton(context, 'Abril'),
              _buildMonthButton(context, 'Mayo'),
              _buildMonthButton(context, 'Junio'),
              _buildMonthButton(context, 'Julio'),
              _buildMonthButton(context, 'Agosto'),
              _buildMonthButton(context, 'Septiembre'),
              _buildMonthButton(context, 'Octubre'),
              _buildMonthButton(context, 'Noviembre'),
              _buildMonthButton(context, 'Diciembre'),
            ],
          ),
        );
      },
    );
  }

  DateTime? selectedMonth;

  /*Future<void> _showMonthPicker(BuildContext context) async {
    showMonthPicker(
      context: context,
      initialDate: selectedMonth ?? DateTime.now(),
      firstDate: DateTime(1400),
      lastDate: DateTime.now(),headerColor: Colors.black54
      //headerColor: lightTheme.primaryColor,
    ).then((selectedDate) {
      if (selectedDate != null) {
        setState(() {
          selectedMonth = selectedDate;
        });
      }
    });
  }
*/

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: const Duration(milliseconds: 300),
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title:
          Container(
            height: 25.0,
            width: 226,
            child: Marquee(
              text: 'Efemérides de Sonora',
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
          actions: <Widget>[
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: EventoSearchDelegate(
                    eventosAcontecimientos: eventosAcontecimientos,
                    eventosDefunciones: eventosDefunciones,
                    eventosNacimientos: eventosNacimientos,
                  ),
                );
              },
              icon: const Icon(Icons.search),
            ),
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'municipio',
                  child: ListTile(
                    leading: Icon(Icons.location_city),
                    title: Text('Por Municipio'),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'reiniciar_filtros',
                  child: ListTile(
                    leading: Icon(Icons.refresh),
                    title: Text('Reiniciar Filtros'),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'tamano_letra',
                  child: ListTile(
                    leading: Icon(Icons.format_size),
                    title: Text('Tamaño de letra'),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'compartir',
                  child: ListTile(
                    leading: Icon(Icons.share),
                    title: Text('Compartir'),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'modo_oscuro',
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return SwitchListTile(
                        title: const Text('Tema Oscuro'),
                        value: _themeManager.themeMode == ThemeMode.dark,
                        onChanged: (newValue) {
                          _themeManager.toggleTheme(newValue);
                          // Forzar la reconstrucción del PopupMenuButton
                          setState(() {});
                        },
                        secondary: const Icon(Icons.dark_mode),
                      );
                    },
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'participa',
                  child: ListTile(
                    leading: Icon(Icons.add_circle),
                    title: Text('¡Participa!'),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'ayuda',
                  child: ListTile(
                    leading: Icon(Icons.help),
                    title: Text('Ayuda'),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'acerca_de',
                  child: ListTile(
                    leading: Icon(Icons.info),
                    title: Text('Acerca de'),
                  ),
                ),
              ],
              onSelected: (String value) {
                //  lógica de lo que ocurre al seleccionar un elemento del menú
                switch (value) {
                  case 'reiniciar_filtros':
                    resetFiltros(); // Lógica para reiniciar filtros
                    break;
                  case 'tamano_letra':
                    _changeFontSize(); // Lógica para ajustar el tamaño de letra
                    break;
                  case 'compartir':
                    compartirApp();
                    // Lógica para compartir
                    break;
                  case 'modo_oscuro':

                    // Lógica para modoobscuro
                    break;
                  case 'acerca_de':
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutPage()),
                    );
                    break;
                  case 'participa':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ParticipaPage(_fontSize)),
                    );
                    break;
                  case 'municipio':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MunicipioPage(_fontSize)),
                    );
                    break;
                  case 'ayuda':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AyudaPage(_fontSize)),
                    );
                    break;
                }
              },
            ),
          ],
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            key: UniqueKey(),
            labelPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
            tabs: [
              CustomTabAcon(
                  key: UniqueKey(), text: 'Acontecimientos', icon: Icons.event),
              CustomTabNac(
                  key: UniqueKey(), text: 'Nacimientos', icon: Icons.cake),
              CustomTabDef(
                  key: UniqueKey(),
                  text: 'Defunciones',
                  icon: Icons.account_circle),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (mostrarFiltro)
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Card(
                  elevation: 5.0,
                  margin: EdgeInsets.all(6.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 1.0),
                        ElevatedButton(
                          onPressed: () {
                            resetFiltros();
                            setState(() {
                              mostrarFiltro = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(),
                          child: Text(
                            'Quitar filtros',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.tertiary,
                              fontSize: 15,
                              //color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildTabItem(PagAcontecimientos(
                    fechaElegida: fechaElegida,
                    fontSize: _fontSize,
                  )),
                  _buildTabItem(PagNacimientos(
                    fechaElegida: fechaElegida,
                    fontSize: _fontSize,
                  )),
                  _buildTabItem(PagDefunciones(
                    fechaElegida: fechaElegida,
                    fontSize: _fontSize,
                  )),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: "fecha",
              backgroundColor: Theme.of(context).colorScheme.secondary,
              onPressed: _showDatePicker,
              child: const Icon(
                Icons.calendar_month_outlined,
                size: 35,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),
            /**FloatingActionButton(
                  heroTag: "mes",
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  onPressed: () => _showMonthPicker(context),
                  child: const Icon(
                    Icons.calendar_month_sharp,
                    size: 20,
                  ),
                ),**/
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(Widget page) {
    return RefreshIndicator(
      onRefresh: resetFiltros1,
      child: page,
    );
  }

  Widget _buildMonthButton(BuildContext context, String month) {
    return ElevatedButton(
      onPressed: () {
        // Hacer algo con el mes seleccionado
        print('Mes seleccionado: $month');
        Navigator.of(context).pop(); // Cerrar el AlertDialog
      },
      child: Text(month),
    );
  }
}

class CustomTabNac extends StatelessWidget {
  final String text;
  final IconData icon;

  const CustomTabNac(
      {required this.text, required this.icon, required UniqueKey key});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Icon(icon),
              if (notNac)
                Positioned(
                  top: 0,
                  right: 0,
                  left: 13,
                  bottom: 10,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.red, // Color del globo de notificación
                      borderRadius: BorderRadius.circular(8),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                    child: Center(
                      child: Text(
                        '1', // Puedes cambiar esto por el número de notificaciones
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Column(
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ) // Espacio entre el icono y el texto
        ],
      ),
    );
  }
}

class CustomTabAcon extends StatelessWidget {
  final String text;
  final IconData icon;

  const CustomTabAcon(
      {required this.text, required this.icon, required UniqueKey key});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: SizedBox(
        height: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Icon(icon),
                if (notAcon)
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 13,
                    bottom: 10,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.red, // Color del globo de notificación
                        borderRadius: BorderRadius.circular(8),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 20,
                        minHeight: 20,
                      ),
                      child: Center(
                        child: Text(
                          '1', // Puedes cambiar esto por el número de notificaciones
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 4), // Espacio entre el icono y el texto
            Container(
              height: 18.0, // Establece la altura según sea necesario
              child: Text(text, style: TextStyle(fontSize: 15)),
              /**Marquee(
                text: text,
                style: TextStyle(fontSize: 15),
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
              ),**/
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTabDef extends StatelessWidget {
  final String text;
  final IconData icon;

  const CustomTabDef(
      {required this.text, required this.icon, required UniqueKey key});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Icon(icon),
              if (notDef)
                Positioned(
                  top: 0,
                  right: 0,
                  left: 13,
                  bottom: 10,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.red, // Color del globo de notificación
                      borderRadius: BorderRadius.circular(8),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                    child: Center(
                      child: Text(
                        '1', // Puedes cambiar esto por el número de notificaciones
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 3),
          Container(
            height: 18.0,
            child: Text(
              text,
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
