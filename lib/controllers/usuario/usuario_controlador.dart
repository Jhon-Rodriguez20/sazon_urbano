import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/DB/repositories/usuario/usuario_repositorio.dart';
import 'package:sazon_urbano/service/image_service.dart';
import 'package:sazon_urbano/view/mi%20cuenta/mi_cuenta_pantalla.dart';

class UsuarioControlador extends GetxController {
  final UsuarioRepositorio _repositorio = UsuarioRepositorio();

  final nombreCtrl = TextEditingController();
  final correoCtrl = TextEditingController();

  var imagenSeleccionada = Rxn<File>();
  var urlImagen = ''.obs;

  final cargando = false.obs;

  @override
  void onInit() {
    super.onInit();
    cargarDatosUsuario();
  }

  Future<void> cargarDatosUsuario() async {
    cargando.value = true;
    final data = await _repositorio.obtenerUsuario();
    if (data != null) {
      nombreCtrl.text = data['nombre'] ?? '';
      correoCtrl.text = data['email'] ?? '';
      urlImagen.value = data['urlImagen'] ?? '';
    }
    cargando.value = false;
  }

  Future<void> seleccionarImagen(File? nuevaImagen) async {
    imagenSeleccionada.value = nuevaImagen;
  }

  Future<void> guardarCambios() async {
    cargando.value = true;
    String? nuevaUrl;

    if (imagenSeleccionada.value != null) {
      nuevaUrl = await ImageService.uploadImage(imagenSeleccionada.value!, 'usuarios');
    }

    await _repositorio.actualizarUsuario(
      nombre: nombreCtrl.text.trim(),
      email: correoCtrl.text.trim(),
      urlImagen: nuevaUrl ?? urlImagen.value,
    );

    if (nuevaUrl != null) {
      urlImagen.value = nuevaUrl;
    }

    cargando.value = false;

    // Redirige después de terminar la carga
    Get.off(() => const MiCuentaPantalla());
  }
}