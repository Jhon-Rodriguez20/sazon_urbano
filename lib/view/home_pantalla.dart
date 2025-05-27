import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/accesibilidad/accesibilidad_controlador.dart';
import 'package:sazon_urbano/controllers/idioma/idioma_controlador.dart';
import 'package:sazon_urbano/controllers/restaurante/restaurante_controlador.dart';
import 'package:sazon_urbano/security/seguridad_sesion.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';
import 'package:sazon_urbano/view/restaurante/restaurante_grid.dart';
import 'package:sazon_urbano/view/widgets/promocion_banner.dart';
import 'package:sazon_urbano/widgets/editar perfil/avatar_usuario.dart';

class HomePantalla extends StatefulWidget {
  const HomePantalla({super.key});

  @override
  State<HomePantalla> createState() => _HomePantallaState();
}

class _HomePantallaState extends State<HomePantalla> {
  final RestauranteControlador restauranteControlador = Get.put(RestauranteControlador());

  @override
  void initState() {
    super.initState();
    SessionSecurity.verificarSesion();
    restauranteControlador.cargarRestaurantes();
  }

  String obtenerSaludo() {
    final horaActual = DateTime.now().hour;
    if (horaActual >= 5 && horaActual < 12) {
      return 'greeting_morning'.tr;
    } else if (horaActual >= 12 && horaActual < 18) {
      return 'greeting_afternoon'.tr;
    } else {
      return 'greeting_evening'.tr;
    }
  }

  @override
  Widget build(BuildContext context) {
    final usuario = FirebaseAuth.instance.currentUser;
    final accesibilidadCtrl = Get.find<AccesibilidadControlador>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final idiomaCtrl = Get.find<IdiomaControlador>();

    if (usuario == null) {
      return const Scaffold(
        body: Center(
          child: Text("Usuario no autenticado"),
        ),
      );
    }

    final nombreUsuario = usuario.displayName?.isNotEmpty == true
        ? usuario.displayName
        : usuario.email?.split('@').first ?? 'Usuario';

    return Obx(() {
      return ColorFiltered(
        colorFilter: accesibilidadCtrl.activarDesaturacion.value
        ? const ColorFilter.matrix([
            0.2126, 0.7152, 0.0722, 0, 0,
            0.2126, 0.7152, 0.0722, 0, 0,
            0.2126, 0.7152, 0.0722, 0, 0,
            0, 0, 0, 1, 0,
          ])
        : const ColorFilter.mode(
            Colors.transparent,
            BlendMode.multiply,
          ),
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      AvatarUsuario(radius: 20),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$nombreUsuario',
                            style: AppEstilosTexto.withAccesibilidad(
                              AppEstilosTexto.bodyMedium,
                              agrandar: accesibilidadCtrl.agrandarTexto.value,
                              espaciado: accesibilidadCtrl.espaciadoTexto.value,
                              color: Colors.grey
                            ),
                          ),
                          Text(
                            obtenerSaludo(),
                            style: AppEstilosTexto.withAccesibilidad(
                              AppEstilosTexto.h3,
                              agrandar: accesibilidadCtrl.agrandarTexto.value,
                              espaciado: accesibilidadCtrl.espaciadoTexto.value,
                              color: isDark ? Colors.white : Colors.black
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: idiomaCtrl.idiomaActual.value,
                          icon: const Icon(Icons.arrow_drop_down),
                          onChanged: (String? nuevoCodigo) {
                            if (nuevoCodigo != null) {
                              idiomaCtrl.cambiarIdioma(nuevoCodigo);
                            }
                          },
                          items: idiomaCtrl.idiomas.map((idioma) {
                            return DropdownMenuItem<String>(
                              value: idioma['codigo'],
                              child: Row(
                                children: [
                                  Text(
                                    idioma['bandera'] as String,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    idioma['nombre'] as String,
                                    style: AppEstilosTexto.withAccesibilidad(
                                      AppEstilosTexto.bodyMedium,
                                      agrandar: accesibilidadCtrl.agrandarTexto.value,
                                      espaciado: accesibilidadCtrl.espaciadoTexto.value,
                                      color: isDark ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                PromocionBanner(),
                Expanded(child: RestauranteGrid()),
              ],
            ),
          ),
        ),
      );
    });
  }
}