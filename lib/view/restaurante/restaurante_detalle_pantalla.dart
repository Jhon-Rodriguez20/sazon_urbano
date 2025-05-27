import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/accesibilidad/accesibilidad_controlador.dart';
import 'package:sazon_urbano/models/restaurante/restaurante_modelo.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';
import 'package:sazon_urbano/view/plato/ver_platos_pantalla.dart';
import 'package:url_launcher/url_launcher.dart';

class RestauranteDetallePantalla extends StatelessWidget {
  final Restaurante restaurante;
  const RestauranteDetallePantalla({super.key, required this.restaurante});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
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
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            title: Text(
              'details'.tr,
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 11,
                  child: restaurante.urlImagen.isNotEmpty
                      ? Image.network(
                          restaurante.urlImagen,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Center(
                            child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                          ),
                        )
                      : Center(
                          child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                        ),
                ),
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.store, color: Theme.of(context).primaryColor),
                          SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              restaurante.razonSocial,
                              style: AppEstilosTexto.withAccesibilidad(
                                AppEstilosTexto.h2,
                                agrandar: agrandar,
                                espaciado: espaciado,
                                color: Theme.of(context).textTheme.headlineMedium!.color!,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Row(
                        children: [
                          Icon(Icons.phone, color: Theme.of(context).primaryColor),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              restaurante.telefono,
                              style: AppEstilosTexto.withAccesibilidad(
                                AppEstilosTexto.bodyMedium,
                                agrandar: agrandar,
                                espaciado: espaciado,
                                color: Theme.of(context).textTheme.headlineMedium!.color!,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Theme.of(context).primaryColor),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              restaurante.direccion,
                              style: AppEstilosTexto.withAccesibilidad(
                                AppEstilosTexto.bodyMedium,
                                agrandar: agrandar,
                                espaciado: espaciado,
                                color: Theme.of(context).textTheme.headlineMedium!.color!,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Get.to(() => VerPlatosPantalla(idRestaurante: restaurante.idRestaurante));
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                        side: BorderSide(
                          color: isDark ? Colors.white70 : Colors.black12,
                        ),
                      ),
                      child: Text(
                        'ver_platos'.tr,
                        style: AppEstilosTexto.withAccesibilidad(
                          AppEstilosTexto.buttonMedium,
                          agrandar: agrandar,
                          espaciado: espaciado,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final direccion = Uri.encodeComponent(restaurante.direccion);
                        final url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$direccion');

                        if (await canLaunchUrl(url)) {
                          await launchUrl(url, mode: LaunchMode.externalApplication);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      child: Text(
                        'ver_ubicacion'.tr,
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
      );
    });
  }
}