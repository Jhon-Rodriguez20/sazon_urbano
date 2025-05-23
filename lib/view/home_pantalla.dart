import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/restaurante/restaurante_controlador.dart';
import 'package:sazon_urbano/security/seguridad_sesion.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sazon_urbano/view/restaurante/restaurante_grid.dart';
import 'package:sazon_urbano/view/widgets/promocion_banner.dart';
import 'package:sazon_urbano/widgets/editar%20perfil/avatar_usuario.dart';

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
      return 'Buenos días';
    } else if (horaActual >= 12 && horaActual < 18) {
      return 'Buenas tardes';
    } else {
      return 'Buenas noches';
    }
  }

  @override
  Widget build(BuildContext context) {
    final usuario = FirebaseAuth.instance.currentUser;

    if (usuario == null) {
      return Scaffold(
        body: Center(
          child: Text("Usuario no autenticado"),
        ),
      );
    }

    final nombreUsuario = usuario.displayName?.isNotEmpty == true
      ? usuario.displayName
      : usuario.email?.split('@').first ?? 'Usuario';

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  AvatarUsuario(radius: 20),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$nombreUsuario',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        obtenerSaludo(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  // Spacer(),
                  // GetBuilder<TemaControlador>(
                  //   builder: (controller) => IconButton(
                  //     onPressed: () => controller.elegirTema(),
                  //     icon: Icon(
                  //       controller.esModoOscuro
                  //           ? Icons.light_mode
                  //           : Icons.dark_mode,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),

            PromocionBanner(),

            Expanded(child: RestauranteGrid()),
          ],
        ),
      ),
    );
  }
}