import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/restaurante/restaurante_controlador.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';
import 'package:sazon_urbano/view/restaurante/restaurante_grid.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MisRestaurantesPantalla extends StatelessWidget {
  const MisRestaurantesPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final restauranteControlador = Get.put(RestauranteControlador());
    final String idUsuario = FirebaseAuth.instance.currentUser!.uid;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      restauranteControlador.cargarMisRestaurantes(idUsuario);
    });
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          'Mis Restaurantes',
          style: AppEstilosTexto.withColor(
            AppEstilosTexto.h3,
            isDark ? Colors.white : Colors.black
          ),
        ),
        actions: [
          // search icon
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),

          // filter icon
          // IconButton(
          //   onPressed: () => FilterBottomSheet.show(context),
          //   icon: Icon(
          //     Icons.filter_list,
          //     color: isDark ? Colors.white : Colors.black,
          //   ),
          // ),
        ],
      ),
      body: Obx(() {
        if (restauranteControlador.cargando.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final restaurantes = restauranteControlador.restaurantes;
        if (restaurantes.isEmpty) {
          return const Center(child: Text('No tienes restaurantes registrados.'));
        }

        return RestauranteGrid();
      }),
    );
  }
}