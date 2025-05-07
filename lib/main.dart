import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sazon_urbano/controllers/auth/autenticacion_controlador.dart';
import 'package:sazon_urbano/controllers/navigation/navegacion_controlador.dart';
import 'package:sazon_urbano/controllers/theme/tema_controlador.dart';
import 'package:sazon_urbano/utils/app_temas.dart';
import 'package:sazon_urbano/view/bienvenida_pantalla.dart';

// IMPORTANTE para Firebase
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart'; // Importa Firestore
// import 'firebase_options.dart'; // este archivo lo genera FlutterFire CLI

void main() async {

  // Inicializar GetStorage y Controladores
  await GetStorage.init();
  Get.put(TemaControlador());
  Get.put(AutenticacionControlador());
  Get.put(NavegacionControlador());

  // Correr la aplicación
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final temaControlador = Get.find<TemaControlador>();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sazón Urbano',
      theme: AppTemas.light,
      darkTheme: AppTemas.dark,
      themeMode: temaControlador.theme,
      defaultTransition: Transition.fade,
      home: BienvenidaPantalla(),
    );
  }
}

// void pruebaFirestore() async {
//   try {
//     // Conectar con Firestore
//     FirebaseFirestore firestore = FirebaseFirestore.instance;

//     // Crear un documento de prueba
//     await firestore.collection('test_collection').add({
//       'test_field': 'Test data from Flutter',
//       'timestamp': FieldValue.serverTimestamp(),
//     });

//     print("Datos enviados a Firestore con éxito!");
//   } catch (e) {
//     print("Error escribiendo en Firestore: $e");
//   }
// }