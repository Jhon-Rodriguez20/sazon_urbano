import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/navigation/navegacion_controlador.dart';
import 'package:sazon_urbano/controllers/theme/tema_controlador.dart';
import 'package:sazon_urbano/security/seguridad_sesion.dart';
import 'package:sazon_urbano/view/widgets/navbar_personalizado.dart';

class PrincipalPantalla extends StatefulWidget {
  const PrincipalPantalla({super.key});

  @override
  State<PrincipalPantalla> createState() => _PrincipalPantallaState();
}

class _PrincipalPantallaState extends State<PrincipalPantalla> {
  late final NavegacionControlador navegacionControlador;

  @override
  void initState() {
    super.initState();

    if (!Get.isRegistered<NavegacionControlador>()) {
      navegacionControlador = Get.put(NavegacionControlador());
    } else {
      navegacionControlador = Get.find<NavegacionControlador>();
    }

    SessionSecurity.verificarSesion();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TemaControlador>(
      builder: (themeController) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Obx(() {
          final pantallas = navegacionControlador.pantallas.cast<Widget>();
          final index = navegacionControlador.currentIndex.value;

          final safeIndex = index >= pantallas.length ? 0 : index;

          return IndexedStack(
            key: ValueKey(safeIndex),
            index: safeIndex,
            children: pantallas,
          );
        }),
        bottomNavigationBar: NavbarPersonalizado(),
      ),
    );
  }
}