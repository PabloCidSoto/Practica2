import 'package:flutter/material.dart';
import 'package:practica2/src/database/db_tareas_helper.dart';
import 'package:practica2/src/screens/tareas_screens/widgets/lista_tareas.dart';

class TareasTab extends StatelessWidget {
  
  final DatabaseTareas _databaseHelper = DatabaseTareas();
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: ListaTareas(tareas: _databaseHelper.getTareasNoCompletadas())
    );
  }
}