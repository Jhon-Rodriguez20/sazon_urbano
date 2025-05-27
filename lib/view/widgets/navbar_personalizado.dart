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
      BottomNavigationBarItem(
        icon: const Icon(Icons.home_outlined),
        label: 'nav_home'.tr,
      ),
      if (rol == '1') ...[
        BottomNavigationBarItem(
          icon: const Icon(Icons.person_add),
          label: 'nav_create_manager'.tr,
        ),
      ] else if (rol == '2') ...[
        BottomNavigationBarItem(
          icon: const Icon(Icons.restaurant),
          label: 'nav_create_restaurant'.tr,
        ),
      ],
      BottomNavigationBarItem(
        icon: const Icon(Icons.person_outline),
        label: 'nav_account'.tr,
      ),
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