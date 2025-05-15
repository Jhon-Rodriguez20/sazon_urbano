import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/auth/autenticacion_controlador.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';
import 'package:sazon_urbano/view/iniciar_sesion_pantalla.dart';

class PresentacionPantalla extends StatefulWidget {
  const PresentacionPantalla({super.key});

  @override
  State<PresentacionPantalla> createState() => _PresentacionPantallaState();
}

class _PresentacionPantallaState extends State<PresentacionPantalla> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingItem> _items = [
    OnboardingItem(
      title: 'Platillos Típicos',
      description: 'Descubre los sabores auténticos de nuestra cultura con los mejores platillos tradicionales.',
      image: 'assets/images/intro.png',
    ),
    OnboardingItem(
      title: 'Restaurantes Nativos',
      description: 'Apoya lo local disfrutando de comidas únicas preparadas por restaurantes auténticos de la región.',
      image: 'assets/images/intro1.png',
    ),
  ];

  void _handleGetStarted() {
    final AutenticacionControlador autenticacionControlador = Get.find<AutenticacionControlador>();
    autenticacionControlador.setFirstTimeDone();
    Get.off(()=> IniciarSesionPantalla());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _items.length,
            onPageChanged: (index){
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    _items[index].image,
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    _items[index].title,
                    textAlign: TextAlign.center,
                    style: AppEstilosTexto.withColor(
                      AppEstilosTexto.h1,
                      Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      _items[index].description,
                      textAlign: TextAlign.center,
                      style: AppEstilosTexto.withColor(
                      AppEstilosTexto.bodyLarge,
                      isDark? Colors.grey[400]! : Colors.grey[600]!,
                    ),
                    ),
                  ),
                ],
              );
            }
          ),
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_items.length, (index)=> AnimatedContainer(
                duration: Duration(microseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: _currentPage == index ? 24 : 8,
                decoration: BoxDecoration(
                  color: _currentPage == index ? Theme.of(context).primaryColor
                    : (isDark? Colors.grey[700] : Colors.grey[300]),
                  borderRadius: BorderRadius.circular(4),
                ),
              )),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => _handleGetStarted(),
                child: Text(
                  "Saltar",
                  style: AppEstilosTexto.withColor(
                    AppEstilosTexto.buttonMedium,
                    isDark? Colors.grey[400]! : Colors.grey[600]!,
                  ),
                ),
              ),
              ElevatedButton(onPressed: (){
                if(_currentPage < _items.length - 1) {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } else {
                  _handleGetStarted();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                _currentPage < _items.length - 1 ? 'Siguiente' : 'Empezar',
                style: AppEstilosTexto.withColor(
                  AppEstilosTexto.buttonMedium,
                  Colors.white),
              ),),
            ],
          ),),
        ],
      ),
    );
  }
}

class OnboardingItem {
  final String image;
  final String title;
  final String description;

  OnboardingItem({
    required this.description,
    required this.title,
    required this.image,
  });
}