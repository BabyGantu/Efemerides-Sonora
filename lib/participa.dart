
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';




class ParticipaPage extends StatefulWidget {
  final double tam_letra;
  ParticipaPage(this.tam_letra);


  @override
  _ParticipaState createState() => _ParticipaState();
}


class _ParticipaState extends State<ParticipaPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _commentController = TextEditingController();

  final String _lastSentKey = 'last_sent';
  final int _minTimeDifferenceInSeconds = 60; // 1 minuto

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Si el formulario es válido, se envía el mensaje
      final name = _nameController.text;
      final lastName = _lastNameController.text;
      final email = _emailController.text;
      final comment = _commentController.text;

      // Enviar correo electrónico y esperar a que termine
      final sent = await sendEmail(name, lastName, email, comment);

      if (sent) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title:  Text('Mensaje enviado'),
              content: Text('El mensaje se envió correctamente.'),
              actions: [
                TextButton(
                  child: Text('Aceptar'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error al enviar el mensaje'),
              content: Text('No se pudo enviar el mensaje. Asegúrese de estar conectado a internet. '
                  'Por favor, intenta de nuevo más tarde.'),
              actions: [
                TextButton(
                  child: Text('Aceptar'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          },
        );
      }

      // Se limpian los campos del formulario
      _nameController.clear();
      _lastNameController.clear();
      _emailController.clear();
      _commentController.clear();
    }
  }
  Future<bool> sendEmail(String name, String lastName, String email, String comment) async {
    // Configuración del servidor SMTP
    final smtpServer = SmtpServer('outlook.office365.com',
        port: 587,
        username: 'adrianibarra200916@hotmail.com',
        password: 'cyquuqvosgkliakj');

    // Cuerpo del mensaje
    final message = Message()
      ..from = Address('adrianibarra200916@hotmail.com')
    //..recipients.add('museodelosyaquis@isc.gob.mx')
      ..recipients.add('adrianibarra200916@hotmail.com')
      ..subject = 'Correo de participación de la aplicación Efemérides Sonora.'
      ..html = '''
        <h1>Correo de participación de la aplicación Efemérides Sonora.</h1>
        <p><strong>Nombre completo:</strong> $name</p>
        <p><strong>Telefono:</strong> $lastName</p>
        <p><strong>Correo electrónico:</strong> $email</p>
        <p><strong>Comentario:</strong> $comment</p>
      ''';

    // Envío del mensaje
    try {
      final sendReport = await send(message, smtpServer);
      print('Mensaje enviado: ${sendReport}');
      _updateLastSentTime();
      return true;
    } catch (e) {
      print('Error al enviar el mensaje: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('¡Participa!'),
      ),
      body:Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),

            child: Column(
              children: [
                Text("¡Envíanos tus sugerencias y efemérides para mejorar la aplicación!"
                  ,style: TextStyle(
                    fontSize: 5 + widget.tam_letra,
                    letterSpacing: 0.5, // Ajusta el espaciado entre letras
                  ),),
                SizedBox(height: 16.0),
                 Text("Queremos que seas parte de hacerla aún mejor. Tu participación es clave, "
                      "así que comparte tus ideas y fechas especiales con nosotros. "
                      "¡Gracias por contribuir a hacer nuestra aplicación genial!"
                  ,style: TextStyle(
                      fontSize: widget.tam_letra,
                      letterSpacing: 0.5, // Ajusta el espaciado entre letras
                    ),
                ),

                Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                    labelText: 'Nombre',
                                  ),
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Por favor, ingrese su nombre';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  controller: _lastNameController,
                                  decoration: InputDecoration(
                                    labelText: 'Telefono',
                                  ),
                                  keyboardType: TextInputType.phone, // Configura el teclado para mostrar solo números y caracteres relacionados con teléfonos
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Permite solo dígitos
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Por favor, ingrese su Teléfono';
                                    }
                                    // Puedes agregar una validación adicional, como asegurarte de que el número tenga una longitud específica
                                    // Por ejemplo, si solo se permiten números de teléfono de 10 dígitos:
                                    if (value!.length != 10) {
                                      return 'Ingrese un número de teléfono válido';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: 'Correo electrónico',
                                  ),
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Por favor, ingrese su correo electrónico';
                                    } else if (!EmailValidator.validate(value!)) {
                                      return 'Por favor, ingrese un correo electrónico válido';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  controller: _commentController,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    labelText: 'Comentarios',
                                  ),
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Por favor, ingrese sus comentarios';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 16.0),
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      bool canSend = await _canSendEmail();
                                      if (canSend) {
                                        _submitForm();
                                      } else {
                                        _showAlertDialog();
                                      }
                                    },
                                    child: Text('Enviar mensaje'),
                                  ),
                                ),
                              ],
                            )
                        ),
                      ],
                    )
                ),
              ],
            ),
          ),
        ),


      ),


    );
}
  Future<bool> _canSendEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int lastSentTime = prefs.getInt(_lastSentKey) ?? 0;
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    int timeDifferenceInSeconds = (currentTime - lastSentTime) ~/ 1000;

    return timeDifferenceInSeconds >= _minTimeDifferenceInSeconds;
  }

  void _updateLastSentTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(_lastSentKey, DateTime.now().millisecondsSinceEpoch);
  }


  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Espera un momento'),
          content: Text('Debes esperar antes de enviar otro correo.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}


