import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:practica2/src/models/tareas_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseTareas{
  static final _nombreBD = "TAREASBD";
  static final _versionBD = 1;
  static final _nombreTabla = "tablaTareas";

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
    await db.execute("CREATE TABLE $_nombreTabla (id INTEGER PRIMARY KEY, nombreTarea VARCHAR(50), descTarea TEXT, fechaEntrega DATETIME, entregada BOOLEAN)");
  }

  Future<int> insert(Map<String, dynamic> row) async{
    var conexion = await database;
    return conexion!.insert(_nombreTabla, row);
  }

  Future<int> update(Map<String, dynamic> row) async{
    var conexion = await database;
    return conexion!.update(_nombreTabla, row, where: 'id = ?', whereArgs: [row['id']]);
  }

  Future<int> delete(int id) async {
    var conexion = await database;
    return await conexion!.delete(_nombreTabla, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<TareasModel>> getAllTareas() async {
    var conexion = await database;
    var result = await conexion!.query(_nombreTabla);
    return result.map((tareaMap) => TareasModel.fromJson(tareaMap)).toList();
  }

  Future<TareasModel> getTarea(int id) async{
    var conexion = await database;
    var result = await conexion!.query(_nombreTabla,where: 'id = ?', whereArgs: [id]);
    return TareasModel.fromJson(result.first);
  }

  Future<List<TareasModel>> getTareasCompletadas() async {
    var conexion = await database;
    var result = await conexion!.query(_nombreTabla, where: 'entregada = ?', whereArgs: [1], orderBy: 'fechaEntrega');
    return result.map((tareaMap) => TareasModel.fromJson(tareaMap)).toList();
  }

  Future<List<TareasModel>> getTareasNoCompletadas() async {
    var conexion = await database;
    var result = await conexion!.query(_nombreTabla, where: 'entregada = ?', whereArgs: [0], orderBy: 'fechaEntrega');
    return result.map((tareaMap) => TareasModel.fromJson(tareaMap)).toList();
  }

  
}