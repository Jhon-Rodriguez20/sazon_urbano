import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/accesibilidad/accesibilidad_controlador.dart';
import 'package:sazon_urbano/controllers/theme/tema_controlador.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';
import 'package:sazon_urbano/view/accesibilidad/views/accesibilidad_pantalla.dart';
import 'package:sazon_urbano/view/politicas%20privacidad/views/politicas_privacidad_pantalla.dart';
import 'package:sazon_urbano/view/terminos%20de%20servicio/views/terminos_de_servicio_pantalla.dart';
import 'package:sazon_urbano/view/version%20app/views/version_app_pantalla.dart';

class ConfiguracionPantalla extends StatelessWidget {
  const ConfiguracionPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accesibilidadCtrl = Get.find<AccesibilidadControlador>();

    return Obx(() {
      final agrandar = accesibilidadCtrl.agrandarTexto.value;
      final espaciado = accesibilidadCtrl.espaciadoTexto.value;
      final desaturar = accesibilidadCtrl.activarDesaturacion.value;

      return ColorFiltered(
        colorFilter: desaturar
          ? const ColorFilter.matrix(<double>[
            0.2126, 0.7152, 0.0722, 0, 0,
            0.2126, 0.7152, 0.0722, 0, 0,
            0.2126, 0.7152, 0.0722, 0, 0,
            0, 0, 0, 1, 0,
          ])
          : const ColorFilter.mode(Colors.transparent, BlendMode.dst),
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            leading: IconButton(
              onPressed: ()=> Get.back(),
              icon: Icon(
                Icons.arrow_back,
                color: isDark ? Colors.white : Colors.black,
              )
            ),
            title: Text(
              'configuracion'.tr,
              style: AppEstilosTexto.withAccesibilidad(
                AppEstilosTexto.h3,
                agrandar: agrandar,
                espaciado: espaciado,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSection(
                  context,
                  'apariencia'.tr,
                  [
                    _buildThemeToggle(context),
                  ],
                ),
                _buildSection(context, 'privacidad'.tr, [
                  _buildNavigationTile(
                    context,
                    'politicas_de_privacidad'.tr,
                    'ver_nuestras_politicas_de_privacidad'.tr,
                    Icons.privacy_tip_outlined,
                    onTap: ()=> Get.to(() => PoliticasPrivacidadPantalla()),
                  ),
                  _buildNavigationTile(
                    context,
                    'terminos_de_servicio'.tr,
                    'leer_sobre_terminos_servicio'.tr,
                    Icons.description_outlined,
                    onTap: ()=> Get.to(() => TerminosDeServicioPantalla()),
                  ),
                ],),

                _buildSection(context, 'accesibilidad'.tr, [
                  _buildNavigationTile(
                  context,
                  'menu_de_accesibilidad'.tr,
                  'mensaje_accesibilidad'.tr,
                  Icons.accessibility_outlined,
                  onTap: () => Get.to(() => AccesibilidadPantalla()),
                  ),
                ],),

                _buildSection(context, 'a_cerca_de'.tr, [
                  _buildNavigationTile(
                    context,
                    'version_app'.tr,
                    'version'.tr,
                    Icons.info_outline,
                    onTap: () => Get.to(() => VersionAppPantalla()),
                  ),
                ],),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accesibilidadCtrl = Get.find<AccesibilidadControlador>();
    final agrandar = accesibilidadCtrl.agrandarTexto.value;
    final espaciado = accesibilidadCtrl.espaciadoTexto.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(24, 24, 24, 8),
          child: Text(
            title,
            style: AppEstilosTexto.withAccesibilidad(
              AppEstilosTexto.h3,
              agrandar: agrandar,
              espaciado: espaciado,
              color: isDark ? Colors.grey[400]! : Colors.grey[600]!,
            ),
          ),
        ),
        ...children
      ],
    );
  }

  Widget _buildThemeToggle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accesibilidadCtrl = Get.find<AccesibilidadControlador>();
    final agrandar = accesibilidadCtrl.agrandarTexto.value;
    final espaciado = accesibilidadCtrl.espaciadoTexto.value;

    return GetBuilder<TemaControlador>(
      builder: (controller)=> Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: isDark ? const Color.fromARGB(255, 39, 39, 39) : const Color.fromARGB(255, 237, 237, 237),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(
            controller.esModoOscuro ? Icons.dark_mode : Icons.light_mode,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(
            'tema_preferido'.tr,
            style: AppEstilosTexto.withAccesibilidad(
              AppEstilosTexto.bodyMedium,
              agrandar: agrandar,
              espaciado: espaciado,
              color: Theme.of(context).textTheme.bodyLarge!.color!,
            ),
          ),
          trailing: Switch.adaptive(
            value: controller.esModoOscuro,
            onChanged: (value) => controller.elegirTema(),
            activeColor: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationTile(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon, 
    {VoidCallback? onTap}
  ) {
    
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accesibilidadCtrl = Get.find<AccesibilidadControlador>();
    final agrandar = accesibilidadCtrl.agrandarTexto.value;
    final espaciado = accesibilidadCtrl.espaciadoTexto.value;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: isDark ? const Color.fromARGB(255, 39, 39, 39) : const Color.fromARGB(255, 237, 237, 237),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(
            title,
            style: AppEstilosTexto.withAccesibilidad(
              AppEstilosTexto.bodyMedium,
              agrandar: agrandar,
              espaciado: espaciado,
              color: Theme.of(context).textTheme.bodyLarge!.color!,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: AppEstilosTexto.withAccesibilidad(
              AppEstilosTexto.bodySmall,
              agrandar: agrandar,
              espaciado: espaciado,
              color: isDark ? Colors.grey[400]! : Colors.grey[600]!,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
      ),
    );
  }
}