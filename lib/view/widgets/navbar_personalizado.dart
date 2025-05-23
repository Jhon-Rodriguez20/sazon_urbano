import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/navigation/navegacion_controlador.dart';
import 'package:get_storage/get_storage.dart';

class NavbarPersonalizado extends StatelessWidget {
  const NavbarPersonalizado({super.key});

  @override
  Widget build(BuildContext context) {
    final navegacionControlador = Get.find<NavegacionControlador>();
    final rol = GetStorage().read('idRol') ?? '3';

    final items = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
      if (rol == '1') ...[
        const BottomNavigationBarItem(icon: Icon(Icons.person_add), label: 'Crear Gerente'),
      ] else if (rol == '2') ...[
        const BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: 'Crear Restaurante'),
      ],
      const BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Mi Cuenta'),
    ];

    return Obx(() {
      return BottomNavigationBar(
        currentIndex: navegacionControlador.currentIndex.value,
        onTap: (index) => navegacionControlador.cambiarIndex(index),
        items: items,
      );
    });
  }
}