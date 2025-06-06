import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';
import 'package:sazon_urbano/utils/imagen_picker.dart';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

class ImagenSeleccionar extends StatefulWidget {
  final void Function(File?) onImageSelected;
  final File? imagenSeleccionada;
  final String? urlImagenRemota;

  const ImagenSeleccionar({
    super.key,
    required this.onImageSelected,
    this.imagenSeleccionada,
    this.urlImagenRemota,
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
              
              SizedBox(height: 20),
              Text(
                'seleccionar_imagen'.tr,
                style: AppEstilosTexto.withColor(
                  AppEstilosTexto.h3,
                  Theme.of(context).textTheme.bodyLarge!.color!,
                ),
              ),
              const SizedBox(height: 20),

              _buildOptionTile(
                context,
                'tomar_foto'.tr,
                Icons.camera_alt_outlined,
                () => _seleccionarImagen(true),
                isDark,
              ),
              const SizedBox(height: 16),
              _buildOptionTile(
                context,
                'elegir_desde_galería'.tr,
                Icons.photo_library_outlined,
                () => _seleccionarImagen(false),
                isDark,
              ),
              SizedBox(height: 16),
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
      final imagenRedimensionada = await redimensionarImagen(imagen, 300, 199);

      setState(() {
        _imagen = imagenRedimensionada;
      });
      widget.onImageSelected(imagenRedimensionada);
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
            child: _imagen != null
            ? ClipOval(
                child: Image.file(
                  _imagen!,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              )
            : (widget.urlImagenRemota != null && widget.urlImagenRemota!.isNotEmpty)
                ? ClipOval(
                    child: Image.network(
                      widget.urlImagenRemota!,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _placeholder(),
                    ),
                  )
                : _placeholder(),
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

  Widget _placeholder() {
    return Center(
      child: Text(
        'imagen'.tr,
        style: AppEstilosTexto.withColor(
          AppEstilosTexto.buttonMedium,
          Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Future<File> redimensionarImagen(File imagenOriginal, int ancho, int alto) async {
    final bytes = await imagenOriginal.readAsBytes();
    final imagen = img.decodeImage(Uint8List.fromList(bytes));

    if (imagen == null) return imagenOriginal;

    final redimensionada = img.copyResize(imagen, width: ancho, height: alto);
    final nuevaRuta = imagenOriginal.path.replaceFirst('.jpg', '_resized.jpg');

    final nuevoArchivo = File(nuevaRuta)
      ..writeAsBytesSync(img.encodeJpg(redimensionada, quality: 85));

    return nuevoArchivo;
  }
}