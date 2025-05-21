import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/auth/autenticacion_controlador.dart';
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
        Get.off(()=> const PrincipalPantalla());

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
              Theme.of(context).primaryColor.withValues(),
              Theme.of(context).primaryColor.withValues(),
            ]

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
            
            // main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // animated logo container
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: Duration(milliseconds: 1200),
                    builder: (context, value, child){
                      return Transform.scale(
                        scale: value,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 174, 174, 174),
                                blurRadius: 20,
                                spreadRadius: 2,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(Icons.restaurant_menu_outlined,
                          size: 70,
                          color: Theme.of(context).primaryColor,
                          ),
                        ),
                      );
                    },
                    ),
                    const SizedBox(height: 32),

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
                      Text(
                        "BOCADOS DE",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 8,
                        ),
                      ),
                      Text(
                        "TRADICIÓN",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 4,
                        ),
                      ),
                    ],
                  ),
                  ),
                  // bottom tagline
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
                  'Bocados de tradición, donde la tradición cobra sabor',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withValues(),
                    fontSize: 16,
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