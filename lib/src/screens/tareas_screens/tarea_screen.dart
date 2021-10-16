import 'package:flutter/material.dart';
import 'package:practica2/src/database/db_tareas_helper.dart';
import 'package:practica2/src/models/tareas_model.dart';
import 'package:practica2/src/screens/tareas_screens/tareas_screen.dart';
import 'package:practica2/src/screens/tareas_screens/tareas_tabs/tareas_agregar_tab.dart';

class TareaScreen extends StatelessWidget {
  final TareasModel tarea;
  TareaScreen({required this.tarea});

  late DatabaseTareas _databaseHelper = DatabaseTareas();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(icon: Icon(Icons.delete_forever_rounded),
              onPressed: (){
                showDialog(
                          context: context, 
                          builder: (context){
                            return AlertDialog(
                              title: Text('Confirmación'),
                              content: Text ('¿Estás seguro del borrado?'),
                              actions: [
                                TextButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                    _databaseHelper.delete(tarea.id!).then(
                                      (noRows){
                                        if(noRows > 0){
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('La nota ha sido eliminada'))    
                                          );   
                                        }  
                                      }
                                    );
                                  }, 
                                  child: Text('Si')
                                ),
                                TextButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  }, 
                                  child: Text('No')
                                )
                              ],
                            );
                          });
              },
            ),
            IconButton(icon: Icon(Icons.edit),
              onPressed: (){
                Navigator.of(context).push(_createRoute(tarea));
              },
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.end,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Text('Fecha de Entrega: ${tarea.fechaEntrega.toString()}' ,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600]
                    ),  
                  ),
                  SizedBox(height: 10,),
                  Text(tarea.nombreTarea.toString(),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(tarea.descTarea.toString(),
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
            Expanded(child: SizedBox(height: 0,),),
            ElevatedButton(
              onPressed: (){
                tarea.entregada = (tarea.entregada! - 1).abs();
                _databaseHelper.update(tarea.toJson()).then(
                  (value) {
                    if(value > 0){
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Tarea Entregada'))
                      );  
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('La solicitud no se completó'))
                      );
                    }
                  });
              }, 
              child: tarea.entregada == 0 ? Text('Marcar como entregada') : Text('Marcar como no entregada') ,
              
            ),
          ],
        ),
      ),
    );

  }

  Route _createRoute(TareasModel tarea) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => AgregarTareaTab(tarea: tarea),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}