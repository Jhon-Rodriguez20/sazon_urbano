import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TemaControlador extends GetxController {
  final _box = GetStorage();

  final _key = 'esModoOscuro';

  ThemeMode get theme => _cargarTema() ? ThemeMode.dark : ThemeMode.light;
  bool get esModoOscuro => _cargarTema();

  bool _cargarTema()=> _box.read(_key) ?? false;

  void guardarTema(bool esModoOscuro) => _box.write(_key, esModoOscuro);

  void elegirTema() {
    Future.delayed(const Duration(milliseconds: 50), () {
      Get.changeThemeMode(_cargarTema() ? ThemeMode.light : ThemeMode.dark);
      guardarTema(!_cargarTema());
      update();
    });
  }
}