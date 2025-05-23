import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UsuarioRepositorio {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String get uid => _auth.currentUser!.uid;

  Future<Map<String, dynamic>?> obtenerUsuario() async {
    final doc = await _firestore.collection('usuarios').doc(uid).get();
    return doc.exists ? doc.data() : null;
  }

  Future<void> actualizarUsuario({
    required String nombre,
    required String email,
    String? urlImagen,
  }) async {
    final data = {
      'nombre': nombre,
      'email': email,
    };

    if (urlImagen != null) {
      data['urlImagen'] = urlImagen;
    }

    await _firestore.collection('usuarios').doc(uid).update(data);
  }
}