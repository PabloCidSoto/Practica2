import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica2/src/controllers/tareas_controllers/tareas_screen_controller.dart';
import 'package:practica2/src/models/tareas_model.dart';
import 'package:practica2/src/screens/tareas_screens/tareas_tabs/tareas_agregar_tab.dart';
import 'package:practica2/src/screens/tareas_screens/tareas_tabs/tareas_entregadas_tab.dart';
import 'package:practica2/src/screens/tareas_screens/tareas_tabs/tareas_tab.dart';

class TareasScreen extends StatelessWidget {
  static final controller = Get.put(TareasScreenController());  
  
  PageController pageController = PageController(
    initialPage: controller.currentIndex.value
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tareas'),
      ),
      body: PageView(
        children: [
          TareasTab(),
          TareasEntregadasTab(),
          AgregarTareaTab()
        ],
        onPageChanged: (page){
          controller.currentIndex.value = page;  
        },
        controller: pageController,
        
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.assignment_ind_outlined), label: 'Tareas'),
            BottomNavigationBarItem(icon: Icon(Icons.task_alt_outlined), label: 'Completadas'),
            BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: 'Crear Tarea'),
          ],
          onTap: (value) { 
            controller.changeIndex(value);
            pageController.animateToPage(value, duration: Duration(milliseconds: 750), curve: Curves.fastLinearToSlowEaseIn);
          },
        )
      ),
    );
  }

  
}