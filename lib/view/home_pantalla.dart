import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/theme/tema_controlador.dart';

class HomePantalla extends StatelessWidget {
  const HomePantalla({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // header section
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/avatar.jpg'),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hola Alexander',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Buenos días',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  // notification icon
                  // IconButton(
                  //   onPressed: () => Get.to(()=> NotificationsScreen()),
                  //   icon: Icon(Icons.notifications_outlined),
                  // ),
                  // cart button
                  // IconButton(
                  //   onPressed: () => Get.to(()=> CartScreen()),
                  //   icon: Icon(Icons.shopping_bag_outlined),
                  // ),
                  // theme button
                  GetBuilder<TemaControlador>(
                    builder: (controller) => IconButton(
                      onPressed: ()=> controller.elegirTema(), 
                      icon: Icon(
                        controller.esModoOscuro
                          ? Icons.light_mode
                          : Icons.dark_mode
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // search bar
            // CustomSearchBar(),

            // // category chips
            // CategoryChips(),

            // // sale banner
            // SaleBanner(),

            // popular product
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Restaurantes Destacados',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: ()=> Get.to(()=> AllProductsScreen()),
                  //   child: Text(
                  //     'See All',
                  //     style: TextStyle(
                  //       color: Theme.of(context).primaryColor
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),

            // product grid
            // Expanded(child: ProductGrid()),
          ],
        ),
      ),
    );
  }
}