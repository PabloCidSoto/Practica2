import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practica2/src/models/tareas_model.dart';
import 'package:practica2/src/screens/tareas_screens/tarea_screen.dart';

class ListaTareas extends StatelessWidget {
  
  final Future<List<TareasModel>> tareas;
  


  ListaTareas({required this.tareas});  
  @override
  Widget build(BuildContext context) {    
    return FutureBuilder(
      future: tareas,
      builder: (BuildContext context, AsyncSnapshot<List<TareasModel>> snapshot){
        if( snapshot.hasError ){
          return Center(child: Text('Ocurrio un error en la petición'));
        }else{
          if(snapshot.connectionState == ConnectionState.done){  
            if(snapshot.data!.isNotEmpty){
              return _listaTareas(snapshot.data!);
            }else{
              return Center(child: Text('No hay tareas para mostrar'),);
            }
          }else{
            return Center(child: CircularProgressIndicator());
          }
        }
      }
      
    );
    
  }

  Widget _listaTareas(List<TareasModel> tareas){    
    tareas.sort((a, b) => a.fechaEntrega!.compareTo(b.fechaEntrega!));
    return CustomScrollView(
        slivers: <Widget>[
          SliverList(  
            delegate: SliverChildBuilderDelegate(
              (context, index){
                final tarea = tareas[index];  
                return InkWell(
                  onTap: (){ 
                    Navigator.of(context).push(_createRoute(tarea));
                  },
                  child: Container(  
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 17),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: _colorIcon(tarea),
                            child: Icon(
                              Icons.assignment_outlined, 
                              color: Colors.white,
                            ),
                          )
                          ,
                          SizedBox(width: 10,),
                          Column(
                            children: [
                              Text(
                                tarea.nombreTarea.toString(),
                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500
                
                                ),
                              ),
                              Text(
                                'Fecha de vencimiento: ${tarea.fechaEntrega}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600]
                                ),
                              )
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ],
                         
                      ),
                    ),
                  ),
                );
                
              },
              childCount: tareas.length
            ),
          )
        ],
      );
  }

  Route _createRoute(TareasModel tarea) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => TareaScreen(tarea: tarea,),
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

  Color _colorIcon(TareasModel tarea){
    if(tarea.entregada == 1) return Colors.green;
    if(DateTime.parse(tarea.fechaEntrega!).isBefore(DateTime.now())) return Colors.red.shade400;
    return Colors.grey.shade400;
  }


}