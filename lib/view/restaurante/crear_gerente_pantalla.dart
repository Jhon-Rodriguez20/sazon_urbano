import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/accesibilidad/accesibilidad_controlador.dart';
import 'package:sazon_urbano/controllers/restaurante/crear_gerente_controlador.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';
import 'package:sazon_urbano/view/widgets/formulario_personalizado.dart';

class CrearGerentePantalla extends StatefulWidget {
  const CrearGerentePantalla({super.key});

  @override
  State<CrearGerentePantalla> createState() => _CrearGerentePantallaState();
}

class _CrearGerentePantallaState extends State<CrearGerentePantalla> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final CrearGerenteControlador _crearGerenteControlador = Get.put(CrearGerenteControlador());
  final accesibilidadCtrl = Get.find<AccesibilidadControlador>();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Obx(() {
      final agrandar = accesibilidadCtrl.agrandarTexto.value;
      final espaciado = accesibilidadCtrl.espaciadoTexto.value;
      final desaturar = accesibilidadCtrl.activarDesaturacion.value;

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
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 35),
                    Text(
                      'Crear Gerente',
                      style: AppEstilosTexto.withAccesibilidad(
                        AppEstilosTexto.h1,
                        agrandar: agrandar,
                        espaciado: espaciado,
                        color: Theme.of(context).textTheme.bodyLarge!.color!,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Crea un gerente para un restaurante',
                      style: AppEstilosTexto.withAccesibilidad(
                        AppEstilosTexto.bodyLarge,
                        agrandar: agrandar,
                        espaciado: espaciado,
                        color: isDark ? Colors.grey[400]! : Colors.grey[600]!,
                      ),
                    ),
                    const SizedBox(height: 40),

                    FormularioPersonalizado(
                      label: 'Nombre completo',
                      prefixIcon: Icons.person_outline,
                      keyboardType: TextInputType.name,
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Por favor ingrese el nombre';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    FormularioPersonalizado(
                      label: 'Correo',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Por favor ingrese su correo';
                        if (!GetUtils.isEmail(value)) return 'Por favor ingrese un correo válido';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    FormularioPersonalizado(
                      label: 'Contraseña',
                      prefixIcon: Icons.lock_outline,
                      keyboardType: TextInputType.visiblePassword,
                      isPassword: true,
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Por favor ingrese la contraseña';
                        if (value.length < 6) return 'La contraseña debe tener al menos 6 caracteres';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    FormularioPersonalizado(
                      label: 'Confirmar Contraseña',
                      prefixIcon: Icons.password_outlined,
                      keyboardType: TextInputType.visiblePassword,
                      isPassword: true,
                      controller: _confirmPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Por favor confirme la contraseña';
                        if (value != _passwordController.text) return 'Las contraseñas no coinciden';
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
                            await _crearGerenteControlador.crearGerente(
                              nombre: _nameController.text.trim(),
                              email: _emailController.text.trim(),
                              ocupacion: 'Gerente',
                              password: _passwordController.text.trim(),
                              urlImagen: '',
                              idRol: '2',
                            );
                          } catch (e) {
                            Get.snackbar('Error', e.toString());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _crearGerenteControlador.cargando.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'Crear Gerente',
                              style: AppEstilosTexto.withAccesibilidad(
                                AppEstilosTexto.buttonMedium,
                                agrandar: agrandar,
                                espaciado: espaciado,
                                color: Colors.white,
                              ),
                            ),
                      )),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
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