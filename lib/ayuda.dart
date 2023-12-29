import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AyudaPage extends StatefulWidget {
  final double tam_letra;
  AyudaPage(this.tam_letra);


  @override
  _AyudaState createState() => _AyudaState();
}


class _AyudaState extends State<AyudaPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ayuda'),
      ),
      body:Container(
        //color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text("Explora Nuestras Funciones:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 5+widget.tam_letra,
                      height: 1.15,
                    )),
                SizedBox(height: 20),
                Text("Esta sección te guiará a través de todas las funciones disponibles "
                    "en nuestra aplicación. Desde la búsqueda de información hasta las opciones "
                    "de personalización, aquí encontrarás un resumen completo de todo lo que nuestra"
                    " aplicación tiene para ofrecer. ¡Sumérgete y descubre cómo sacar el máximo provecho "
                    "de tu experiencia!",
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize:3+widget.tam_letra,
                      height: 1.5,
                    )),

                SizedBox(height: 15),
                Text("Tipos de efemérides",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 5 + widget.tam_letra,
                      height: 1.5,
                    )),
                SizedBox(height: 15),
                Image.asset('assets/img/efemerides.png'),
                SizedBox(height: 15),
                Text("Aquí podrás explorar eventos significativos relacionados con Sonora, "
                    "clasificados en tres categorías principales: Acontecimientos, Nacimientos y "
                    "Defunciones. Cada categoría está representada por una pestaña única para facilitar "
                    "la búsqueda y la exploración",
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 3.0 + widget.tam_letra,
                      height: 1.5,
                    )),
                //SizedBox(height: 15),
                Padding(padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Acontecimientos",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 3+widget.tam_letra,
                            height: 1.5,
                          )),
                      Text("Esta pestaña te permite descubrir eventos históricos y sucesos"
                          " destacados que han marcado la historia de Sonora. Desde acontecimientos "
                          "políticos hasta hitos culturales, encontrarás información detallada sobre cada efeméride.",
                          style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            fontSize: 3.0 + widget.tam_letra,
                            height: 1.5,
                          )),
                      Text("Nacimientos",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 3+widget.tam_letra,
                            height: 1.5,
                          )),
                      Text("En esta sección, podrás conocer a personalidades destacadas que"
                          " nacieron en Sonora. Descubre información sobre figuras importantes "
                          "en distintos campos, desde artistas y científicos hasta líderes comunitarios.",
                          style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            fontSize: 3.0 + widget.tam_letra,
                            height: 1.5,
                          )),
                      Text("Defunciones",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 3+widget.tam_letra,
                            height: 1.5,
                          )),
                      Text("La pestaña de Defunciones te brinda la oportunidad de recordar "
                          "y honrar a aquellos individuos que hicieron contribuciones significativas"
                          " y que han dejado un impacto duradero en la historia de Sonora.",
                          style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            fontSize: 3.0 + widget.tam_letra,
                            height: 1.5,
                          )),
                    ],
                  ),
                ),

                SizedBox(height: 15),
                Text("Filtrado por fecha",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 5 + widget.tam_letra,
                      height: 1.5,
                    )),
                SizedBox(height: 15),
                Image.asset('assets/img/filtro.png'),
                SizedBox(height: 15),
                Text("Para facilitar tu búsqueda y proporcionarte información más específica,"
                    " hemos incorporado una función de filtrado por fecha. En la parte inferior"
                    " derecha de la pantalla, encontrarás un botón con un ícono de calendario.\n"
                    "Al pulsar este botón, se desplegará un calendario interactivo que te permitirá seleccionar la "
                    "fecha de interés que deseas explorar. Este filtro te ayudará a enfocarte en efemérides "
                    "asociadas a un día o mes particulares.",
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 3.0 + widget.tam_letra,
                      height: 1.5,
                    )),

                SizedBox(height: 15),
                Text("Buscador",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 5 + widget.tam_letra,
                      height: 1.5,
                    )),
                SizedBox(height: 15),
                Image.asset('assets/img/buscador.png'),
                SizedBox(height: 15),
                Text("Dentro del buscador, tienes la capacidad de buscar las efemérides que te "
                    "interesan, utilizando el nombre o palabras clave relevantes. Esta "
                    "característica te permite encontrar rápidamente la información que buscas,"
                    " brindándote un acceso rápido y eficiente a las efemérides que son de tu interés.",
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 3.0 + widget.tam_letra,
                      height: 1.5,
                    )),
                Image.asset('assets/img/busqueda.png',width: 300,),


                SizedBox(height: 15),
                Text("Efemérides",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 5 + widget.tam_letra,
                      height: 1.5,
                    )),
                SizedBox(height: 15),
                Image.asset('assets/img/efemeridess.png'),
                SizedBox(height: 15),
                Text("En esta sección, encontrarás las efemérides del tipo seleccionado, "
                    "organizadas por mes para facilitar tu exploración. Puedes desplazarte "
                    "cómodamente de arriba hacia abajo para revisar las efemérides de diferentes meses."
                    "\nSi mantienes presionada una efeméride, se abrirá un pequeño menú con opciones adicionales.",
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 3.0 + widget.tam_letra,
                      height: 1.5,
                    )),
                Padding(padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Opciones del menú si mantines precionado:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 3+widget.tam_letra,
                            height: 1.5,
                          )),
                      SizedBox(height: 15),
                      Text("Compartir Efeméride:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 3+widget.tam_letra,
                            height: 1.5,
                          )),
                      Text("Toca esta opción para compartir la efeméride con amigos o familiares a"
                          " través de tus aplicaciones de mensajería preferidas o en redes sociales.",
                          style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            fontSize: 3.0 + widget.tam_letra,
                            height: 1.5,
                          )),
                      Text("Copiar Efeméride:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 3+widget.tam_letra,
                            height: 1.5,
                          )),
                      Text("Utiliza esta opción para copiar la información de la efeméride y pegarla"
                          " donde lo necesites, ya sea en notas, mensajes o cualquier otra aplicación.",
                          style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            fontSize: 3.0 + widget.tam_letra,
                            height: 1.5,
                          )),
                    ],
                  ),
                ),


                SizedBox(height: 15),
                Text("Menu",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 5 + widget.tam_letra,
                      height: 1.5,
                    )),
                SizedBox(height: 15),
                Image.asset('assets/img/menu.png'),
                SizedBox(height: 15),
                Text("El menú contiene todas las funciones esenciales de la aplicación. "
                    "Desde aquí, puedes acceder a todas las características y opciones disponibles "
                    "que te permiten explorar, aprender y disfrutar de la experiencia completa"
                    " que ofrece la aplicación.",
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 3.0 + widget.tam_letra,
                      height: 1.5,
                    )),



                Text("Por Municipio",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 5 + widget.tam_letra,
                      height: 1.5,
                    )),
                SizedBox(height: 15),
                Image.asset('assets/img/menu.png'),
                SizedBox(height: 15),
                Text("En esta sección, te ofrecemos la posibilidad de explorar efemérides "
                    "específicas por municipios. El proceso es sencillo y se organiza de la siguiente manera:",
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 3.0 + widget.tam_letra,
                      height: 1.5,
                    )),
                Padding(padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("1. Selección por Letra:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 3+widget.tam_letra,
                            height: 1.5,
                          )),
                      SizedBox(height: 15),
                      Text("Comienza seleccionando la letra con la que comienza el nombre del "
                          "municipio que te interesa. Esto te permitirá filtrar y ver una lista de"
                          " municipios que comienzan con esa letra.",
                          style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            fontSize: 3.0 + widget.tam_letra,
                            height: 1.5,
                          )),
                      SizedBox(height: 15),
                      Image.asset('assets/img/municipioL.png'),
                      SizedBox(height: 15),
                      Text("2. Lista de Municipios:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 3+widget.tam_letra,
                            height: 1.5,
                          )),
                      Text("Después de elegir la letra, se mostrará una lista de municipios"
                          " correspondientes. Aquí podrás ver los nombres de los municipios"
                          " disponibles que empiezan con la letra seleccionada.",
                          style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            fontSize: 3.0 + widget.tam_letra,
                            height: 1.5,
                          )),
                      SizedBox(height: 15),
                      Image.asset('assets/img/municipios.png'),
                      SizedBox(height: 15),
                      Text("3. Selección del Municipio:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 3+widget.tam_letra,
                            height: 1.5,
                          )),
                      Text("Al seleccionar un municipio específico de la lista, se "
                          "desplegarán las efemérides asociadas con ese municipio en "
                          "particular. Podrás explorar eventos y momentos históricos relevantes a ese lugar.",
                          style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            fontSize: 3.0 + widget.tam_letra,
                            height: 1.5,
                          )),
                      SizedBox(height: 15),
                      Image.asset('assets/img/municipioss.png'),
                      SizedBox(height: 15),
                    ],
                  ),
                ),


                SizedBox(height: 15),
                Text("Reiniciar filtros",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 5 + widget.tam_letra,
                      height: 1.5,
                    )),
                SizedBox(height: 15),
                Text("Para brindarte mayor control y comodidad, hemos incorporado la opción de Reiniciar Filtros. "
                    "Si en algún momento has aplicado filtros específicos o seleccionado fechas particulares,"
                    " y deseas regresar a la vista original, esta función es tu solución.",
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 3.0 + widget.tam_letra,
                      height: 1.5,
                    )),



                SizedBox(height: 15),
                Text("Tamaño de letra",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 5 + widget.tam_letra,
                      height: 1.5,
                    )),
                SizedBox(height: 15),
                Text("En esta característica, tiene la capacidad de ajustar el tamaño de"
                    " la letra en tres niveles diferentes: pequeño, mediano y grande. Esto"
                    " te permite personalizar la experiencia de lectura según tus preferencias visuales.",
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 3.0 + widget.tam_letra,
                      height: 1.5,
                    )),

                SizedBox(height: 15),
                Text("Compartir",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 5 + widget.tam_letra,
                      height: 1.5,
                    )),
                SizedBox(height: 15),
                Text("Al elegir esta opción, tendrás la capacidad de compartir el enlace"
                    " de la aplicación en Google Play. Esto te permitirá compartir fácilmente "
                    "la aplicación con amigos, familiares y otros interesados, brindándoles "
                    "la oportunidad de descubrir y disfrutar de las Efemerides de Sonora.",
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 3.0 + widget.tam_letra,
                      height: 1.5,
                    )),

                SizedBox(height: 15),
                Text("Tema oscuro",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 5 + widget.tam_letra,
                      height: 1.5,
                    )),
                SizedBox(height: 15),
                Image.asset('assets/img/oscuro.png'),
                SizedBox(height: 15),
                Text("Además, para adaptarnos a tus preferencias visuales, nuestra aplicación"
                    " incluye un atractivo Tema Oscuro. Este tema proporciona una interfaz más"
                    " amigable para la vista en entornos de poca luz.",
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 3.0 + widget.tam_letra,
                      height: 1.5,
                    )),

                SizedBox(height: 15),
                Text("Participa",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 5 + widget.tam_letra,
                      height: 1.5,
                    )),
                SizedBox(height: 15),
                Image.asset('assets/img/participa.png'),
                SizedBox(height: 15),
                Text("Queremos que seas parte activa de nuestra comunidad y contribuyas a "
                    "enriquecer la información que ofrecemos. En la sección Participa, te "
                    "invitamos a enviar tus sugerencias, nuevas efemérides y más. Tu participación"
                    " es fundamental para hacer de esta aplicación una experiencia completa y significativa.",
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 3.0 + widget.tam_letra,
                      height: 1.5,
                    )),
                SizedBox(height: 15),
                Text("Acerca de",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 5 + widget.tam_letra,
                      height: 1.5,
                    )),
                SizedBox(height: 15),
                Text("Al seleccionar esta opción, accederás a una sección especial que te "
                    "proporcionará información detallada acerca de la aplicación y del proyecto "
                    "Redescubramos Sonora. Aquí podrás conocer más sobre el propósito de la aplicación,"
                    " sus creadores y la colaboración con Redescubramos Sonora. Esta sección te brindará "
                    "un contexto completo sobre la aplicación y su relación con la exploración cultural en la región.  ",
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 3.0 + widget.tam_letra,
                      height: 1.5,
                    )),


              ],
            ),
          ),
        ),


      ),


    );
  }

}
