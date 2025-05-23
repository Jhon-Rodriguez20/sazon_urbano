import 'package:flutter/material.dart';
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
                      // Nombre centrado con ícono
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.dinner_dining_outlined, color: Theme.of(context).primaryColor),
                          SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              plato.nombrePlato,
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
                          Icon(Icons.price_check_sharp, color: Theme.of(context).primaryColor),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${plato.precio} COP',
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
                              plato.descripcion,
                              style: AppEstilosTexto.withColor(
                                AppEstilosTexto.bodyMedium,
                                Theme.of(context).textTheme.headlineMedium!.color!,
                              ),
                              overflow: TextOverflow.ellipsis,
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
                                  'Historia y tradición',
                                  style: AppEstilosTexto.withColor(
                                    AppEstilosTexto.h3,
                                    Theme.of(context).textTheme.headlineMedium!.color!,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  plato.historial,
                                  style: AppEstilosTexto.withColor(
                                    AppEstilosTexto.bodyMedium,
                                    Theme.of(context).textTheme.headlineMedium!.color!,
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
    );
  }
}