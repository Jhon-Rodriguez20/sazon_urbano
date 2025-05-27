import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IdiomaControlador extends GetxController {
  final idiomaActual = 'es'.obs;

  final idiomas = <Map<String, String>>[
    {
      'codigo': 'es',
      'nombre': 'Es',
      'bandera': '🇪🇸',
    },
    {
      'codigo': 'en',
      'nombre': 'En',
      'bandera': '🇺🇸',
    },
  ];

  @override
  void onInit() {
    super.onInit();
    _cargarIdiomaGuardado();
  }

  void cambiarIdioma(String codigo) {
    idiomaActual.value = codigo;
    Get.updateLocale(Locale(codigo));
    _guardarIdioma(codigo);
  }

  Future<void> _cargarIdiomaGuardado() async {
    final prefs = await SharedPreferences.getInstance();
    final guardado = prefs.getString('idioma') ?? 'es';
    idiomaActual.value = guardado;
    Get.updateLocale(Locale(guardado));
  }

  Future<void> _guardarIdioma(String codigo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('idioma', codigo);
  }

  Future<void> cargarIdiomaGuardadoManualmente() async {
    final prefs = await SharedPreferences.getInstance();
    final guardado = prefs.getString('idioma') ?? 'es';
    idiomaActual.value = guardado;
    Get.updateLocale(Locale(guardado));
  }
}