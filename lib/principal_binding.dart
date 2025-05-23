import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/navigation/navegacion_controlador.dart';

class PrincipalBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NavegacionControlador());
  }
}