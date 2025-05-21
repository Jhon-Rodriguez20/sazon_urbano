import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';
import 'package:sazon_urbano/utils/imagen_picker.dart';

class ImagenSeleccionar extends StatefulWidget {
  final void Function(File?) onImageSelected;
  final File? imagenSeleccionada;

  const ImagenSeleccionar({
    super.key,
    required this.onImageSelected,
    this.imagenSeleccionada,
  });

  @override
  State<ImagenSeleccionar> createState() => _ImagenSeleccionarState();
}

class _ImagenSeleccionarState extends State<ImagenSeleccionar> {
  File? _imagen;

  @override
  void initState() {
    super.initState();
    _imagen = widget.imagenSeleccionada;
  }

  void _showImagePickerBottomSheet(BuildContext context, bool isDark) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle para arrastrar
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[700] : Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(height: 20),

              Text(
                'Seleccionar imagen',
                style: AppEstilosTexto.withColor(
                  AppEstilosTexto.h3,
                  Theme.of(context).textTheme.bodyLarge!.color!,
                ),
              ),
              const SizedBox(height: 20),

              _buildOptionTile(
                context,
                'Tomar foto',
                Icons.camera_alt_outlined,
                () => _seleccionarImagen(true),
                isDark,
              ),
              const SizedBox(height: 16),
              _buildOptionTile(
                context,
                'Elegir desde galería',
                Icons.photo_library_outlined,
                () => _seleccionarImagen(false),
                isDark,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  Future<void> _seleccionarImagen(bool desdeCamara) async {
    Get.back();
    final imagen = await ImagenPickerUtil.seleccionarImagen(desdeCamara: desdeCamara);
    if (imagen != null) {
      setState(() {
        _imagen = imagen;
      });
      widget.onImageSelected(imagen);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Stack(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Theme.of(context).primaryColor, width: 2),
              color: const Color.fromARGB(255, 255, 249, 229),
            ),
            child: _imagen == null
                ? Center(
                    child: Text(
                      'Imagen',
                      style: AppEstilosTexto.withColor(
                        AppEstilosTexto.buttonMedium,
                        Theme.of(context).primaryColor
                      ),
                    ),
                  )
                : ClipOval(
                    child: Image.file(
                      _imagen!,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => _showImagePickerBottomSheet(context, isDark),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
                ),
                child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

    Widget _buildOptionTile(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
    bool isDark,
  ) {

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).primaryColor,
              size: 24,
            ),
            SizedBox(width: 16),
            Text(
              title,
              style: AppEstilosTexto.withColor(
                AppEstilosTexto.bodyMedium,
                Theme.of(context).textTheme.bodyLarge!.color!
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: isDark ? Colors.grey[400] : Colors.blueGrey[600],
            )
          ],
        ),
      ),
    );
  }
}