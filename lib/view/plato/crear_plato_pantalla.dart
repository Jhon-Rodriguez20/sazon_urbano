import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/accesibilidad/accesibilidad_controlador.dart';
import 'package:sazon_urbano/controllers/plato/plato_controlador.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';
import 'package:sazon_urbano/view/widgets/formulario_personalizado.dart';
import 'package:sazon_urbano/view/widgets/snacbar_personalizado.dart';
import 'package:sazon_urbano/widgets/seleccionar%20imagen/imagen_seleccionar.dart';

class CrearPlatoPantalla extends StatefulWidget {
  final String idRestaurante;
  const CrearPlatoPantalla({super.key, required this.idRestaurante});

  @override
  State<CrearPlatoPantalla> createState() => _CrearPlatoPantallaState();
}

class _CrearPlatoPantallaState extends State<CrearPlatoPantalla> {
  final _formKey = GlobalKey<FormState>();
  File? _imagenSeleccionada;
  final _nombrePlatoController = TextEditingController();
  final _precioController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _historialController = TextEditingController();

  final PlatoControlador _platoControlador = Get.put(PlatoControlador());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accesibilidadCtrl = Get.find<AccesibilidadControlador>();

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
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(Icons.arrow_back, size: 30, color: isDark ? Colors.white : Colors.black),
                    ),

                    SizedBox(height: 20),
                    Text(
                      'crear_plato_titulo'.tr,
                      style: AppEstilosTexto.withAccesibilidad(
                        AppEstilosTexto.h1,
                        agrandar: agrandar,
                        espaciado: espaciado,
                        color: Theme.of(context).textTheme.bodyLarge!.color!,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'crear_plato_subtitulo'.tr,
                      style: AppEstilosTexto.withAccesibilidad(
                        AppEstilosTexto.bodyLarge,
                        agrandar: agrandar,
                        espaciado: espaciado,
                        color: isDark ? Colors.grey[400]! : Colors.grey[600]!,
                      ),
                    ),

                    SizedBox(height: 40),
                    FormularioPersonalizado(
                      label: 'nombre_plato_label'.tr,
                      prefixIcon: Icons.person_outline,
                      keyboardType: TextInputType.name,
                      controller: _nombrePlatoController,
                      validator: (value) =>
                        value == null || value.isEmpty ? 'nombre_plato_error'.tr : null,
                    ),
                    
                    SizedBox(height: 16),
                    FormularioPersonalizado(
                      label: 'precio_label'.tr,
                      prefixIcon: Icons.price_change_outlined,
                      keyboardType: TextInputType.number,
                      controller: _precioController,
                      validator: (value) =>
                        value == null || value.isEmpty ? 'precio_error'.tr : null,
                    ),
                    
                    SizedBox(height: 16),
                    FormularioPersonalizado(
                      label: 'descripcion_label'.tr,
                      prefixIcon: Icons.description_outlined,
                      keyboardType: TextInputType.text,
                      controller: _descripcionController,
                      validator: (value) =>
                          value == null || value.isEmpty ? 'descripcion_error'.tr : null,
                    ),
                    
                    SizedBox(height: 16),
                    FormularioPersonalizado(
                      label: 'historial'.tr,
                      prefixIcon: Icons.history_outlined,
                      keyboardType: TextInputType.text,
                      controller: _historialController,
                      validator: (value) =>
                        value == null || value.isEmpty ? 'historial_error'.tr : null,
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
                            SnackbarPersonalizado.mostrarError('error_imagen_plato'.tr);
                            return;
                          }

                          try {
                            await _platoControlador.crearPlatoControlador(
                              nombrePlato: _nombrePlatoController.text.trim(),
                              precio: _precioController.text.trim(),
                              descripcion: _descripcionController.text.trim(),
                              historial: _historialController.text.trim(),
                              imagen: _imagenSeleccionada,
                              idRestaurante: widget.idRestaurante,
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
                        child: _platoControlador.cargando.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                            'crear_plato_boton'.tr,
                            style: AppEstilosTexto.withAccesibilidad(
                              AppEstilosTexto.buttonMedium,
                              agrandar: agrandar,
                              espaciado: espaciado,
                              color: Colors.white,
                            ),
                          ),
                      ) ),
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
    _nombrePlatoController.dispose();
    _precioController.dispose();
    _descripcionController.dispose();
    _historialController.dispose();
    super.dispose();
  }
}