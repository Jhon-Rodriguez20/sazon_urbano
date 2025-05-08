import 'package:cloud_firestore/cloud_firestore.dart';

class ConexionBaseDatos {
  // Singleton: para que siempre usemos la misma instancia
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static FirebaseFirestore get firestore => _firestore;
}