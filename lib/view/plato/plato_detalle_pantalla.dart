import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/accesibilidad/accesibilidad_controlador.dart';
import 'package:sazon_urbano/models/plato/plato_modelo.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';

class PlatoDetallePantalla extends StatelessWidget {
  final Plato plato;
  const PlatoDetallePantalla({super.key, required this.plato});

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
                  child: plato.urlImagen.isNotEmpty
                      ? Image.network(
                          plato.urlImagen,
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
                              Icon(Icons.dinner_dining_outlined, color: Theme.of(context).primaryColor),
                              SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  plato.nombrePlato,
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
                              Icon(Icons.price_check_sharp, color: Theme.of(context).primaryColor),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  '${plato.precio} COP',
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.description_outlined, color: Theme.of(context).primaryColor),
                              SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      plato.descripcion,
                                      style: AppEstilosTexto.withAccesibilidad(
                                        AppEstilosTexto.bodyMedium,
                                        agrandar: agrandar,
                                        espaciado: espaciado,
                                        color: Theme.of(context).textTheme.headlineMedium!.color!,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 40,),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.history_outlined, color: Theme.of(context).primaryColor),
                              SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'historia_y_tradicion'.tr,
                                      style: AppEstilosTexto.withAccesibilidad(
                                        AppEstilosTexto.h3,
                                        agrandar: agrandar,
                                        espaciado: espaciado,
                                        color: Theme.of(context).textTheme.headlineMedium!.color!,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      plato.historial,
                                      style: AppEstilosTexto.withAccesibilidad(
                                        AppEstilosTexto.bodyMedium,
                                        agrandar: agrandar,
                                        espaciado: espaciado,
                                        color: Theme.of(context).textTheme.headlineMedium!.color!,
                                      ),
                                    ),
                                  ],
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
        ),
      );
    });
  }
}