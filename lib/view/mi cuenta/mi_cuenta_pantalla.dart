import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/auth/autenticacion_controlador.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';
import 'package:sazon_urbano/view/configuracion_pantalla.dart';
import 'package:sazon_urbano/view/iniciar_sesion_pantalla.dart';
import 'package:sazon_urbano/view/mi%20cuenta/editar_perfil_pantalla.dart';
import 'package:sazon_urbano/view/restaurante/mis_restaurantes_pantalla.dart';
import 'package:sazon_urbano/widgets/editar%20perfil/avatar_usuario.dart';

class MiCuentaPantalla extends StatelessWidget {
  const MiCuentaPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mi Cuenta',
          style: AppEstilosTexto.withColor(
            AppEstilosTexto.h3,
            isDark ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Get.to(()=> ConfiguracionPantalla()),
            icon: Icon(Icons.settings_outlined),
            color: isDark ? Colors.white : Colors.black,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileSection(context),
            SizedBox(height: 24),
            _buildMenuSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Center(child: Text('Usuario no autenticado'));
    }

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('usuarios').doc(user.uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: EdgeInsets.all(24),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Padding(
            padding: EdgeInsets.all(24),
            child: Center(child: Text('No se encontró el perfil del usuario')),
          );
        }

        final userData = snapshot.data!.data() as Map<String, dynamic>;
        final nombre = userData['nombre'] ?? 'Sin Nombre';
        final email = userData['email'] ?? user.email ?? 'Correo no disponible';

        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[850] : Colors.grey[100],
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
          ),
          child: Column(
            children: [
              AvatarUsuario(radius: 50),
              SizedBox(height: 16),
              Text(
                nombre,
                style: AppEstilosTexto.withColor(
                  AppEstilosTexto.h2,
                  Theme.of(context).textTheme.bodyLarge!.color!,
                ),
              ),
              SizedBox(height: 4),
              Text(
                email,
                style: AppEstilosTexto.withColor(
                  AppEstilosTexto.bodyMedium,
                  isDark ? Colors.grey[400]! : Colors.grey[600]!,
                ),
              ),
              SizedBox(height: 16),
              OutlinedButton(
                onPressed: () => Get.to(() => EditarPerfilPantalla()),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  side: BorderSide(
                    color: isDark ? Colors.white70 : Colors.black12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Editar Perfil',
                  style: AppEstilosTexto.withColor(
                    AppEstilosTexto.bodyMedium,
                    Theme.of(context).textTheme.bodyLarge!.color!,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Center(child: Text('Usuario no autenticado'));
    }

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('usuarios').doc(user.uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Center(child: Text('No se pudo obtener el rol del usuario'));
        }

        final userData = snapshot.data!.data() as Map<String, dynamic>;
        final idRol = userData['idRol'];

        final List<Map<String, dynamic>> menuItems = [];

        if (idRol == '2') {
          menuItems.add({'icon': Icons.store, 'title': 'Mis Restaurantes'});
        }

        menuItems.addAll([
          {'icon': Icons.logout_outlined, 'title': 'Cerrar Sesion'},
        ]);

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: menuItems.map((item) {
              return Container(
                margin: EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: isDark
                          ? const Color.fromARGB(255, 39, 39, 39)
                          : const Color.fromARGB(255, 237, 237, 237),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Icon(
                    item['icon'] as IconData,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    item['title'] as String,
                    style: AppEstilosTexto.withColor(
                      AppEstilosTexto.bodyMedium,
                      Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                  onTap: () {
                    if (item['title'] == 'Cerrar Sesion') {
                      _showLogoutDialog(context);
                    } else if (item['title'] == 'Mis Restaurantes') {
                      Get.to(() => MisRestaurantesPantalla());
                    }
                  },
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Get.dialog(
      AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),

        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 20,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle
              ),
              child: Icon(
                Icons.logout_rounded,
                color: Colors.white,
                size: 32,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '¿Seguro que deseas cerrar sesión?',
              style: AppEstilosTexto.withColor(
                AppEstilosTexto.bodyMedium,
                isDark ? Colors.grey[400]! : Colors.grey[600]!
              ),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(
                        color: isDark ? Colors.grey[700]! : Colors.grey[300]!
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Cancelar',
                      style: AppEstilosTexto.withColor(
                        AppEstilosTexto.buttonMedium,
                        Theme.of(context).textTheme.bodyLarge!.color!
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final autenticacionControlador = Get.find<AutenticacionControlador>();
                      await autenticacionControlador.logout();
                      // Navegar a login
                      Get.offAll(() => IniciarSesionPantalla());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Cerrar Sesión',
                      style: AppEstilosTexto.withColor(
                        AppEstilosTexto.buttonMedium,
                        Colors.white
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}