import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/auth/autenticacion_controlador.dart';
import 'package:sazon_urbano/controllers/idioma/idioma_controlador.dart';
import 'package:sazon_urbano/principal_binding.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';
import 'package:sazon_urbano/view/crear_cuenta_pantalla.dart';
import 'package:sazon_urbano/view/principal_pantalla.dart';
import 'package:sazon_urbano/view/widgets/formulario_personalizado.dart';

class IniciarSesionPantalla extends StatelessWidget {
  IniciarSesionPantalla({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final idiomaCtrl = Get.find<IdiomaControlador>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Text(
                  'bienvenida_iniciar_sesion'.tr,
                  style: AppEstilosTexto.withColor(
                    AppEstilosTexto.h1,
                    Theme.of(context).textTheme.bodyLarge!.color!,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'inicia_sesión_para_continuar'.tr,
                  style: AppEstilosTexto.withColor(
                    AppEstilosTexto.bodyLarge,
                    isDark ? Colors.grey[400]! : Colors.grey[600]!,
                  ),
                ),
                const SizedBox(height: 40),
                FormularioPersonalizado(
                  label: 'correo'.tr,
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'error_correo'.tr;
                    }
                    if (!GetUtils.isEmail(value)) {
                      return 'error_correo_valido'.tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                FormularioPersonalizado(
                  label: 'contrasena'.tr,
                  prefixIcon: Icons.lock_outline,
                  keyboardType: TextInputType.visiblePassword,
                  isPassword: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'error_contrasena'.tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleSignIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'iniciar_sesion_boton'.tr,
                      style: AppEstilosTexto.withColor(
                        AppEstilosTexto.buttonMedium,
                        Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'no_tienes_cuenta'.tr,
                      style: AppEstilosTexto.withColor(
                        AppEstilosTexto.bodyMedium,
                        isDark ? Colors.grey[400]! : Colors.grey[600]!,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.to(() => CrearCuentaPantalla()),
                      child: Text(
                        'crear_cuenta'.tr,
                        style: AppEstilosTexto.withColor(
                          AppEstilosTexto.buttonMedium,
                          Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 70),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'seleccionar_idioma'.tr,
                        style: AppEstilosTexto.withColor(
                          AppEstilosTexto.bodyMedium,
                          isDark ? Colors.grey[400]! : Colors.grey[600]!,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: idiomaCtrl.idiomaActual.value,
                            icon: const Icon(Icons.arrow_drop_down, size: 40),
                            onChanged: (String? nuevoCodigo) {
                              if (nuevoCodigo != null) {
                                idiomaCtrl.cambiarIdioma(nuevoCodigo);
                              }
                            },
                            style: AppEstilosTexto.withColor(
                              AppEstilosTexto.bodyLarge.copyWith(fontSize: 20),
                              isDark ? Colors.white : Colors.black,
                            ),
                            items: idiomaCtrl.idiomas.map((idioma) {
                              return DropdownMenuItem<String>(
                                value: idioma['codigo'],
                                child: Row(
                                  children: [
                                    Text(
                                      idioma['bandera'] as String,
                                      style: const TextStyle(fontSize: 24),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      idioma['nombre'] as String,
                                      style: AppEstilosTexto.withColor(
                                        AppEstilosTexto.bodyLarge.copyWith(fontSize: 18),
                                        isDark ? Colors.white : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSignIn() async {
    final AutenticacionControlador autenticacionControlador = Get.find<AutenticacionControlador>();

    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      final loginExitoso = await autenticacionControlador.loginConFirebase(email, password);

      if (loginExitoso) {
        Get.offAll(() => PrincipalPantalla(), binding: PrincipalBinding());
      } else {
        Get.snackbar(
          'Error al iniciar sesión',
          'Verifica que tu correo y contraseña sean correctos o intenta de nuevo.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }
}