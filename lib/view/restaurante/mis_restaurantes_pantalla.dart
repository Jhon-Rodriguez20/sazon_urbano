import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/accesibilidad/accesibilidad_controlador.dart';
import 'package:sazon_urbano/controllers/restaurante/restaurante_controlador.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';
import 'package:sazon_urbano/view/restaurante/restaurante_grid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sazon_urbano/view/widgets/barra_busqueda_personalizado.dart';

class MisRestaurantesPantalla extends StatelessWidget {
  const MisRestaurantesPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    final accesibilidadCtrl = Get.find<AccesibilidadControlador>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final restauranteControlador = Get.put(RestauranteControlador());
    final String idUsuario = FirebaseAuth.instance.currentUser!.uid;
    final desaturar = accesibilidadCtrl.activarDesaturacion.value;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      restauranteControlador.cargarMisRestaurantes(idUsuario);
    });

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
                Icons.arrow_back,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            title: Text(
              'mis_restaurantes'.tr,
              style: AppEstilosTexto.withColor(
                AppEstilosTexto.h3,
                isDark ? Colors.white : Colors.black
              ),
            ),
          ),
          body: Obx(() {
          if (restauranteControlador.cargando.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final restaurantes = restauranteControlador.restaurantes;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(3),
                child: BarraBusquedaPersonalizado(
                  hintText: 'buscador_personalizado_restaurante'.tr,
                  onChanged: (valor) =>
                      restauranteControlador.terminoBusqueda.value = valor,
                ),
              ),
              Expanded(
                child: restaurantes.isEmpty
                    ? const Center(child: Text('No tienes restaurantes registrados.'))
                    : RestauranteGrid(),
              ),
            ],
          );
        }),
      ),
    );
  }
}