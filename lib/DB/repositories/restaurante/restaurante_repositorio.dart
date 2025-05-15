import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sazon_urbano/models/restaurante/restaurante_modelo.dart';

class RestauranteRepositorio {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> crearRestaurante({
    required String idRestaurante,
    required String razonSocial,
    required String nit,
    required String direccion,
    required String telefono,
    required String urlImagen,
    required String idGerente,

  }) async {
    try {
      final Map<String, dynamic> data = {
        'idRestaurante': idRestaurante,
        'razonSocial': razonSocial,
        'nit': nit,
        'direccion': direccion,
        'telefono': telefono,
        'urlImagen': urlImagen,
        'idGerente': idGerente,
      };

      await _firestore.collection('restaurantes').doc(idRestaurante).set(data);

    } catch (e) {
      throw Exception('Error al crear restaurante: $e');
    }
  }

  Future<List<Restaurante>> obtenerRestaurantes() async {
    try {
      final snapshot = await _firestore.collection('restaurantes').get();

      return snapshot.docs.map((doc) {
        return Restaurante.fromMap(doc.data());
      }).toList();
    } catch (e) {
      throw Exception('Error al obtener restaurantes: $e');
    }
  }
}