import 'package:get/get.dart';
class TareasScreenController{
  final currentIndex = 0.obs;

  void changeIndex(int index){
    currentIndex.value = index;
  }

  
}