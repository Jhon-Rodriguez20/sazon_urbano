import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/accesibilidad/accesibilidad_controlador.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';
import 'package:sazon_urbano/view/accesibilidad/widgets/definicion_tarjeta.dart';

class DefinicionesSeccion extends StatelessWidget {
  const DefinicionesSeccion({super.key});

  @override
  Widget build(BuildContext context) {
    final accesibilidadCtrl = Get.find<AccesibilidadControlador>();
    final agrandar = accesibilidadCtrl.agrandarTexto.value;
    final espaciado = accesibilidadCtrl.espaciadoTexto.value;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'definiciones_titulo'.tr,
            style: AppEstilosTexto.withAccesibilidad(
              AppEstilosTexto.h3,
              agrandar: agrandar,
              espaciado: espaciado,
              color: Theme.of(context).textTheme.bodyLarge!.color!,
            ),
          ),
          const SizedBox(height: 16),
          DefinicionTarjeta(
            titulo: 'agrandar_texto',
            icono: Icons.format_size_outlined,
          ),
          const SizedBox(height: 12),
          DefinicionTarjeta(
            titulo: 'activar_desaturacion',
            icono: Icons.invert_colors_off_outlined,
          ),
          const SizedBox(height: 12),
          DefinicionTarjeta(
            titulo: 'espaciado_texto',
            icono: Icons.space_bar_outlined,
          ),
        ],
      ),
    );
  }
}