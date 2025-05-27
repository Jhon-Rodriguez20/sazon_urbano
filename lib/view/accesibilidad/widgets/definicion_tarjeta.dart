import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/accesibilidad/accesibilidad_controlador.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';

class DefinicionTarjeta extends StatelessWidget {
  final String titulo;
  final IconData icono;

  const DefinicionTarjeta({
    super.key,
    required this.titulo,
    required this.icono,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accesibilidadCtrl = Get.find<AccesibilidadControlador>();
    final agrandar = accesibilidadCtrl.agrandarTexto.value;
    final espaciado = accesibilidadCtrl.espaciadoTexto.value;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDark ? const Color.fromARGB(255, 39, 39, 39) : const Color.fromARGB(255, 237, 237, 237),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(
          icono,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          titulo.tr,
          style: AppEstilosTexto.withAccesibilidad(
            AppEstilosTexto.bodyMedium,
            agrandar: agrandar,
            espaciado: espaciado,
            color: Theme.of(context).textTheme.bodyLarge!.color!,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: isDark ? Colors.grey[400] : Colors.grey[600],
          size: 16,
        ),
        onTap: () => _showAnswerBottomSheet(context, titulo, isDark),
      ),
    );
  }

  void _showAnswerBottomSheet(BuildContext context, String definicionKey, bool isDark) {
    final accesibilidadCtrl = Get.find<AccesibilidadControlador>();
    final agrandar = accesibilidadCtrl.agrandarTexto.value;
    final espaciado = accesibilidadCtrl.espaciadoTexto.value;
    final desaturar = accesibilidadCtrl.activarDesaturacion.value;

    Get.bottomSheet(
      ColorFiltered(
        colorFilter: desaturar
            ? const ColorFilter.matrix(<double>[
                0.2126, 0.7152, 0.0722, 0, 0,
                0.2126, 0.7152, 0.0722, 0, 0,
                0.2126, 0.7152, 0.0722, 0, 0,
                0, 0, 0, 1, 0,
              ])
            : const ColorFilter.mode(Colors.transparent, BlendMode.dst),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        definicionKey.tr,
                        style: AppEstilosTexto.withAccesibilidad(
                          AppEstilosTexto.h3,
                          agrandar: agrandar,
                          espaciado: espaciado,
                          color: Theme.of(context).textTheme.bodyLarge!.color!,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.close,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'respuesta_$definicionKey'.tr,
                  style: AppEstilosTexto.withAccesibilidad(
                    AppEstilosTexto.bodyMedium,
                    agrandar: agrandar,
                    espaciado: espaciado,
                    color: Theme.of(context).textTheme.bodyLarge!.color!,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'entendido'.tr,
                      style: AppEstilosTexto.withAccesibilidad(
                        AppEstilosTexto.buttonMedium,
                        agrandar: agrandar,
                        espaciado: espaciado,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}