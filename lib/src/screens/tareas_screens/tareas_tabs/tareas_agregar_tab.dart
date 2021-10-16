import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica2/src/controllers/tareas_controllers/tareas_agregar_controller.dart';
import 'package:practica2/src/controllers/tareas_controllers/tareas_screen_controller.dart';
import 'package:practica2/src/database/db_tareas_helper.dart';
import 'package:practica2/src/models/tareas_model.dart';


class AgregarTareaTab extends StatelessWidget {
  
  final TareasModel? tarea;
  
  AgregarTareaTab({this.tarea});
    
    

  
  final controller = Get.put(ControllerAgregarTareas());
  final controllerScreen = Get.find<TareasScreenController>();
  late DatabaseTareas _databaseHelper = DatabaseTareas();
  bool edit = false;

   

  TextEditingController _nombreController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _hourController = TextEditingController();

  


  @override
  Widget build(BuildContext context) {
    if(tarea != null){
      _nombreController.text = tarea!.nombreTarea.toString();
      _descController.text = tarea!.descTarea.toString();
      _dateController.text = tarea!.fechaEntrega.toString().split(" ")[0];
      _hourController.text = tarea!.fechaEntrega.toString().split(" ")[1];
      edit = true;
    }
    return Scaffold(
      appBar: tarea != null ? AppBar(title: Text('Editar Tarea'),): null,
      body: SingleChildScrollView(       
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(() => Column(
            children: [
              _crearTextFieldNombreTarea(),
              SizedBox(height: 15,),
              _crearTextFieldDescTarea(),
              SizedBox(height: 15,),
              _crearDatePicker(context),
              
              _crearHourPicker(context),
              SizedBox(height: 15,),
              Row(
                children: [
                  _crearButton(context),
                ],
                mainAxisAlignment: MainAxisAlignment.end,
              )
            ],
          ) ) ,
        ),
      ),
    );
  }

  Widget _crearTextFieldNombreTarea(){
    return TextField(
      controller: _nombreController,
      keyboardType: TextInputType.text,
      maxLength: 100,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: "Nombre Tarea",
        errorText: controller.nombre.value ? "Este campo es obligatorio" : null
      ),
      onChanged: (value){
        
      },
      
    );
  }

  Widget _crearTextFieldDescTarea(){
    return TextField(
      controller: _descController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: "Descripción de la tarea",
        errorText: controller.descripcion.value ? "Este campo es obligatorio" : null
      ),
      maxLines: 10,
    );
  }

  Widget _crearDatePicker(context){
    return GestureDetector(
            onTap: () {
              showDatePicker(
                context: context,
                initialEntryMode: DatePickerEntryMode.calendarOnly,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(DateTime.now().year + 1))
                .then((value) {
                  this._dateController.text =
                    '${value!.year.toString()}-${value.month.toString()}-${value.day.toString()}';
                });
            },
            child: TextField(
              controller: this._dateController,
              enabled: false,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: "Fecha de entrega",
                errorText: "Este campo es obligatorio"
              ),
              onChanged: (value){
                
              }
            ),
          );
  }

  Widget _crearHourPicker(context){
    return GestureDetector(
            onTap: () {
              showTimePicker(
                context: context,
                initialTime: tarea != null ? TimeOfDay.fromDateTime(DateTime.parse( tarea!.fechaEntrega.toString())):TimeOfDay.now(),
              ).then((value) {
                String aux = '';
                value!.minute < 10 ? aux = '0${value.minute.toString()}': aux = '${value.minute.toString()}';
                this._hourController.text = '${value.hour.toString()}:' + aux;
              });
            },
            child: TextField(
              controller: this._hourController,
              enabled: false,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: "Hora de entrega",
                errorText: "Este campo es obligatorio"
              ),
              onChanged: (value){
                
              }
            ),
          );
  }

  Widget _crearButton(context){
    return ElevatedButton(
      onPressed: (){        
        _nombreController.text.isEmpty ? controller.nombre.value = true : controller.nombre.value = false;
        _descController.text.isEmpty ? controller.descripcion.value = true : controller.descripcion.value = false;
        _dateController.text.isEmpty ? controller.fecha.value = true : controller.fecha.value = false;
        _hourController.text.isEmpty ? controller.hora.value = true : controller.hora.value = false;

        if(!controller.nombre.value && !controller.descripcion.value && !controller.fecha.value && !controller.hora.value){
          TareasModel tarea = TareasModel(
            nombreTarea: _nombreController.text,
            descTarea: _descController.text,
            entregada: 0,
            fechaEntrega: '${_dateController.text} ${_hourController.text}',
            id: this.tarea?.id
          );
          if( edit ){
            _databaseHelper.update(tarea.toJson()).then((value) {
                
              if(value > 0){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Tarea Editada con éxito'),  
                  )
                );
                Navigator.pop(context);
              }else{
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('No se completó la edición'))
                );
              }
            });
          }else{
          _databaseHelper.insert(tarea.toJson()).then(
            (value){
              if(value > 0){
                _nombreController.text = '';
                _descController.text = '';
                _dateController.text = '';
                _hourController.text = '';
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Tarea Creada con éxito'),  
                  )
                );  
              }else{
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('No se completó la creación'))
                );
              }
            });
          }
          
        }else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Hay campos sin llenar')));
        }
        
        
      }, 
      child: tarea != null ? Text('Editar Tarea') : Text('Crear Tarea')
    );
  }
}





