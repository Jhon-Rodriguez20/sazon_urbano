import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/models/restaurante/restaurante_modelo.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';
import 'package:sazon_urbano/view/plato/ver_platos_pantalla.dart';

class RestauranteDetallePantalla extends StatelessWidget {
  final Restaurante restaurante;
  const RestauranteDetallePantalla({super.key, required this.restaurante});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          'Detalles',
          style: AppEstilosTexto.withColor(
            AppEstilosTexto.h3,
            isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Imagen del restaurante (si no hay, mostrar ícono por defecto)
            AspectRatio(
              aspectRatio: 16 / 9,
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
                      // Nombre centrado con ícono
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.store, color: Theme.of(context).primaryColor),
                          SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              restaurante.razonSocial,
                              style: AppEstilosTexto.withColor(
                                AppEstilosTexto.h2,
                                Theme.of(context).textTheme.headlineMedium!.color!,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.03),

                      // Teléfono (en su propia fila)
                      Row(
                        children: [
                          Icon(Icons.phone, color: Theme.of(context).primaryColor),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              restaurante.telefono,
                              style: AppEstilosTexto.withColor(
                                AppEstilosTexto.bodyMedium,
                                Theme.of(context).textTheme.headlineMedium!.color!,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.03),

                      // Dirección (en su propia fila)
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Theme.of(context).primaryColor),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              restaurante.direccion,
                              style: AppEstilosTexto.withColor(
                                AppEstilosTexto.bodyMedium,
                                Theme.of(context).textTheme.headlineMedium!.color!,
                              ),
                              overflow: TextOverflow.ellipsis,
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
                    'Ver Platos',
                    style: AppEstilosTexto.withColor(
                      AppEstilosTexto.buttonMedium,
                      Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.04),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: Text(
                    'Ver ubicación',
                    style: AppEstilosTexto.withColor(
                      AppEstilosTexto.buttonMedium,
                      Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}