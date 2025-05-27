import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/accesibilidad/accesibilidad_controlador.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';
import 'package:sazon_urbano/widgets/editar%20perfil/perfil_formulario.dart';

class EditarPerfilPantalla extends StatelessWidget {
  const EditarPerfilPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.arrow_back),
            ),
            title: Text(
              'editar_perfil'.tr,
              style: AppEstilosTexto.withAccesibilidad(
                AppEstilosTexto.h3,
                agrandar: agrandar,
                espaciado: espaciado,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 32),
                PerfilFormulario(),
              ],
            ),
          ),
        ),
      );
    });
  }
}