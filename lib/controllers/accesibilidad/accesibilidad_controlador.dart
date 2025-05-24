import 'package:get/get.dart';

class AccesibilidadControlador extends GetxController {
  var agrandarTexto = false.obs;
  var activarDesaturacion = false.obs;
  var espaciadoTexto = false.obs;

  void toggleAgrandarTexto(bool value) => agrandarTexto.value = value;
  void toggleDesaturacion(bool value) => activarDesaturacion.value = value;
  void toggleEspaciadoTexto(bool value) => espaciadoTexto.value = value;
}