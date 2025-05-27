import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/accesibilidad/accesibilidad_controlador.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';
import 'package:sazon_urbano/view/widgets/info_seccion.dart';

class TerminosDeServicioPantalla extends StatelessWidget {
  const TerminosDeServicioPantalla({super.key});

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
              'terminos_de_servicio'.tr,
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
                    titulo: 'comparticion_informacion'.tr,
                    contenido: 'contenido_comparticion_informacion'.tr,
                  ),

                  InfoSeccion(
                    titulo: 'seguridad_informacion'.tr,
                    contenido: 'contenido_seguridad_informacion'.tr,
                  ),

                  InfoSeccion(
                    titulo: 'derechos_control_datos'.tr,
                    contenido: 'contenido_derechos_control_datos'.tr,
                  ),

                  InfoSeccion(
                    titulo: 'cambios_terminos'.tr,
                    contenido: 'contenido_cambios_terminos'.tr,
                  ),

                  SizedBox(height: 24),
                  Text(
                    'ultima_actualizacion_terminos'.tr,
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