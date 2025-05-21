import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/plato/plato_controlador.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';
import 'package:sazon_urbano/view/widgets/formulario_personalizado.dart';
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
                  icon: Icon(Icons.arrow_back_ios, color: isDark ? Colors.white : Colors.black),
                ),
                const SizedBox(height: 20),
                Text(
                  'Crear Plato',
                  style: AppEstilosTexto.withColor(
                    AppEstilosTexto.h1,
                    Theme.of(context).textTheme.bodyLarge!.color!,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Crea un platillo aquí',
                  style: AppEstilosTexto.withColor(
                    AppEstilosTexto.bodyLarge,
                    isDark ? Colors.grey[400]! : Colors.grey[600]!,
                  ),
                ),
                const SizedBox(height: 40),

                FormularioPersonalizado(
                  label: 'Nombre del plato',
                  prefixIcon: Icons.person_outline,
                  keyboardType: TextInputType.name,
                  controller: _nombrePlatoController,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Por favor ingrese el nombre del plato' : null,
                ),
                const SizedBox(height: 16),

                FormularioPersonalizado(
                  label: 'Precio',
                  prefixIcon: Icons.price_change_outlined,
                  keyboardType: TextInputType.number,
                  controller: _precioController,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Por favor ingrese el precio' : null,
                ),
                const SizedBox(height: 16),

                FormularioPersonalizado(
                  label: 'Descripción',
                  prefixIcon: Icons.description_outlined,
                  keyboardType: TextInputType.text,
                  controller: _descripcionController,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Por favor ingrese la descripción' : null,
                ),
                const SizedBox(height: 16),

                FormularioPersonalizado(
                  label: 'Historial',
                  prefixIcon: Icons.history_outlined,
                  keyboardType: TextInputType.text,
                  controller: _historialController,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Por favor ingrese el historial' : null,
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
                    child: _platoControlador.cargando.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                        'Crear Plato',
                        style: AppEstilosTexto.withColor(
                          AppEstilosTexto.buttonMedium,
                        Colors.white,
                        ),
                      ),
                  ) ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
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