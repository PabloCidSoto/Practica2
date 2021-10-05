import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:practica2/src/models/notas_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _nombreBD = "NOTASBD";
  static final _versionBD = 1;
  static final _nombreTabla = "tablaNotas";

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
    await db.execute("CREATE TABLE $_nombreTabla (id INTEGER PRIMARY KEY, titulo VARCHAR(50), detalle VARCHAR(100))");
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
  
  Future<List<NotasModel>> getAllNotes() async {
    var conexion = await database;
    var result = await conexion!.query(_nombreTabla);
    return result.map((notaMap) => NotasModel.fromJson(notaMap)).toList(); 
  }

  Future<NotasModel> getNote(int id) async{
    var conexion = await database;
    var result = await conexion!.query(_nombreTabla,where: 'id = ?', whereArgs: [id]);
    return NotasModel.fromJson(result.first);
    
  }
}
