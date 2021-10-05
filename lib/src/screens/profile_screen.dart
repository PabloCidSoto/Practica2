import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practica2/src/database/db_profile_helper.dart';
import 'package:practica2/src/models/profile_model.dart';
import 'package:practica2/src/screens/agregar_nota_screen.dart';
import 'package:practica2/src/utils/color_settings.dart';

class ProfileScreen extends StatefulWidget {  
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  late DatabaseHelperProfile _databaseHelperProfile;

  late File file;
  bool _validarNombre = false;
  bool _validarApaterno = false;
  bool _validarAmaterno = false;
  bool _validarTelefono = false;
  bool _validarEmail = false;
  final ImagePicker _picker = ImagePicker();
  XFile? _photo;

  Future getImage() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      _photo = photo;
      _controllerImage.text = _photo!.path;
      file = File(_controllerImage.text);
      setState(() {
        futurebuilder();
      });            
  }

  Future getImageGallery() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
      _photo = photo;
      _controllerImage.text = _photo!.path;
      file = File(_controllerImage.text);
      setState(() {
        futurebuilder();
      });            
  }
  
  TextEditingController _controllerNombre = TextEditingController();
  TextEditingController _controllerApaterno = TextEditingController();
  TextEditingController _controllerAmaterno = TextEditingController();
  TextEditingController _controllerTelefono = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerImage = TextEditingController();

  @override
  void initState() {  
    _databaseHelperProfile = DatabaseHelperProfile();  
    Future<ProfileModel> profile = _databaseHelperProfile.getProfile();
    profile.then((value) {
      _controllerNombre.text = value.nombre!;
      _controllerApaterno.text = value.apaterno!;
      _controllerAmaterno.text = value.amaterno!;
      _controllerTelefono.text = value.telefono!;
      _controllerEmail.text = value.email!;
      _controllerImage.text = value.image!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        backgroundColor: ColorSettings.colorPrimary,
        title: Text('Perfil'),        
      ),
      body: futurebuilder()
    );
  }

  Widget _crearTextFieldNombre(){
    return TextField(
      controller: _controllerNombre,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: "Nombre",
        errorText: _validarNombre ? "Este campo es obligatorio" : null,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5)
      ),
      onChanged: (value){
        if(value.isEmpty){
          _validarNombre = true;  
        }else{
          _validarNombre = false;
        }
        //setState(() {});  
      },      
    );
  }
  Widget _crearTextFieldApaterno(){
    return TextField(
      controller: _controllerApaterno,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: "Apaterno",
        errorText: _validarNombre ? "Este campo es obligatorio" : null,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5)
      ),
      onChanged: (value){
        if(value.isEmpty){
          _validarApaterno = true;  
        }else{
          _validarApaterno = false;
        }
        //setState(() {});  
      },      
    );
  }
  Widget _crearTextFieldAmaterno(){
    return TextField(
      controller: _controllerAmaterno,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: "Amaterno",
        errorText: _validarNombre ? "Este campo es obligatorio" : null,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5)
      ),
      onChanged: (value){
        if(value.isEmpty){
          _validarAmaterno = true;  
        }else{
          _validarAmaterno = false;
        }
        //setState(() {});  
      },      
    );
  }
  Widget _crearTextFieldTelefono(){
    return TextField(
      controller: _controllerTelefono,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: "Telefono",
        errorText: _validarNombre ? "Este campo es obligatorio" : null,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5)
      ),
      onChanged: (value){
        if(value.isEmpty){
          _validarTelefono = true;  
        }else{
          _validarTelefono = false;
        }
        //setState(() {});  
      },      
    );
  }
  Widget _crearTextFieldEmail(){
    return TextField(
      controller: _controllerEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: "Email",
        errorText: _validarEmail ? "Este campo es obligatorio": null,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      ),
      onChanged: (value){
        if(value.isEmpty){
          _validarEmail = true;  
        }else{
          _validarEmail = false;
        }   
        // setState(() {});  
      },

      
    );
  }

  Widget futurebuilder(){
      return FutureBuilder(
      future: _databaseHelperProfile.getProfile(),
      builder: (BuildContext context, AsyncSnapshot<ProfileModel> snapshot) {
          if( snapshot.hasError ){
            return Center(child: Text('Ocurrio un Error en la petición'),);
          }else{
            if( snapshot.connectionState == ConnectionState.done ){
              return new Container(
                child: SingleChildScrollView(
                  child: Column(
                children: [
                  SizedBox(height: 10),
                  Stack(children: [
                    CircleAvatar(
                      radius: 75,
                      child: snapshot.data!.image!.isNotEmpty ? ClipRRect(borderRadius: BorderRadius.circular(75),child: Image.file(File(snapshot.data!.image!)),) :ClipRRect(borderRadius: BorderRadius.circular(75),child: Image.network('https://www.personality-insights.com/wp-content/uploads/2017/12/default-profile-pic-e1513291410505.jpg'),) ,
                      backgroundColor: Colors.transparent,
                    ),
                    Positioned(
                      child: 
                        IconButton(
                          onPressed: (){getImage();}, 
                          icon: Icon(Icons.camera_alt)
                        ),
                        top: 115,
                        left: 115,
                    ),
                    Positioned(
                      child: 
                        IconButton(
                          onPressed: (){getImageGallery();}, 
                          icon: Icon(Icons.collections)
                        ),
                        top: 115,
                        right: 115,
                    )
                    
                  ],),
                  Column(
                    children: [
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: _crearTextFieldNombre(),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: _crearTextFieldApaterno(),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: _crearTextFieldAmaterno(),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: _crearTextFieldTelefono(),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: _crearTextFieldEmail(),
                      ),
                    ],

                  ),
                  ElevatedButton(
                    onPressed: (){
                      ProfileModel profile = ProfileModel(
                        nombre: _controllerNombre.text,
                        apaterno: _controllerApaterno.text,
                        amaterno: _controllerAmaterno.text,
                        telefono: _controllerTelefono.text,
                        email: _controllerEmail.text,
                        image: _controllerImage.text
                      );
                      _databaseHelperProfile.delete().then((value) {
                        _databaseHelperProfile.insert(profile.toJson()).then(
                          (value){
                            if(value > 0){
                              Navigator.pop(context);
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('No se completó la creación'))
                              );
                            }
                          }
                        );
                      });     
                    }, 
                    child: Text('Guardar Perfil')
                  )
                ],
                )
                ),
              ); 
              
              
            }else{
              return Center(child: CircularProgressIndicator(),);
            }
          }    
        },
      );
    } 
}