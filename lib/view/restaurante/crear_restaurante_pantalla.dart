import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/restaurante/restaurante_controlador.dart';
import 'package:sazon_urbano/controllers/accesibilidad/accesibilidad_controlador.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';
import 'package:sazon_urbano/view/widgets/formulario_personalizado.dart';
import 'package:sazon_urbano/widgets/seleccionar imagen/imagen_seleccionar.dart';

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
                    const SizedBox(height: 35),
                    Text(
                      'Crear Restaurante',
                      style: AppEstilosTexto.withAccesibilidad(
                        AppEstilosTexto.h1,
                        agrandar: agrandar,
                        espaciado: espaciado,
                        color: Theme.of(context).textTheme.bodyLarge!.color!,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Registra tu restaurante aquí',
                      style: AppEstilosTexto.withAccesibilidad(
                        AppEstilosTexto.bodyLarge,
                        agrandar: agrandar,
                        espaciado: espaciado,
                        color: isDark ? Colors.grey[400]! : Colors.grey[600]!,
                      ),
                    ),
                    const SizedBox(height: 40),

                    FormularioPersonalizado(
                      label: 'Razón Social',
                      prefixIcon: Icons.person_outline,
                      keyboardType: TextInputType.name,
                      controller: _razonSocialController,
                      validator: (value) =>
                        value == null || value.isEmpty ? 'Por favor ingrese la razón social' : null,
                    ),
                    const SizedBox(height: 16),

                    FormularioPersonalizado(
                      label: 'NIT',
                      prefixIcon: Icons.numbers,
                      keyboardType: TextInputType.text,
                      controller: _nitController,
                      validator: (value) =>
                        value == null || value.isEmpty ? 'Por favor ingrese el NIT' : null,
                    ),
                    const SizedBox(height: 16),

                    FormularioPersonalizado(
                      label: 'Dirección',
                      prefixIcon: Icons.location_on_outlined,
                      keyboardType: TextInputType.streetAddress,
                      controller: _direccionController,
                      validator: (value) =>
                        value == null || value.isEmpty ? 'Por favor ingrese la dirección' : null,
                    ),
                    const SizedBox(height: 16),

                    FormularioPersonalizado(
                      label: 'Teléfono',
                      prefixIcon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      controller: _telefonoController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese el teléfono';
                        } else if (value.length != 10) {
                          return 'El teléfono debe tener 10 dígitos';
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                    ),
                    const SizedBox(height: 24),

                    ImagenSeleccionar(
                      imagenSeleccionada: _imagenSeleccionada,
                      onImageSelected: (File? img) {
                        _imagenSeleccionada = img;
                      },
                    ),

                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: Obx(() => ElevatedButton(
                            onPressed: () async {
                              if (!_formKey.currentState!.validate()) {
                                Get.snackbar('Error', 'Debe completar todos los campos');
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
                            child: _restauranteControlador.cargando.value
                                ? const CircularProgressIndicator(color: Colors.white)
                                : Text(
                                    'Crear Restaurante',
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
    _razonSocialController.dispose();
    _nitController.dispose();
    _direccionController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }
}