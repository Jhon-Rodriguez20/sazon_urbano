import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AvatarUsuario extends StatelessWidget {
  final double radius;

  const AvatarUsuario({super.key, this.radius = 20});

  String _obtenerIniciales(User user) {
    final nombre = user.email ?? '';
    if (nombre.trim().isEmpty) return 'US';

    final palabras = nombre.trim().split(' ');
    if (palabras.length >= 2) {
      return '${palabras[0][0]}${palabras[1][0]}'.toUpperCase();
    } else {
      return nombre.substring(0, 2).toUpperCase();
    }
  }

  Future<String?> _obtenerUrlImagen(String uid) async {
    final doc = await FirebaseFirestore.instance.collection('usuarios').doc(uid).get();
    if (doc.exists && doc.data()?['urlImagen'] != null) {
      return doc['urlImagen'];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: Colors.grey[300],
        child: Icon(Icons.person, size: radius),
      );
    }

    return FutureBuilder<String?>(
      future: _obtenerUrlImagen(user.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircleAvatar(
            radius: radius,
            backgroundColor: Colors.grey[300],
            child: CircularProgressIndicator(strokeWidth: 2),
          );
        }

        final urlImagen = snapshot.data;

        if (urlImagen != null && urlImagen.isNotEmpty) {
          return CircleAvatar(
            radius: radius,
            backgroundImage: NetworkImage(urlImagen),
          );
        }

        return CircleAvatar(
          radius: radius,
          backgroundColor: Theme.of(context).primaryColor,
          child: Text(
            _obtenerIniciales(user),
            style: TextStyle(
              fontSize: radius * 0.9,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}