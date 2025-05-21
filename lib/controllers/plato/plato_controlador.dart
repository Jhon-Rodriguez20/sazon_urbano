import 'dart:io';
import 'package:get/get.dart';
import 'package:sazon_urbano/DB/repositories/plato/plato_repositorio.dart';
import 'package:sazon_urbano/models/plato/plato_modelo.dart';
import 'package:sazon_urbano/service/image_service.dart';
import 'package:sazon_urbano/view/plato/ver_platos_pantalla.dart';
import 'package:sazon_urbano/view/widgets/snacbar_personalizado.dart';
import 'package:uuid/uuid.dart';

class PlatoControlador extends GetxController {
  final PlatoRepositorio _platoRepositorio = PlatoRepositorio();
  var cargando = false.obs;

  Future<void> crearPlatoControlador({
    required String nombrePlato,
    required String precio,
    required String descripcion,
    required String historial,
    required File? imagen,
    required String idRestaurante,

  }) async {
    String? urlImagen;
    
    try {
      cargando.value = true;
      
      if (imagen != null) {
        urlImagen = await ImageService.uploadImage(imagen, 'platos');
        if (urlImagen == null) {
          throw Exception('Error al subir la imagen');
        }
      }

      await _platoRepositorio.crearPlato(
        idPlato: const Uuid().v4(),
        nombrePlato: nombrePlato,
        precio: precio,
        descripcion: descripcion,
        historial: historial,
        urlImagen: urlImagen ?? '',
        idRestaurante: idRestaurante,
      );

      cargando.value = false;
      SnackbarPersonalizado.mostrarExito('Plato creado con éxito');
      Get.to(()=> VerPlatosPantalla(idRestaurante: idRestaurante,));

    } catch (e) {
      cargando.value = false;
      // Si se subió la imagen pero falló después, eliminarla
      if (e.toString().contains('Error al crear el plato') && urlImagen != null) {
        try {
          await ImageService.deleteImage(urlImagen);
        } catch (deleteError) {
          throw('Error al eliminar la imagen: $deleteError');
        }
      }
      SnackbarPersonalizado.mostrarError('Error: ${e.toString()}');
    }
  }

  var platos = <Plato>[].obs;

  Future<void> cargarPlatos() async {
    try {
      final lista = await _platoRepositorio.obtenerPlatos();
      platos.assignAll(lista);
    } catch (e) {
      throw('Error al cargar platos: $e');
    }
  }
}