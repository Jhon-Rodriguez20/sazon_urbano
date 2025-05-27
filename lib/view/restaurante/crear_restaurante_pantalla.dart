import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/restaurante/restaurante_controlador.dart';
import 'package:sazon_urbano/controllers/accesibilidad/accesibilidad_controlador.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';
import 'package:sazon_urbano/view/widgets/formulario_personalizado.dart';
import 'package:sazon_urbano/view/widgets/snacbar_personalizado.dart';
import 'package:sazon_urbano/widgets/seleccionar imagen/imagen_seleccionar.dart';
import 'package:url_launcher/url_launcher.dart';

class CrearRestaurantePantalla extends StatefulWidget {
  const CrearRestaurantePantalla({super.key});

  @override
  State<CrearRestaurantePantalla> createState() => _CrearRestaurantePantallaState();
}

class _CrearRestaurantePantallaState extends State<CrearRestaurantePantalla> {
  final _formKey = GlobalKey<FormState>();
  File? _imagenSeleccionada;
  final _razonSocialController = TextEditingController();
  final _nitController = TextEditingController();
  final _direccionController = TextEditingController();
  final _telefonoController = TextEditingController();

  final RestauranteControlador _restauranteControlador = Get.put(RestauranteControlador());
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
                      'crear_restaurante'.tr,
                      style: AppEstilosTexto.withAccesibilidad(
                        AppEstilosTexto.h1,
                        agrandar: agrandar,
                        espaciado: espaciado,
                        color: Theme.of(context).textTheme.bodyLarge!.color!,
                      ),
                    ),

                    SizedBox(height: 8),
                    Text(
                      'registrar_restaurante'.tr,
                      style: AppEstilosTexto.withAccesibilidad(
                        AppEstilosTexto.bodyLarge,
                        agrandar: agrandar,
                        espaciado: espaciado,
                        color: isDark ? Colors.grey[400]! : Colors.grey[600]!,
                      ),
                    ),
                    SizedBox(height: 40),
                    FormularioPersonalizado(
                      label: 'razon_social'.tr,
                      prefixIcon: Icons.person_outline,
                      keyboardType: TextInputType.name,
                      controller: _razonSocialController,
                      validator: (value) =>
                        value == null || value.isEmpty ? 'error_razon_social'.tr : null,
                    ),
                    
                    const SizedBox(height: 16),
                    FormularioPersonalizado(
                      label: 'nit'.tr,
                      prefixIcon: Icons.numbers,
                      keyboardType: TextInputType.text,
                      controller: _nitController,
                      validator: (value) =>
                        value == null || value.isEmpty ? 'error_nit'.tr : null,
                    ),

                    SizedBox(height: 16),
                    FormularioPersonalizado(
                      label: 'telefono'.tr,
                      prefixIcon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      controller: _telefonoController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'error_telefono'.tr;
                        } else if (value.length != 10) {
                          return 'error_telefono_digitos'.tr;
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                    ),

                    SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormularioPersonalizado(
                          label: 'direccion'.tr,
                          prefixIcon: Icons.location_on_outlined,
                          keyboardType: TextInputType.streetAddress,
                          controller: _direccionController,
                          validator: (value) =>
                            value == null || value.isEmpty ? 'error_direccion'.tr : null,
                        ),
                        const SizedBox(height: 6),
                        InkWell(
                          onTap: () async {
                            final url = Uri.parse('https://www.google.com/maps');
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url, mode: LaunchMode.externalApplication);
                            }
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.map_outlined, color: Theme.of(context).primaryColor),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'direccion_google_maps'.tr,
                                  style: AppEstilosTexto.withAccesibilidad(
                                    AppEstilosTexto.bodySmall,
                                    agrandar: accesibilidadCtrl.agrandarTexto.value,
                                    espaciado: accesibilidadCtrl.espaciadoTexto.value,
                                    color: isDark ? Colors.grey[400]! : Colors.grey[600]!,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),

                    ImagenSeleccionar(
                      imagenSeleccionada: _imagenSeleccionada,
                      onImageSelected: (File? img) {
                        _imagenSeleccionada = img;
                      },
                    ),

                    SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: Obx(() => ElevatedButton(
                            onPressed: () async {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              if (_imagenSeleccionada == null) {
                                SnackbarPersonalizado.mostrarError('error_imagen_restaurante'.tr);
                                return;
                              }

                              try {
                                await _restauranteControlador.crearRestauranteControlador(
                                  razonSocial: _razonSocialController.text.trim(),
                                  nit: _nitController.text.trim(),
                                  direccion: _direccionController.text.trim(),
                                  telefono: _telefonoController.text.trim(),
                                  imagen: _imagenSeleccionada,
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
                            child: _restauranteControlador.cargando.value
                                ? const CircularProgressIndicator(color: Colors.white)
                                : Text(
                                    'crear_restaurante'.tr,
                                    style: AppEstilosTexto.withAccesibilidad(
                                      AppEstilosTexto.buttonMedium,
                                      agrandar: agrandar,
                                      espaciado: espaciado,
                                      color: Colors.white,
                                    ),
                                  ),
                          )),
                    ),
                    SizedBox(height: 24),
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
    _razonSocialController.dispose();
    _nitController.dispose();
    _direccionController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }
}