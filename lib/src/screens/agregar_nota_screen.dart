import 'package:flutter/material.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/notas_model.dart';
import 'package:practica2/src/utils/color_settings.dart';

class AgregarNotaScreen extends StatefulWidget {
  NotasModel? nota;
  AgregarNotaScreen({Key? key, this.nota}) : super(key: key);

  @override
  _AgregarNotaScreenState createState() => _AgregarNotaScreenState();
}

class _AgregarNotaScreenState extends State<AgregarNotaScreen> {
  
  late DatabaseHelper _databaseHelper;
  
  TextEditingController _controllerTitulo = TextEditingController();
  TextEditingController _controllerDetalle = TextEditingController();

  @override
  void initState() {
    if(widget.nota != null){
      _controllerTitulo.text = widget.nota!.titulo!;
      _controllerDetalle.text = widget.nota!.detalle!;
    }
    _databaseHelper = DatabaseHelper();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSettings.colorPrimary,
        title: widget.nota == null ? Text('Agregar Nota'): Text('Editar nota'),        
      ),
      body: Column(
        children: [
          _crearTextFieldTitulo(),
          SizedBox(height: 10),
          _crearTextfieldDetalle(),
          ElevatedButton(
            onPressed: (){
              if( widget.nota == null ){
                NotasModel nota = NotasModel(
                  titulo: _controllerTitulo.text,
                  detalle: _controllerDetalle.text
                );

                _databaseHelper.insert(nota.toJson()).then(
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
              } else {
                NotasModel nota = NotasModel(
                  titulo: _controllerTitulo.text,
                  detalle: _controllerDetalle.text,
                  id: widget.nota!.id
                );
                _databaseHelper.update(nota.toJson()).then(
                  (value) {
                    if(value > 0){
                      Navigator.pop(context);  
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('La solicitud no se completó'))
                      );
                    }

                  }
                );
              }
            }, 
            child: Text('Guardar nota')
          )
        ],
      ),
    );
  }

  Widget _crearTextFieldTitulo(){
    return TextField(
      controller: _controllerTitulo,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: "Título de la nota",
        errorText: "Este campo es obligatorio"
      ),
      onChanged: (value){
        
      },
      
    );
  }

  Widget _crearTextfieldDetalle(){
    return TextField(
      controller: _controllerDetalle,
      keyboardType: TextInputType.text,
      maxLines: 7,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: "Cuerpo de la nota",
        errorText: "Este campo es obligatorio"
      ),
      onChanged: (value){
        
      },
      
    );
  }
}