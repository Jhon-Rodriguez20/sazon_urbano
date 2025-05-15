import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:sazon_urbano/controllers/restaurante/restaurante_controlador.dart';
import 'package:sazon_urbano/DB/repositories/usuario/buscar_usuarios.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';
import 'package:sazon_urbano/view/widgets/formulario_personalizado.dart';
import 'package:sazon_urbano/widgets/editar%20perfil/perfil_imagen.dart';

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

  String? _idGerenteSeleccionado;
  final RestauranteControlador _restauranteControlador = Get.put(RestauranteControlador());
  final BuscarUsuarios _buscarUsuarios = BuscarUsuarios();

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
                  'Crear Restaurante',
                  style: AppEstilosTexto.withColor(
                    AppEstilosTexto.h1,
                    Theme.of(context).textTheme.bodyLarge!.color!,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Registra tu restaurante aquí',
                  style: AppEstilosTexto.withColor(
                    AppEstilosTexto.bodyLarge,
                    isDark ? Colors.grey[400]! : Colors.grey[600]!,
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
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Por favor ingrese el teléfono' : null,
                ),
                const SizedBox(height: 16),


                FutureBuilder<List<Map<String, dynamic>>>(
                  future: _buscarUsuarios.obtenerGerentes(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Text('Error al cargar gerentes: ${snapshot.error}');
                    }

                    final gerentes = snapshot.data ?? [];

                    return DropdownSearch<Map<String, dynamic>>(
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                            hintText: "Buscar gerente...",
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        // Opcional: personaliza el estilo del popup con un fondo
                        containerBuilder: (ctx, popupWidget) => Material(
                          color: isDark ? Colors.grey[900] : Colors.white,
                          elevation: 4,
                          borderRadius: BorderRadius.circular(12),
                          child: popupWidget,
                        ),
                      ),
                      items: gerentes,
                      itemAsString: (item) => item['nombre'] ?? 'Sin nombre',
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: 'Seleccionar Gerente',
                          labelStyle: TextStyle(
                            color: isDark ? Colors.grey[500] : Colors.grey[600],
                          ),
                          prefixIcon: const Icon(Icons.person_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ),
                      ),
                      validator: (value) => value == null ? 'Seleccione un gerente' : null,
                      onChanged: (value) {
                        if (value != null) {
                          _idGerenteSeleccionado = value['idUsuario'];
                        }
                      },
                      selectedItem: null,
                    );
                  },
                ),
                const SizedBox(height: 24),

                PerfilImagen(
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
                          if (!_formKey.currentState!.validate() || _idGerenteSeleccionado == null) {
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
                              idGerente: _idGerenteSeleccionado!,
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
                            style: AppEstilosTexto.withColor(
                              AppEstilosTexto.buttonMedium,
                              Colors.white,
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
    );
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