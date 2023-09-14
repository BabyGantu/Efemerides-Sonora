import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:tutorial1/acercade.dart';

import 'package:tutorial1/pag_acont.dart';
import 'package:tutorial1/pag_intro.dart';
import 'package:tutorial1/pag_nac.dart';
import 'package:tutorial1/pag_def.dart';
import 'package:tutorial1/searchdelegate.dart';
import 'package:tutorial1/temas/dark_theme.dart';
import 'package:tutorial1/temas/light_theme.dart';
import 'package:tutorial1/temas/theme_manager.dart';
import 'package:tutorial1/ventanacompartir.dart';


import 'datos/efemerides_acont.dart';
import 'datos/efemerides_muer.dart';
import 'datos/efemerides_nac.dart';

void main() {
  initializeDateFormatting('es', 'MX').then((_) {
    runApp(MyApp());
  });
}

ThemeManager _themeManager = ThemeManager();

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
      home: const PagIntro(),
    );
  }

}

class PagPrincipal extends StatefulWidget {
  const PagPrincipal({super.key});

  @override
  State<PagPrincipal> createState() => _PagMainState();
}

class _PagMainState extends State<PagPrincipal> {
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
      });
    }
  }

  void resetFiltros() {
    setState(() {
      fechaElegida = null;
    });
  }

  Future<void> resetFiltros1() async {
    setState(() {
      fechaElegida = null;
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: const Duration(milliseconds: 100),
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: const Text('Efemerides'),
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
                  child: SwitchListTile(
                    title: const Text('Tema Oscuro'),
                    value: _themeManager.themeMode == ThemeMode.dark,
                    onChanged: (newValue) =>
                        _themeManager.toggleTheme(newValue),
                    secondary: const Icon(Icons.dark_mode),
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
                }
              },
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Acontecimientos',
                icon: Icon(Icons.event),
              ),
              Tab(
                text: 'Nacimientos',
                icon: Icon(Icons.cake),
              ),
              Tab(
                text: 'Defunciones',
                icon: Icon(Icons.account_circle),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildTabItem(PagAcontecimientos(
                fechaElegida: fechaElegida, fontSize: _fontSize)),
            _buildTabItem(PagNacimientos(
                fechaElegida: fechaElegida, fontSize: _fontSize)),
            _buildTabItem(PagDefunciones(
                fechaElegida: fechaElegida, fontSize: _fontSize)),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          onPressed: _showDatePicker,
          child: const Icon(
            Icons.calendar_month_outlined,
            size: 20,
          ),
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
}
