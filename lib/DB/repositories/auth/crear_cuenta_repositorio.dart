import 'package:cloud_firestore/cloud_firestore.dart';

class UsuarioRepositorio {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> crearUsuario({
    required String idUsuario, // <-- ahora recibe el uid de FirebaseAuth
    required String nombre,
    required String celular,
    required String email,
    required String urlImagen,
    required String idRol,
    String? ocupacion,
    String? idGerente,
  }) async {
    try {
      final Map<String, dynamic> data = {
        'idUsuario': idUsuario,
        'nombre': nombre,
        'celular': celular,
        'email': email,
        'urlImagen': urlImagen,
        'idRol': idRol,
        'fechaCreacion': FieldValue.serverTimestamp(), // <-- agrego fecha si quieres
      };

      if (ocupacion != null && ocupacion.trim().isNotEmpty) {
        data['ocupacion'] = ocupacion;
      }
      if (idGerente != null && idGerente.trim().isNotEmpty) {
        data['idGerente'] = idGerente;
      }

      await _firestore.collection('usuarios').doc(idUsuario).set(data);

    } catch (e) {
      print('Error detallado al crear usuario: $e');
      throw Exception('Error al crear usuario: $e');
    }
  }

  Future<bool> existeUsuarioConEmail(String email) async {
    final snapshot = await _firestore
        .collection('usuarios')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    return snapshot.docs.isNotEmpty;
  }
}