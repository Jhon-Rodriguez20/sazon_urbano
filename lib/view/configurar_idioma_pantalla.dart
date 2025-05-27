import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';
import 'package:sazon_urbano/view/presentacion_pantalla.dart';

class ConfigurarIdiomaPantalla extends StatefulWidget {
  const ConfigurarIdiomaPantalla({super.key});

  @override
  State<ConfigurarIdiomaPantalla> createState() => _ConfigurarIdiomaPantallaState();
}

class _ConfigurarIdiomaPantallaState extends State<ConfigurarIdiomaPantalla> {
  String _idiomaSeleccionado = Get.locale?.languageCode ?? 'es';

  void _cambiarIdioma(String idioma) {
    setState(() {
      _idiomaSeleccionado = idioma;
    });
    Get.updateLocale(Locale(idioma));
  }

  Widget _botonIdioma(String idioma, String nombre, String bandera) {
    final seleccionado = _idiomaSeleccionado == idioma;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ElevatedButton(
      onPressed: () => _cambiarIdioma(idioma),
      style: ElevatedButton.styleFrom(
        backgroundColor: seleccionado
            ? Theme.of(context).primaryColor
            : isDark
                ? Colors.grey[800]
                : Colors.grey[200],
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            bandera,
            style: const TextStyle(fontSize: 28),
          ),
          const SizedBox(width: 16),
          Text(
            nombre,
            style: AppEstilosTexto.withColor(
              AppEstilosTexto.withWeight(AppEstilosTexto.h3, FontWeight.w600,),
              seleccionado ? Colors.white : Colors.black
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Text(
                'seleccionar_idioma'.tr,
                textAlign: TextAlign.center,
                style: AppEstilosTexto.withColor(
                  AppEstilosTexto.h1,
                  Theme.of(context).textTheme.bodyLarge!.color!
                ),
              ),

              const SizedBox(height: 80),
              _botonIdioma('es', 'Español', '🇪🇸'),
              const SizedBox(height: 40),
              _botonIdioma('en', 'English', '🇺🇸'),
              const Spacer(),

              ElevatedButton(
                onPressed: () {
                  Get.off(()=> const PresentacionPantalla());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'continuar'.tr,
                  style: AppEstilosTexto.withColor(
                    AppEstilosTexto.withWeight(AppEstilosTexto.buttonLarge, FontWeight.bold,),
                    Colors.white
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}