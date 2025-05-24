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
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
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
                  'Los mejores',
                  style: AppEstilosTexto.withAccesibilidad(
                    AppEstilosTexto.h3,
                    agrandar: accesibilidadCtrl.agrandarTexto.value,
                    espaciado: accesibilidadCtrl.espaciadoTexto.value,
                    color: Colors.white
                  ),
                ),
                Text(
                  'Restaurantes',
                  style: AppEstilosTexto.withAccesibilidad(
                    AppEstilosTexto.withColor(
                      AppEstilosTexto.withWeight(AppEstilosTexto.h2, FontWeight.bold,),
                    Colors.white
                    ),
                    agrandar: accesibilidadCtrl.agrandarTexto.value,
                    espaciado: accesibilidadCtrl.espaciadoTexto.value,
                    color: Colors.white
                  ),
                ),
                Text(
                  'de la región',
                  style: AppEstilosTexto.withAccesibilidad(
                    AppEstilosTexto.h3,
                    agrandar: accesibilidadCtrl.agrandarTexto.value,
                    espaciado: accesibilidadCtrl.espaciadoTexto.value,
                    color: Colors.white
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: (){
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            child: Text(
              'Verlos',
              style: AppEstilosTexto.buttonMedium,
            ),
          ),
        ],
      ),
    );
  }
}