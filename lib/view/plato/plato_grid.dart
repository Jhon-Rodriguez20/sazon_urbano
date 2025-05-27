import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/plato/plato_controlador.dart';
import 'package:sazon_urbano/view/plato/plato_tarjeta.dart';

class PlatoGrid extends StatelessWidget {
  final String idRestaurante;
  const PlatoGrid({super.key, required this.idRestaurante});

  @override
  Widget build(BuildContext context) {
    final PlatoControlador controlador = Get.find<PlatoControlador>();

    return FutureBuilder(
      future: controlador.cargarPlatos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return Obx(() {
          final platosFiltrados = controlador.platosFiltrados
            .where((plato) => plato.idRestaurante == idRestaurante)
            .toList();

          if (platosFiltrados.isEmpty) {
            return Center(child: Text('platos_no_disponibles'.tr));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemCount: platosFiltrados.length,
            itemBuilder: (context, index) {
              final plato = platosFiltrados[index];
              return PlatoTarjeta(plato: plato);
            },
          );
        });
      },
    );
  }
}