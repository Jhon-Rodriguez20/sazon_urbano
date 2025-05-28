import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarPersonalizado {
  static void mostrarExito(String mensaje) {
    Get.snackbar(
      'exito'.tr,
      mensaje,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.check_circle, color: Colors.white),
      shouldIconPulse: false,
    );
  }

  static void mostrarError(String mensaje) {
    Get.snackbar(
      'error'.tr,
      mensaje,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.error, color: Colors.white),
      shouldIconPulse: false,
    );
  }
}