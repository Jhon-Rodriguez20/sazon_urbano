import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';
import 'package:sazon_urbano/view/iniciar_sesion_pantalla.dart';
import 'package:sazon_urbano/view/principal_pantalla.dart';
import 'package:sazon_urbano/view/widgets/formulario_personalizado.dart';

class CrearCuentaPantalla extends StatelessWidget {
  CrearCuentaPantalla({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // back button
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: isDark? Colors.white : Colors.black,
                ),
              ),

              SizedBox(height: 20),
              Text(
                'Crear Cuenta',
                style: AppEstilosTexto.withColor(
                  AppEstilosTexto.h1,
                  Theme.of(context).textTheme.bodyLarge!.color!,
                ),
              ),

              SizedBox(height: 8),
              Text(
                'Crea una cuenta para empezar',
                style: AppEstilosTexto.withColor(
                  AppEstilosTexto.bodyLarge,
                  isDark? Colors.grey[400]! : Colors.grey[600]!
                ),
              ),

              SizedBox(height: 40),

              FormularioPersonalizado(
                label: 'Nombre completo',
                prefixIcon: Icons.person_outline,
                keyboardType: TextInputType.name,
                controller: _nameController,
                validator: (value){
                  if(value == null || value.isEmpty) {
                    return 'Por favor ingrese su nombre';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16),

              // email textfield
              FormularioPersonalizado(
                label: 'Correo',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: (value){
                  if(value == null || value.isEmpty) {
                    return 'Por favor ingrese su correo';
                  }
                  if(!GetUtils.isEmail(value)) {
                    return 'Por favor ingrese un correo válido';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16),
              
              // password textfield
              FormularioPersonalizado(
                label: 'Contraseña',
                prefixIcon: Icons.lock_outline,
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
                controller: _passwordController,
                validator: (value){
                  if(value == null || value.isEmpty) {
                    return 'Por favor ingrese su contraseña';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16),
              
              FormularioPersonalizado(
                label: 'Confirmar Contraseña',
                prefixIcon: Icons.password_outlined,
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
                controller: _confirmPasswordController,
                validator: (value){
                  if(value == null || value.isEmpty) {
                    return 'Por favor ingrese su contraseña';
                  }
                  if(value != _passwordController.text) {
                    return "Las contraseñas no coinciden";
                  }
                  return null;
                },
              ),

              SizedBox(height: 24),
              // Signup button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: ()=> Get.off(()=> PrincipalPantalla()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )
                  ),
                  child: Text(
                    'Crear Cuenta',
                    style: AppEstilosTexto.withColor(
                      AppEstilosTexto.buttonMedium,
                      Colors.white
                    ),
                  )
                ),
              ),

              SizedBox(height: 24),
              // signin textbutton
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '¿Ya tienes una cuenta?',
                    style: AppEstilosTexto.withColor(
                      AppEstilosTexto.bodyMedium,
                      isDark? Colors.grey[400]! : Colors.grey[600]!,
                    ),
                  ),
                  TextButton(
                    onPressed: ()=> Get.off(()=> IniciarSesionPantalla(),),
                    child: Text(
                      'Iniciar Sesión',
                      style: AppEstilosTexto.withColor(
                        AppEstilosTexto.buttonMedium,
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}