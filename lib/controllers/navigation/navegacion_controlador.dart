import 'package:get/get.dart';

class NavegacionControlador extends GetxController {
  final RxInt currentIndex = 0.obs;

  void cambiarIndex(int index) {
    currentIndex.value = index;
  }
}