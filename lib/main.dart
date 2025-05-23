import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sazon_urbano/controllers/auth/autenticacion_controlador.dart';
import 'package:sazon_urbano/controllers/navigation/navegacion_controlador.dart';
import 'package:sazon_urbano/controllers/theme/tema_controlador.dart';
import 'package:sazon_urbano/utils/app_temas.dart';
import 'package:sazon_urbano/view/bienvenida_pantalla.dart';

// IMPORTANTE para Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GetStorage.init();
  Get.put(TemaControlador());
  Get.put(AutenticacionControlador());
  Get.put(NavegacionControlador());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final temaControlador = Get.find<TemaControlador>();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bocados de Tradición',
      theme: AppTemas.light,
      darkTheme: AppTemas.dark,
      themeMode: temaControlador.theme,
      defaultTransition: Transition.fade,
      home: BienvenidaPantalla(),
    );
  }
}