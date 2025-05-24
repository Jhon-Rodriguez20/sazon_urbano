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
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Definiciones',
            style: AppEstilosTexto.withAccesibilidad(
              AppEstilosTexto.h3,
              agrandar: agrandar,
              espaciado: espaciado,
              color: Theme.of(context).textTheme.bodyLarge!.color!,
            ),
          ),
          SizedBox(height: 16,),
          DefinicionTarjeta(
            titulo: 'Agrandar texto',
            icono: Icons.format_size_outlined
          ),
          SizedBox(height: 12,),
          DefinicionTarjeta(
            titulo: 'Activar desaturación',
            icono: Icons.invert_colors_off_outlined
          ),
          SizedBox(height: 12,),
          DefinicionTarjeta(
            titulo: 'Espaciado de texto',
            icono: Icons.space_bar_outlined
          ),
        ],
      ),
    );
  }
}