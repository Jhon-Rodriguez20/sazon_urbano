import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/accesibilidad/accesibilidad_controlador.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';

class InfoSeccion extends StatelessWidget {
  final String titulo;
  final String contenido;

  const InfoSeccion({
    super.key,
    required this.contenido,
    required this.titulo,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accesibilidadCtrl = Get.find<AccesibilidadControlador>();
    final agrandar = accesibilidadCtrl.agrandarTexto.value;
    final espaciado = accesibilidadCtrl.espaciadoTexto.value;

    return Container(
      margin: EdgeInsets.only(bottom: 24),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark ? const Color.fromARGB(255, 39, 39, 39) : const Color.fromARGB(255, 237, 237, 237),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: AppEstilosTexto.withAccesibilidad(
              AppEstilosTexto.h3,
              agrandar: agrandar,
              espaciado: espaciado,
              color: Theme.of(context).textTheme.bodyLarge!.color!,
            ),
          ),
          SizedBox(height: 12),
          Text(
            contenido,
            style: AppEstilosTexto.withAccesibilidad(
              AppEstilosTexto.bodyMedium,
              agrandar: agrandar,
              espaciado: espaciado,
              color: isDark ? Colors.grey[300]! : Colors.grey[700]!,
            ),
          ),
        ],
      ),
    );
  }
}