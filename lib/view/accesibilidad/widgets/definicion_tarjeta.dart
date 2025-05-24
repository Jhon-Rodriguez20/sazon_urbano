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
          titulo,
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

  void _showAnswerBottomSheet(BuildContext context, String definicion, bool isDark) {
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
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
                        definicion,
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
                SizedBox(height: 24),
                Text(
                  _obtenerRespuesta(definicion),
                  style: AppEstilosTexto.withAccesibilidad(
                    AppEstilosTexto.bodyMedium,
                    agrandar: agrandar,
                    espaciado: espaciado,
                    color: Theme.of(context).textTheme.bodyLarge!.color!,
                  ),
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Entendido',
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

  String _obtenerRespuesta(String question) {
    final answers = {
      'Agrandar texto': 'Cuando esta opción está activada:\n\n'
          'Los textos de la aplicación aumentan su tamaño para facilitar la lectura, especialmente para personas con dificultades visuales.',
      
      'Activar desaturación': 'Cuando esta opción está activada:\n\n'
          'Elimina los colores vivos de la aplicación y los reemplaza por una escala de grises. Es útil para personas con sensibilidad a los colores o que prefieren una visualización más neutral',

      'Espaciado de texto': 'Cuando esta opción está activada:\n\n'
          'Activa un mayor espacio entre las letras y líneas del texto. Esto mejora la legibilidad para personas con dislexia u otras dificultades de lectura.'
    };

    return answers[question] ?? 'Information no available. Please contact to support for assistance.';
  }
}