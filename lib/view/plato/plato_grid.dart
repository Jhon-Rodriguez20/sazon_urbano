import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/plato/plato_controlador.dart';
import 'package:sazon_urbano/view/plato/plato_tarjeta.dart';

class PlatoGrid extends StatelessWidget {
  final String idRestaurante;
  const PlatoGrid({super.key, required this.idRestaurante});

  @override
  Widget build(BuildContext context) {
    final PlatoControlador controlador = Get.put(PlatoControlador());

    return FutureBuilder(
      future: controlador.cargarPlatos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final platosFiltrados = controlador.platos
            .where((plato) => plato.idRestaurante == idRestaurante)
            .toList();

        if (platosFiltrados.isEmpty) {
          return const Center(child: Text('No hay platos disponibles.'));
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
            return PlatoTarjeta(plato: platosFiltrados[index]);
          },
        );
      },
    );
  }
}