import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';
import 'package:sazon_urbano/view/widgets/formulario_personalizado.dart';

class PerfilFormulario extends StatelessWidget {
  const PerfilFormulario({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: isDark ? const Color.fromARGB(255, 39, 39, 39) : const Color.fromARGB(255, 237, 237, 237),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: FormularioPersonalizado(
              label: 'Nombre Completo',
              prefixIcon: Icons.person_outline,
              initialValue: 'Alexander Rodriguez',
            ),
          ),
          SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: isDark ? const Color.fromARGB(255, 39, 39, 39) : const Color.fromARGB(255, 237, 237, 237),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: FormularioPersonalizado(
              label: 'Correo',
              prefixIcon: Icons.email_outlined,
              initialValue: 'developjarz@gmail.com',
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          SizedBox(height: 16,),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: isDark ? const Color.fromARGB(255, 39, 39, 39) : const Color.fromARGB(255, 237, 237, 237),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: FormularioPersonalizado(
              label: 'Celular',
              prefixIcon: Icons.phone_outlined,
              initialValue: '123456789',
              keyboardType: TextInputType.phone,
            ),
          ),
          SizedBox(height: 32,),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: ()=> Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Guardar Cambios',
                style: AppEstilosTexto.withColor(
                  AppEstilosTexto.buttonMedium,
                  Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}