import 'package:sazon_urbano/controllers/auth/autenticacion_controlador.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/view/iniciar_sesion_pantalla.dart';

class SessionSecurity {
  static void verificarSesion() {
    final AutenticacionControlador authController = Get.find<AutenticacionControlador>();

    if (authController.sesionExpirada()) {
      authController.logout();
      Get.offAll(()=> IniciarSesionPantalla());
    }
  }
}