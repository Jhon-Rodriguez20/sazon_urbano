import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ImageService {
  static const String _baseUrl = 'https://api-para-subir-imagenes.onrender.com';

  static Future<String?> uploadImage(File imageFile, String category) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$_baseUrl/upload/$category'),
      );

      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      var response = await request.send();
      
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        return jsonDecode(responseData)['url'];
      }
      return null;
    } catch (e) {
      throw('Error al subir imagen: $e');
    }
  }

  static Future<void> deleteImage(String imageUrl) async {
    try {
      final uri = Uri.parse(imageUrl);
      final filename = uri.pathSegments.last;
      final category = uri.pathSegments[uri.pathSegments.length - 2];
      
      final response = await http.delete(
        Uri.parse('$_baseUrl/image/$category/$filename'),
      );
      
      if (response.statusCode != 200) {
        throw Exception('Error al eliminar la imagen');
      }
    } catch (e) {
      throw('Error al eliminar imagen: $e');
    }
  }
}