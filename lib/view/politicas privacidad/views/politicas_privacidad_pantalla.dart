import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/accesibilidad/accesibilidad_controlador.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';
import 'package:sazon_urbano/view/widgets/info_seccion.dart';

class PoliticasPrivacidadPantalla extends StatelessWidget {
  const PoliticasPrivacidadPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenSize = MediaQuery.of(context).size;
    final accesibilidadCtrl = Get.find<AccesibilidadControlador>();
    
    return Obx(() {
      final agrandar = accesibilidadCtrl.agrandarTexto.value;
      final espaciado = accesibilidadCtrl.espaciadoTexto.value;
      final desaturar = accesibilidadCtrl.activarDesaturacion.value;

      return ColorFiltered(
        colorFilter: desaturar
          ? const ColorFilter.matrix(<double>[
            0.2126, 0.7152, 0.0722, 0, 0,
            0.2126, 0.7152, 0.0722, 0, 0,
            0.2126, 0.7152, 0.0722, 0, 0,
            0, 0, 0, 1, 0,
          ])
          : const ColorFilter.mode(Colors.transparent, BlendMode.dst),
        child: Scaffold(
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
              'politicas_privacidad'.tr,
              style: AppEstilosTexto.withAccesibilidad(
                AppEstilosTexto.h3,
                agrandar: agrandar,
                espaciado: espaciado,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(screenSize.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoSeccion(
                    titulo: 'informacion_recolectamos'.tr,
                    contenido: 'contenido_informacion_recolectamos'.tr,
                  ),
                  InfoSeccion(
                    titulo: 'como_usamos_tu_informacion'.tr,
                    contenido: 'contenido_como_usamos_tu_informacion'.tr,
                  ),
                  SizedBox(height: 24),
                  Text(
                    'ultima_actualizacion_politicas'.tr,
                    style: AppEstilosTexto.withAccesibilidad(
                      AppEstilosTexto.bodySmall,
                      agrandar: agrandar,
                      espaciado: espaciado,
                      color: isDark ? Colors.grey[400]! : Colors.grey[600]!,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}