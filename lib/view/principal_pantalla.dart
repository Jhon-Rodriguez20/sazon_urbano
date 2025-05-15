import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/navigation/navegacion_controlador.dart';
import 'package:sazon_urbano/controllers/theme/tema_controlador.dart';
import 'package:sazon_urbano/security/seguridad_sesion.dart';
import 'package:sazon_urbano/view/home_pantalla.dart';
import 'package:sazon_urbano/view/mi%20cuenta/mi_cuenta_pantalla.dart';
import 'package:sazon_urbano/view/restaurante/crear_gerente_pantalla.dart';
import 'package:sazon_urbano/view/restaurante/crear_restaurante_pantalla.dart';
import 'package:sazon_urbano/view/widgets/navbar_personalizado.dart';

class PrincipalPantalla extends StatefulWidget {
  const PrincipalPantalla({super.key});

  @override
  State<PrincipalPantalla> createState() => _PrincipalPantallaState();
}

class _PrincipalPantallaState extends State<PrincipalPantalla> {
  final NavegacionControlador navegacionControlador = Get.find<NavegacionControlador>();

  @override
  void initState() {
    super.initState();
    SessionSecurity.verificarSesion();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TemaControlador>(
      builder: (themeController) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Obx(
            () => IndexedStack(
              key: ValueKey(navegacionControlador.currentIndex.value),
              index: navegacionControlador.currentIndex.value,
              children: [
                HomePantalla(),
                CrearGerentePantalla(),
                CrearRestaurantePantalla(),
                MiCuentaPantalla(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: NavbarPersonalizado(),
      ),
    );
  }
}