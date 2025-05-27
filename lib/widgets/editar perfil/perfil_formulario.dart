import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/accesibilidad/accesibilidad_controlador.dart';
import 'package:sazon_urbano/controllers/usuario/usuario_controlador.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';
import 'package:sazon_urbano/view/widgets/formulario_personalizado.dart';
import 'package:sazon_urbano/widgets/seleccionar imagen/imagen_seleccionar.dart';

class PerfilFormulario extends StatelessWidget {
  const PerfilFormulario({super.key});

  @override
  Widget build(BuildContext context) {
    final usuarioCtrl = Get.put(UsuarioControlador());
    final accesibilidadCtrl = Get.find<AccesibilidadControlador>();

    return Obx(() {
      final desaturar = accesibilidadCtrl.activarDesaturacion.value;
      final agrandar = accesibilidadCtrl.agrandarTexto.value;
      final espaciado = accesibilidadCtrl.espaciadoTexto.value;

      return usuarioCtrl.cargando.value
          ? const Center(child: CircularProgressIndicator())
          : MediaQuery(
              data: MediaQuery.of(context),
              child: ColorFiltered(
                colorFilter: desaturar
                    ? const ColorFilter.matrix(<double>[
                        0.2126, 0.7152, 0.0722, 0, 0,
                        0.2126, 0.7152, 0.0722, 0, 0,
                        0.2126, 0.7152, 0.0722, 0, 0,
                        0, 0, 0, 1, 0,
                      ])
                    : const ColorFilter.mode(Colors.transparent, BlendMode.dst),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Obx(() => ImagenSeleccionar(
                              imagenSeleccionada:
                              usuarioCtrl.imagenSeleccionada.value,
                              urlImagenRemota: usuarioCtrl.urlImagen.value,
                              onImageSelected: usuarioCtrl.seleccionarImagen,
                            )),
                        const SizedBox(height: 16),

                        _campoDecorado(
                          context,
                          FormularioPersonalizado(
                            label: 'nombre_completo'.tr,
                            prefixIcon: Icons.person_outline,
                            controller: usuarioCtrl.nombreCtrl,
                          ),
                        ),

                        const SizedBox(height: 16),

                        _campoDecorado(
                          context,
                          FormularioPersonalizado(
                            label: 'correo'.tr,
                            prefixIcon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            controller: usuarioCtrl.correoCtrl,
                          ),
                        ),

                        SizedBox(height: 32),
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16),
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
                                    'guardar_cambios'.tr,
                                    style: AppEstilosTexto.withAccesibilidad(
                                      AppEstilosTexto.buttonMedium,
                                      agrandar: agrandar,
                                      espaciado: espaciado,
                                      color: Colors.white,
                                    ),
                                  )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
    });
  }

  Widget _campoDecorado(BuildContext context, Widget campo) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
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
      child: campo,
    );
  }
}