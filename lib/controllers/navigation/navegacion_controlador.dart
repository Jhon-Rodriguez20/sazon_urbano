import 'package:get/get.dart';
import 'package:sazon_urbano/view/home_pantalla.dart';
import 'package:sazon_urbano/view/mi cuenta/mi_cuenta_pantalla.dart';
import 'package:sazon_urbano/view/restaurante/crear_gerente_pantalla.dart';
import 'package:sazon_urbano/view/restaurante/crear_restaurante_pantalla.dart';
import 'package:get_storage/get_storage.dart';

class NavegacionControlador extends GetxController {
  final RxInt currentIndex = 0.obs;
  final RxList<dynamic> pantallas = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    _generarPantallasPorRol();
  }

  void cambiarIndex(int index) {
    if (index < pantallas.length) {
      currentIndex.value = index;
    } else {
      currentIndex.value = 0;
    }
  }

  void _generarPantallasPorRol() {
    final rol = GetStorage().read('idRol') ?? '3';
    final List pantallasPorRol = [HomePantalla()];

    if (rol == '1') {
      pantallasPorRol.add(CrearGerentePantalla());
    } else if (rol == '2') {
      pantallasPorRol.add(CrearRestaurantePantalla());
    }

    pantallasPorRol.add(MiCuentaPantalla());
    pantallas.assignAll(pantallasPorRol);
  }
}