import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/auth/crear_cuenta_controlador.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';
import 'package:sazon_urbano/view/iniciar_sesion_pantalla.dart';
import 'package:sazon_urbano/view/widgets/formulario_personalizado.dart';
class CrearCuentaPantalla extends StatefulWidget {
  const CrearCuentaPantalla({super.key});

  @override
  State<CrearCuentaPantalla> createState() => _CrearCuentaPantallaState();
}

class _CrearCuentaPantallaState extends State<CrearCuentaPantalla> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final UsuarioControlador _usuarioControlador = Get.put(UsuarioControlador());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.arrow_back,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'crear_cuenta'.tr,
                  style: AppEstilosTexto.withColor(
                    AppEstilosTexto.h1,
                    Theme.of(context).textTheme.bodyLarge!.color!,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'crear_cuenta_empezar'.tr,
                  style: AppEstilosTexto.withColor(
                    AppEstilosTexto.bodyLarge,
                    isDark ? Colors.grey[400]! : Colors.grey[600]!,
                  ),
                ),
                const SizedBox(height: 40),

                FormularioPersonalizado(
                  label: 'nombre_completo'.tr,
                  prefixIcon: Icons.person_outline,
                  keyboardType: TextInputType.name,
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'error_nombre'.tr;
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                FormularioPersonalizado(
                  label: 'correo'.tr,
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'error_correo'.tr;
                    if (!GetUtils.isEmail(value)) return 'error_correo_valido'.tr;
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
                    if (value == null || value.isEmpty) return 'error_contrasena'.tr;
                    if (value.length < 6) return 'error_contrasena_corta'.tr;
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                FormularioPersonalizado(
                  label: 'confirmar_contrasena'.tr,
                  prefixIcon: Icons.password_outlined,
                  keyboardType: TextInputType.visiblePassword,
                  isPassword: true,
                  controller: _confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'error_confirmar_contrasena'.tr;
                    if (value != _passwordController.text) return 'error_contrasenas_no_coinciden'.tr;
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: Obx(() => ElevatedButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;

                      try {
                        await _usuarioControlador.crearCuenta(
                          nombre: _nameController.text.trim(),
                          email: _emailController.text.trim(),
                          ocupacion: 'Cliente',
                          password: _passwordController.text.trim(),
                          urlImagen: '',
                          idRol: '3',
                        );
                      } catch (e) {
                        Get.snackbar('error'.tr, e.toString());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _usuarioControlador.cargando.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'crear_cuenta'.tr,
                          style: AppEstilosTexto.withColor(
                            AppEstilosTexto.buttonMedium,
                            Colors.white,
                          ),
                        ),
                      ),
                    ),
                ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'tienes_cuenta'.tr,
                      style: AppEstilosTexto.withColor(
                        AppEstilosTexto.bodyMedium,
                        isDark ? Colors.grey[400]! : Colors.grey[600]!,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.off(() => IniciarSesionPantalla()),
                      child: Text(
                        'iniciar_sesion_boton'.tr,
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

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
