import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sazon_urbano/models/plato/plato_modelo.dart';

class PlatoRepositorio {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> crearPlato({
    required String idPlato,
    required String nombrePlato,
    required String precio,
    required String descripcion,
    required String historial,
    required String urlImagen,
    required String idRestaurante,

  }) async {
    try {
      final Map<String, dynamic> data = {
        'idPlato': idPlato,
        'nombrePlato': nombrePlato,
        'precio': precio,
        'descripcion': descripcion,
        'historial': historial,
        'urlImagen': urlImagen,
        'idRestaurante': idRestaurante,
      };

      await _firestore.collection('platos').doc(idPlato).set(data);

    } catch (e) {
      throw Exception('Error al crear el plato: $e');
    }
  }

  Future<List<Plato>> obtenerPlatos() async {
    try {
      final snapshot = await _firestore.collection('platos').get();

      return snapshot.docs.map((doc) {
        return Plato.fromMap(doc.data());
      }).toList();
      
    } catch (e) {
      throw Exception('Error al obtener los platos: $e');
    }
  }
}