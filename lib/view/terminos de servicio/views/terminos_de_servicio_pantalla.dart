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
              'Términos de Servicio',
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
                    titulo: 'Compartición de información con terceros',
                    contenido: 'No vendemos tu información personal. Sin embargo, podríamos compartir datos agregados y anónimos con aliados turísticos para mejorar la calidad de nuestras recomendaciones.',
                  ),

                  InfoSeccion(
                    titulo: 'Seguridad de la información',
                    contenido: 'Nos comprometemos a proteger tu información mediante medidas técnicas y organizativas. Aunque ningún sistema es 100% seguro, trabajamos constantemente para prevenir accesos no autorizados.',
                  ),

                  InfoSeccion(
                    titulo: 'Tus derechos y control sobre tus datos',
                    contenido: 'Puedes acceder, modificar o eliminar tu información personal desde la sección de perfil. También puedes solicitarnos que dejemos de utilizar tus datos en cualquier momento.',
                  ),

                  InfoSeccion(
                    titulo: 'Cambios a estos términos',
                    contenido: 'Nos reservamos el derecho de actualizar estos términos. Si realizamos cambios significativos, te notificaremos a través de la aplicación.',
                  ),

                  SizedBox(height: 24),
                  Text(
                    'Última actualización: Mayo 28 2025',
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