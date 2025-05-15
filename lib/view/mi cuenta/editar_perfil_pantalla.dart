import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';
import 'package:sazon_urbano/widgets/editar%20perfil/perfil_formulario.dart';
// import 'package:sazon_urbano/widgets/editar%20perfil/perfil_imagen.dart';

class EditarPerfilPantalla extends StatelessWidget {
  const EditarPerfilPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Editar Perfil',
          style: AppEstilosTexto.withColor(
            AppEstilosTexto.h3,
            isDark ? Colors.white : Colors.black
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 24),
            // PerfilImagen(
            //   onImageSelected: (File? img) {
            //     _imagenSeleccionada = img;
            //   },
            // ),
            SizedBox(height: 32),
            PerfilFormulario(),
          ],
        ),
      ),
    );
  }
}