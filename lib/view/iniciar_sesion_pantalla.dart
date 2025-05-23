import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/auth/autenticacion_controlador.dart';
import 'package:sazon_urbano/principal_binding.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';
import 'package:sazon_urbano/view/crear_cuenta_pantalla.dart';
import 'package:sazon_urbano/view/principal_pantalla.dart';
import 'package:sazon_urbano/view/widgets/formulario_personalizado.dart';

class IniciarSesionPantalla extends StatelessWidget {
  IniciarSesionPantalla({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // 👉 Agregado el form key

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form( // 👉 Aquí envolvemos en un Form
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Text(
                  '¡Bienvenido de vuelta!',
                  style: AppEstilosTexto.withColor(
                    AppEstilosTexto.h1,
                    Theme.of(context).textTheme.bodyLarge!.color!,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Inicia sesión para continuar',
                  style: AppEstilosTexto.withColor(
                    AppEstilosTexto.bodyLarge,
                    isDark ? Colors.grey[400]! : Colors.grey[600]!,
                  ),
                ),
                const SizedBox(height: 40),
                // Email textfield
                FormularioPersonalizado(
                  label: 'Correo',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su correo';
                    }
                    if (!GetUtils.isEmail(value)) {
                      return 'Por favor ingrese un correo válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Password textfield
                FormularioPersonalizado(
                  label: 'Contraseña',
                  prefixIcon: Icons.lock_outline,
                  keyboardType: TextInputType.visiblePassword,
                  isPassword: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su contraseña';
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
                      'Iniciar Sesión',
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
                      "¿No tienes una cuenta?",
                      style: AppEstilosTexto.withColor(
                        AppEstilosTexto.bodyMedium,
                        isDark ? Colors.grey[400]! : Colors.grey[600]!,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.to(() => CrearCuentaPantalla()),
                      child: Text(
                        'Crear Cuenta',
                        style: AppEstilosTexto.withColor(
                          AppEstilosTexto.buttonMedium,
                          Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Sign in button onPressed
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