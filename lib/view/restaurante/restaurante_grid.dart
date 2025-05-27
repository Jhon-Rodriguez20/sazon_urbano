import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/restaurante/restaurante_controlador.dart';
import 'package:sazon_urbano/view/restaurante/restaurante_tarjeta.dart';

class RestauranteGrid extends StatelessWidget {
  final RestauranteControlador controlador = Get.find();

  RestauranteGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final lista = controlador.restaurantesFiltrados;

      if (lista.isEmpty) {
        return Center(child: Text('restaurantes_no_disponibles'.tr));
      }

      return GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: lista.length,
        itemBuilder: (context, index) {
          final restaurante = lista[index];
          return RestauranteTarjeta(restaurante: restaurante);
        },
      );
    });
  }
}