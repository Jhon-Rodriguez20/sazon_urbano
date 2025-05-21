import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/theme/tema_controlador.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';

class ConfiguracionPantalla extends StatelessWidget {
  const ConfiguracionPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()=> Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          )
        ),
        title: Text(
          'Configuración',
          style: AppEstilosTexto.withColor(
            AppEstilosTexto.h3,
            isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              context,
              'Apariencia',
              [
                _buildThemeToggle(context),
              ],
            ),
            _buildSection(context, 'Privacy', [
              _buildNavigationTile(
                context,
                'Políticas de Privacidad',
                'Ver nuestras políticas de Privacidad',
                Icons.privacy_tip_outlined,
                // onTap: ()=> Get.to(() => PrivacyPolicyScreen()),
              ),
              _buildNavigationTile(
                context,
                'Términos de Servicio',
                'Leer sobre nuestros términos de servicio',
                Icons.description_outlined,
                // onTap: ()=> Get.to(() => TermsOfServiceScreen()),
              ),
            ],),

            _buildSection(context, 'A cerca de', [
              _buildNavigationTile(context, 'Versión de App', '1.0.0', Icons.info_outline)
            ],),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(24, 24, 24, 8),
          child: Text(
            title,
            style: AppEstilosTexto.withColor(
              AppEstilosTexto.h3,
              isDark ? Colors.grey[400]! : Colors.grey[600]!,
            ),
          ),
        ),
        ...children
      ],
    );
  }

  Widget _buildThemeToggle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
            'Tema preferido',
            style: AppEstilosTexto.withColor(
              AppEstilosTexto.bodyMedium,
              Theme.of(context).textTheme.bodyLarge!.color!
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
            style: AppEstilosTexto.withColor(
              AppEstilosTexto.bodyMedium,
              Theme.of(context).textTheme.bodyLarge!.color!,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: AppEstilosTexto.withColor(
              AppEstilosTexto.bodySmall,
              isDark ? Colors.grey[400]! : Colors.grey[600]!,
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