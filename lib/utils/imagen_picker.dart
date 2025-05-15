import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class ImagenPickerUtil {
  static final ImagePicker _picker = ImagePicker();

  static Future<File?> seleccionarImagen({required bool desdeCamara}) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: desdeCamara ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 85,
    );

    if (pickedFile == null) return null;

    final Directory appDir = await getApplicationDocumentsDirectory();
    final String fileName = basename(pickedFile.path);
    final File localImage = await File(pickedFile.path).copy('${appDir.path}/$fileName');

    return localImage;
  }
}