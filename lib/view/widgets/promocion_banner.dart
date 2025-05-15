import 'package:flutter/material.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';

class PromocionBanner extends StatelessWidget {
  const PromocionBanner({super.key});

  @override
  Widget build(BuildContext context) {
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
                  style: AppEstilosTexto.withColor(
                    AppEstilosTexto.h3,
                    Colors.white
                  ),
                ),
                Text(
                  'Restaurantes',
                  style: AppEstilosTexto.withColor(
                    AppEstilosTexto.withWeight(AppEstilosTexto.h2, FontWeight.bold,),
                    Colors.white
                  ),
                ),
                Text(
                  'de la región',
                  style: AppEstilosTexto.withColor(
                    AppEstilosTexto.h3,
                    Colors.white
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
              'Ver todos',
              style: AppEstilosTexto.buttonMedium,
            ),
          ),
        ],
      ),
    );
  }
}