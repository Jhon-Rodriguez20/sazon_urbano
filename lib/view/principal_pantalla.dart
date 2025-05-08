import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/navigation/navegacion_controlador.dart';
import 'package:sazon_urbano/controllers/theme/tema_controlador.dart';
import 'package:sazon_urbano/security/seguridad_sesion.dart';
import 'package:sazon_urbano/view/home_pantalla.dart';

class PrincipalPantalla extends StatefulWidget {
  const PrincipalPantalla({super.key});

  @override
  State<PrincipalPantalla> createState() => _PrincipalPantallaState();
}

class _PrincipalPantallaState extends State<PrincipalPantalla> {
  final NavegacionControlador navigationController = Get.find<NavegacionControlador>();

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
              key: ValueKey(navigationController.currentIndex.value),
              index: navigationController.currentIndex.value,
              children: [
                HomePantalla(),
              ],
            ),
          ),
        ),
        // bottomNavigationBar: CustomBottomNavbar(),
      ),
    );
  }
}