import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/navigation/navegacion_controlador.dart';

class NavbarPersonalizado extends StatelessWidget {
  const NavbarPersonalizado({super.key});

  @override
  Widget build(BuildContext context) {
    final NavegacionControlador navegacionControlador = Get.find<NavegacionControlador>();
    return Obx(
      ()=> BottomNavigationBar(
        currentIndex: navegacionControlador.currentIndex.value,
        onTap: (index) => navegacionControlador.cambiarIndex(index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Crear Gerente'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Crear Restaurante'
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person_outline),
          //   label: 'Ver Pedidos'
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Mi Cuenta'
          ),
        ],
      )
    );
  }
}