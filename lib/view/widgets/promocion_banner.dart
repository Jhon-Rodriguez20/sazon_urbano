import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/accesibilidad/accesibilidad_controlador.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';

class PromocionBanner extends StatelessWidget {
  const PromocionBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final accesibilidadCtrl = Get.find<AccesibilidadControlador>();

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'promo_best'.tr,
                  style: AppEstilosTexto.withAccesibilidad(
                    AppEstilosTexto.h3,
                    agrandar: accesibilidadCtrl.agrandarTexto.value,
                    espaciado: accesibilidadCtrl.espaciadoTexto.value,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'promo_restaurants'.tr,
                  style: AppEstilosTexto.withAccesibilidad(
                    AppEstilosTexto.withColor(
                      AppEstilosTexto.withWeight(AppEstilosTexto.h2, FontWeight.bold),
                      Colors.white,
                    ),
                    agrandar: accesibilidadCtrl.agrandarTexto.value,
                    espaciado: accesibilidadCtrl.espaciadoTexto.value,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'promo_region'.tr,
                  style: AppEstilosTexto.withAccesibilidad(
                    AppEstilosTexto.h3,
                    agrandar: accesibilidadCtrl.agrandarTexto.value,
                    espaciado: accesibilidadCtrl.espaciadoTexto.value,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Icon(
              Icons.restaurant_outlined,
              color: Colors.white,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}