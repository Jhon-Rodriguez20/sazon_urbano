import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/accesibilidad/accesibilidad_controlador.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';
import 'package:sazon_urbano/view/accesibilidad/widgets/definiciones_seccion.dart';

class AccesibilidadPantalla extends StatelessWidget {
  const AccesibilidadPantalla({super.key});

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
              icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
            ),
            title: Text(
              'Accesibilidad',
              style: AppEstilosTexto.withAccesibilidad(
                AppEstilosTexto.h3,
                agrandar: agrandar,
                espaciado: espaciado,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ),
          body: Obx(() => ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Preferencias de visualización',
                style: AppEstilosTexto.withAccesibilidad(
                  AppEstilosTexto.h3,
                  agrandar: agrandar,
                  espaciado: espaciado,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 16),

              SwitchListTile(
                title: Text(
                    "Agrandar texto",
                    style: AppEstilosTexto.withAccesibilidad(
                      AppEstilosTexto.bodyMedium,
                      agrandar: agrandar,
                      espaciado: espaciado,
                      color: Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
                  ),
                value: accesibilidadCtrl.agrandarTexto.value,
                onChanged: accesibilidadCtrl.toggleAgrandarTexto,
              ),
              SwitchListTile(
                title: Text(
                    "Activar desaturación",
                    style: AppEstilosTexto.withAccesibilidad(
                      AppEstilosTexto.bodyMedium,
                      agrandar: agrandar,
                      espaciado: espaciado,
                      color: Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
                  ),
                value: accesibilidadCtrl.activarDesaturacion.value,
                onChanged: accesibilidadCtrl.toggleDesaturacion,
              ),
              SwitchListTile(
                title: Text(
                    "Espaciado de texto",
                    style: AppEstilosTexto.withAccesibilidad(
                      AppEstilosTexto.bodyMedium,
                      agrandar: agrandar,
                      espaciado: espaciado,
                      color: Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
                  ),
                value: accesibilidadCtrl.espaciadoTexto.value,
                onChanged: accesibilidadCtrl.toggleEspaciadoTexto,
              ),

              SizedBox(height: 54),
              Text(
                '¿Qué significan estas opciones?',
                style: AppEstilosTexto.withAccesibilidad(
                  AppEstilosTexto.h3,
                  agrandar: agrandar,
                  espaciado: espaciado,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),

              SizedBox(height: 20),
              DefinicionesSeccion(),
            ],
          )),
        ),
      );
    });
  }
}