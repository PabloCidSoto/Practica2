import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:practica2/src/models/profile_model.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelperProfile {
  static final _nombreBD = "PROFILEBD2";
  static final _versionBD = 1;
  static final _nombreTabla = "tablaProfile2";

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    Directory carpeta = await getApplicationDocumentsDirectory();
    String rutaDB = join(carpeta.path, _nombreBD);
    return openDatabase(
      rutaDB, 
      version: _versionBD, 
      onCreate: _crearTabla
    );
  }

  Future<void> _crearTabla(Database db, int version) async {
    await db.execute("CREATE TABLE $_nombreTabla (id INTEGER PRIMARY KEY, nombre VARCHAR(30), apaterno VARCHAR(30), amaterno VARCHAR(30), telefono VARCHAR(30), email VARCHAR(100), image VARCHAR(200))");
  }

  Future<int> insert(Map<String, dynamic> row) async{
    var conexion = await database;
    return conexion!.insert(_nombreTabla, row);
  }

  Future<int> update(Map<String, dynamic> row) async{
    var conexion = await database;
    return conexion!.update(_nombreTabla, row, where: 'id = ?', whereArgs: [row['id']]);
  }

  Future<int> delete() async {
    var conexion = await database;
    return await conexion!.delete(_nombreTabla);
  }

  Future<ProfileModel> getProfile() async{
    var conexion = await database;
    var result = await conexion!.query(_nombreTabla);
    if(result.isNotEmpty){
      return ProfileModel.fromJson(result.first);    
    }else{
      return ProfileModel(email: '', image: '', nombre: '');
    }
  }
}