import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/navigation/navegacion_controlador.dart';
import 'package:sazon_urbano/controllers/theme/tema_controlador.dart';
import 'package:sazon_urbano/view/home_pantalla.dart';

class PrincipalPantalla extends StatelessWidget {
  const PrincipalPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    final NavegacionControlador navigationController = Get.find<NavegacionControlador>();

    return GetBuilder<TemaControlador>(
      builder: (themeController)=> Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: Obx(
          () => IndexedStack(
            key: ValueKey(navigationController.currentIndex.value),
            index: navigationController.currentIndex.value,
            children: [
              HomePantalla(),
              // ShoppingScreen(),
              // WishlistScreen(),
              // AccountScreen(),
            ],
          )
        ),
      ),
      // bottomNavigationBar: CustomBottomNavbar(),
    ));
  }
}