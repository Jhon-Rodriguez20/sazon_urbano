import 'dart:io';
import 'package:get/get.dart';
import 'package:sazon_urbano/DB/repositories/restaurante/restaurante_repositorio.dart';
import 'package:sazon_urbano/models/restaurante/restaurante_modelo.dart';
import 'package:sazon_urbano/service/image_service.dart';
import 'package:sazon_urbano/view/principal_pantalla.dart';
import 'package:sazon_urbano/view/widgets/snacbar_personalizado.dart';
import 'package:uuid/uuid.dart';

class RestauranteControlador extends GetxController {
  final RestauranteRepositorio _restauranteRepositorio = RestauranteRepositorio();
  var cargando = false.obs;

  Future<void> crearRestauranteControlador({
    required String razonSocial,
    required String nit,
    required String direccion,
    required String telefono,
    required File? imagen,
    required String idGerente,

  }) async {
    String? urlImagen;
    
    try {
      cargando.value = true;
      
      // Subir imagen si existe
      if (imagen != null) {
        urlImagen = await ImageService.uploadImage(imagen, 'restaurantes');
        if (urlImagen == null) {
          throw Exception('Error al subir la imagen');
        }
      }

      await _restauranteRepositorio.crearRestaurante(
        idRestaurante: const Uuid().v4(),
        razonSocial: razonSocial,
        nit: nit,
        direccion: direccion,
        telefono: telefono,
        urlImagen: urlImagen ?? '',
        idGerente: idGerente,
      );

      cargando.value = false;
      SnackbarPersonalizado.mostrarExito('Restaurante creado con éxito');
      Get.to(()=> PrincipalPantalla());

    } catch (e) {
      cargando.value = false;
      // Si se subió la imagen pero falló después, eliminarla
      if (e.toString().contains('Error al crear restaurante') && urlImagen != null) {
        try {
          await ImageService.deleteImage(urlImagen);
        } catch (deleteError) {
          throw('Error al eliminar la imagen: $deleteError');
        }
      }
      SnackbarPersonalizado.mostrarError('Error: ${e.toString()}');
    }
  }

  var restaurantes = <Restaurante>[].obs;

  Future<void> cargarRestaurantes() async {
    try {
      final lista = await _restauranteRepositorio.obtenerRestaurantes();
      restaurantes.assignAll(lista);
    } catch (e) {
      throw('Error al cargar restaurantes: $e');
    }
  }

  Future<void> cargarMisRestaurantes(String idGerente) async {
    try {
      final lista = await _restauranteRepositorio.obtenerMisRestaurantes(idGerente);
      restaurantes.assignAll(lista);
    } catch (e) {
      throw('Error al cargar restaurantes del gerente: $e');
    }
  }
}