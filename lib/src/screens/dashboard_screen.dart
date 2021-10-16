import 'dart:io';

import 'package:flutter/material.dart';
import 'package:practica2/src/database/db_profile_helper.dart';
import 'package:practica2/src/models/profile_model.dart';
import 'package:practica2/src/screens/profile_screen.dart';
import 'package:practica2/src/utils/color_settings.dart';


class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> { 

  late DatabaseHelperProfile _databaseHelper;

    @override
    void initState() {
      super.initState();
      _databaseHelper = DatabaseHelperProfile();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: ColorSettings.colorPrimary,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            FutureBuilder(
              future: _databaseHelper.getProfile(),
              builder: (BuildContext context, AsyncSnapshot<ProfileModel> snapshot) {
                if( snapshot.hasError ){
                  return Text('error en la petición');
                }else{
                  if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                    print('data');
                    print(snapshot.data!.email);
                    return _userData(snapshot.data!);
                  }else{
                    return Center(child: CircularProgressIndicator());
                  }
                }
                
              }
            ),
            ListTile(
              title: Text('Propinas'),
              subtitle: Text('Calculadora de propinas'),
              leading: Icon(Icons.monetization_on_outlined),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/opc1');
              },
            ),
            ListTile(
              title: Text('Intenciones'),
              subtitle: Text('Intenciones implícitas'),
              leading: Icon(Icons.phone_android),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/intenciones');
              },
            ),
            ListTile(
              title: Text('Notas'),
              subtitle: Text('CRUD Notas'),
              leading: Icon(Icons.note),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/notas');
              },
            ),
            ListTile(
              title: Text('Movies'),
              subtitle: Text('Prueba API REST'),
              leading: Icon(Icons.movie),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/movie');
              },
            ),
            ListTile(
              title: Text('Tareas'),
              subtitle: Text('Manejo de Tareas'),
              leading: Icon(Icons.assignment_outlined),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/tareas');
              },
            ),
          ],
        ),
      )
    );
  }

  Widget _userData(ProfileModel profile){
    return UserAccountsDrawerHeader(
      accountName: Text(profile.nombre!), 
      accountEmail: Row(
        children: [
          profile.email!.isNotEmpty && profile.nombre!.isNotEmpty ? Text(profile.email!) : Text('Cree un perfil en el lapiz'),
          IconButton(
            onPressed: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profile').whenComplete(() {setState(() {});});
            }, 
            icon: Icon(Icons.edit, color: Colors.white,)
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: profile.image!.isNotEmpty ? ClipRRect(borderRadius: BorderRadius.circular(75),child: Image.file(File(profile.image!)),) :ClipRRect(borderRadius: BorderRadius.circular(75),child: Image.network('https://www.personality-insights.com/wp-content/uploads/2017/12/default-profile-pic-e1513291410505.jpg'),) ,
      ),
      decoration: BoxDecoration(color: ColorSettings.colorPrimary),
    );
  }
}
