import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/models/restaurante/restaurante_modelo.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';
import 'package:sazon_urbano/view/restaurante/restaurante_detalle_pantalla.dart';

class RestauranteTarjeta extends StatelessWidget {
  final Restaurante restaurante;
  const RestauranteTarjeta({super.key, required this.restaurante});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        Get.to(() => RestauranteDetallePantalla(restaurante: restaurante));
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? const Color.fromARGB(255, 39, 39, 39)
                  : const Color.fromARGB(255, 237, 237, 237),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen
            AspectRatio(
              aspectRatio: 16 / 11,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  restaurante.urlImagen,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurante.razonSocial,
                    style: AppEstilosTexto.withColor(
                      AppEstilosTexto.withWeight(
                          AppEstilosTexto.h3, FontWeight.bold),
                      Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: screenWidth * 0.01),
                  Text(
                    'Tel: ${restaurante.telefono}',
                    style: AppEstilosTexto.withColor(
                      AppEstilosTexto.bodyMedium,
                      isDark ? Colors.grey[400]! : Colors.grey[600]!,
                    ),
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