import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/auth/autenticacion_controlador.dart';
import 'package:sazon_urbano/principal_binding.dart';
import 'package:sazon_urbano/view/iniciar_sesion_pantalla.dart';
import 'package:sazon_urbano/view/presentacion_pantalla.dart';
import 'package:sazon_urbano/view/principal_pantalla.dart';

class BienvenidaPantalla extends StatelessWidget {
  BienvenidaPantalla({super.key});

  final AutenticacionControlador autenticacionControlador = Get.find<AutenticacionControlador>();

  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(milliseconds: 2500),(){

      if(autenticacionControlador.esPrimeraVez) {
        Get.off(()=> const PresentacionPantalla());

      } else if (autenticacionControlador.esLogueado) {
        Get.offAll(() => PrincipalPantalla(), binding: PrincipalBinding());

      } else {
        Get.off(()=> IniciarSesionPantalla());
      }
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor,
            const Color.fromARGB(255, 255, 154, 38),
            const Color.fromARGB(255, 255, 169, 41),
            ],
          ),
        ),
        child: Stack(
          children: [
            // background pattern
            Positioned.fill(
              child: Opacity(opacity: 0.05,
              child: GridPattern(
                color: Colors.white,
              ),
              )),
            
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: Duration(milliseconds: 1200),
                    builder: (context, value, child){
                      return Opacity(opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/Logo.webp',
                          height: MediaQuery.of(context).size.height * 0.4,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 48,
              left: 0,
              right: 0,
              child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: Duration(milliseconds: 1200),
              builder: (context, value, child){
                return Opacity(
                  opacity: value,
                  child: child,
                );
              },
                child: Text(
                  'Tradición que se saborea',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GridPattern extends StatelessWidget {
  final Color color;
  const GridPattern({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GridPainter(color: color),
    );
  }
}

class GridPainter extends CustomPainter {
  final Color color;

  GridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
    ..color = color
    ..strokeWidth = 0.5;

    final spacing = 20.0;

    for(var i=0.0; i < size.width; i += spacing) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }

    for(var i=0.0; i < size.height; i += spacing) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDeletate) => false;
}