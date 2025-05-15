import 'package:cloud_firestore/cloud_firestore.dart';

class BuscarUsuarios {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> obtenerGerentes() async {
    try {
      final querySnapshot = await _firestore
        .collection('usuarios')
        .where('idRol', isEqualTo: '2')
        .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'idUsuario': doc.id,
          'nombre': data['nombre'],
        };
      }).toList();
    } catch (e) {
      throw Exception('Error al obtener gerentes: $e');
    }
  }
}