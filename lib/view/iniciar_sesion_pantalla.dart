import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/auth/autenticacion_controlador.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';
import 'package:sazon_urbano/view/crear_cuenta_pantalla.dart';
import 'package:sazon_urbano/view/principal_pantalla.dart';
import 'package:sazon_urbano/view/widgets/formulario_personalizado.dart';

class IniciarSesionPantalla extends StatelessWidget {
  IniciarSesionPantalla({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              SizedBox(height: 40),
              Text(
                '¡Bienvenido de vuelta!',
                style: AppEstilosTexto.withColor(
                  AppEstilosTexto.h1,
                  Theme.of(context).textTheme.bodyLarge!.color!
                ),
              ),
              SizedBox(height: 8),
              Text('Inicia sesión para continuar',
                style: AppEstilosTexto.withColor(
                  AppEstilosTexto.bodyLarge,
                  isDark? Colors.grey[400]! : Colors.grey[600]!,
                ),
              ),
              SizedBox(height: 40),
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

              SizedBox(height: 8),
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: TextButton(
              //     onPressed: () => Get.to(()=> ForgotPasswordScreen()),
              //     child: Text(
              //       '¿Olvidaste la contraseña?',
              //     style: AppEstilosTexto.withColor(
              //       AppEstilosTexto.buttonMedium,
              //       Theme.of(context).primaryColor,
              //     ),
              //   ),),
              // ),
              // sign in button
              SizedBox(height: 24,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleSignIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child:Text('Iniciar Sesión',
                    style: AppEstilosTexto.withColor(
                      AppEstilosTexto.buttonMedium,
                      Colors.white
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24,),
              // sign up textbutton
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "¿No tienes una cuenta?",
                    style: AppEstilosTexto.withColor(
                      AppEstilosTexto.bodyMedium,
                      isDark? Colors.grey[400]! : Colors.grey[600]!
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.to(()=> CrearCuentaPantalla(),),
                    child: Text(
                      'Sign Up',
                      style: AppEstilosTexto.withColor(
                        AppEstilosTexto.buttonMedium,
                        Theme.of(context).primaryColor
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // sign in button onpressed
  void _handleSignIn() {
    final AutenticacionControlador autenticacionControlador = Get.find<AutenticacionControlador>();
    autenticacionControlador.login();
    Get.offAll(()=> PrincipalPantalla());
  }
}