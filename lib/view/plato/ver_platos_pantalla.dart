import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';
import 'package:sazon_urbano/view/plato/plato_grid.dart';
import 'package:sazon_urbano/view/plato/crear_plato_pantalla.dart'; // Asegúrate de importar tu pantalla de creación

class VerPlatosPantalla extends StatelessWidget {
  final String idRestaurante;
  const VerPlatosPantalla({super.key, required this.idRestaurante});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          'Platos',
          style: AppEstilosTexto.withColor(
            AppEstilosTexto.h3,
            isDark ? Colors.white : Colors.black
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
      body: PlatoGrid(idRestaurante: idRestaurante),

      floatingActionButton: SizedBox(
        width: 72,
        height: 72,
        child: FloatingActionButton(
          onPressed: () {
            Get.to(() => CrearPlatoPantalla(idRestaurante: idRestaurante,));
          },
          backgroundColor: Theme.of(context).primaryColor,
          shape: CircleBorder(),
          child: Icon(
            Icons.add,
            size: 36,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}