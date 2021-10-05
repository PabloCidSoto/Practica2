import 'package:flutter/material.dart';
import 'package:practica2/src/utils/color_settings.dart';
import 'package:url_launcher/url_launcher.dart';

class IntencionesScreen extends StatefulWidget {
  IntencionesScreen({Key? key}) : super(key: key);

  @override
  _IntencionesScreenState createState() => _IntencionesScreenState();
}

class _IntencionesScreenState extends State<IntencionesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Intenciones Implícitas'),
          backgroundColor: ColorSettings.colorPrimary,
        ),
        body: ListView(
          children: [
            Card(
              elevation: 10,
              child: ListTile(
                tileColor: Colors.white54,
                title: Text('Abrir página web'),
                subtitle: Row(
                  children: [
                    Icon(Icons.touch_app_rounded,
                        size: 18.0, color: Colors.green[300]),
                    Text('https://celaya.tecnm.mx/'),
                  ],
                ),
                leading: Container(
                  height: 40.0,
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.language,
                    color: Colors.black,
                  ),
                  decoration: BoxDecoration(
                      border: Border(right: BorderSide(width: 1.0))),
                ),
                trailing: Icon(Icons.chevron_right),
                onTap: _abrirWeb,
              ),
            ),
            Card(
              elevation: 10,
              child: ListTile(
                tileColor: Colors.white54,
                title: Text('Llamada telefónica'),
                subtitle: Row(
                  children: [
                    Icon(Icons.touch_app_rounded,
                        size: 18.0, color: Colors.green[300]),
                    Text('Cel: 4612279093'),
                  ],
                ),
                leading: Container(
                  height: 40.0,
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.phone_android,
                    color: Colors.black,
                  ),
                  decoration: BoxDecoration(
                      border: Border(right: BorderSide(width: 1.0))),
                ),
                trailing: Icon(Icons.chevron_right),
                onTap: _llamadaTelefonica,
              ),
            ),
            Card(
              elevation: 10,
              child: ListTile(
                tileColor: Colors.white54,
                title: Text('Enviar SMS'),
                subtitle: Row(
                  children: [
                    Icon(Icons.touch_app_rounded,
                        size: 18.0, color: Colors.green[300]),
                    Text('Cel: 4612279093'),
                  ],
                ),
                leading: Container(
                  height: 40.0,
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.sms_rounded,
                    color: Colors.black,
                  ),
                  decoration: BoxDecoration(
                      border: Border(right: BorderSide(width: 1.0))),
                ),
                trailing: Icon(Icons.chevron_right),
                onTap: _enviarSMS,
              ),
            ),
            Card(
              elevation: 10,
              child: ListTile(
                tileColor: Colors.white54,
                title: Text('Enviar email'),
                subtitle: Row(
                  children: [
                    Icon(Icons.touch_app_rounded,
                        size: 18.0, color: Colors.green[300]),
                    Text('To: ruben.torres@itcelaya.edu'),
                  ],
                ),
                leading: Container(
                  height: 40.0,
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.email_outlined,
                    color: Colors.black,
                  ),
                  decoration: BoxDecoration(
                      border: Border(right: BorderSide(width: 1.0))),
                ),
                trailing: Icon(Icons.chevron_right),
                onTap: _enviarEmail,
              ),
            ),
            Card(
              elevation: 10,
              child: ListTile(
                tileColor: Colors.white54,
                title: Text('Tomar foto'),
                subtitle: Row(
                  children: [
                    Icon(Icons.touch_app_rounded,
                        size: 18.0, color: Colors.green[300]),
                    Text('Sonríe :^)'),
                  ],
                ),
                leading: Container(
                  height: 40.0,
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.black,
                  ),
                  decoration: BoxDecoration(
                      border: Border(right: BorderSide(width: 1.0))),
                ),
                trailing: Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ),
          ],
        ));
  }

  _abrirWeb() async {
    const url = "https://celaya.tecnm.mx/";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  _llamadaTelefonica() async {
    const url = "tel:4612279093";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  _enviarSMS() async {
    const url = "sms:4612279093";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  _enviarEmail() async {
    final Uri params = Uri(
        scheme: 'mailto',
        path: 'isctorres@gmail.com',
        query: 'subject=Saludos&body=Bienvenido :)');

    var email = params.toString();
    if (await canLaunch(email)) {
      await launch(email);
    }
  }

  _tomarFoto() {}
}
