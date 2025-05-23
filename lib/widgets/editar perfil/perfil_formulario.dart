import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/usuario/usuario_controlador.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';
import 'package:sazon_urbano/view/widgets/formulario_personalizado.dart';
import 'package:sazon_urbano/widgets/seleccionar imagen/imagen_seleccionar.dart';

class PerfilFormulario extends StatelessWidget {
  const PerfilFormulario({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final usuarioCtrl = Get.put(UsuarioControlador());

    return Obx(() {
      return usuarioCtrl.cargando.value
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // ImagenSeleccionar arriba
                    Obx(() => ImagenSeleccionar(
                          imagenSeleccionada: usuarioCtrl.imagenSeleccionada.value,
                          urlImagenRemota: usuarioCtrl.urlImagen.value,
                          onImageSelected: usuarioCtrl.seleccionarImagen,
                        )),

                    const SizedBox(height: 16),

                    // Campo: Nombre
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: isDark
                                ? const Color.fromARGB(255, 39, 39, 39)
                                : const Color.fromARGB(255, 237, 237, 237),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: FormularioPersonalizado(
                        label: 'Nombre Completo',
                        prefixIcon: Icons.person_outline,
                        controller: usuarioCtrl.nombreCtrl,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Campo: Correo
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: isDark
                                ? const Color.fromARGB(255, 39, 39, 39)
                                : const Color.fromARGB(255, 237, 237, 237),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: FormularioPersonalizado(
                        label: 'Correo',
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        controller: usuarioCtrl.correoCtrl,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Botón Guardar Cambios con loader dentro
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (!usuarioCtrl.cargando.value) {
                            await usuarioCtrl.guardarCambios();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Obx(() => usuarioCtrl.cargando.value
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : Text(
                                'Guardar Cambios',
                                style: AppEstilosTexto.withColor(
                                  AppEstilosTexto.buttonMedium,
                                  Colors.white,
                                ),
                              )),
                      ),
                    ),
                  ],
                ),
              ),
            );
    });
  }
}