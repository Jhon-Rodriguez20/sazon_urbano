import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class AvatarUsuario extends StatelessWidget {
  final double radius;

  const AvatarUsuario({super.key, this.radius = 20});

  String _obtenerIniciales(User user) {
    final email = user.email ?? '';
    if (email.trim().isEmpty) return 'US';

    final nombreSinDominio = email.split('@')[0];
    if (nombreSinDominio.length >= 2) {
      return nombreSinDominio.substring(0, 2).toUpperCase();
    } else {
      return nombreSinDominio.toUpperCase();
    }
  }

  Future<String?> _obtenerUrlImagen(String uid) async {
    final doc = await FirebaseFirestore.instance.collection('usuarios').doc(uid).get();
    final url = doc.data()?['urlImagen'];
    if (url == null || url.isEmpty) return null;

    try {
      final response = await http.head(Uri.parse(url));
      if (response.statusCode == 200) {
        return url;
      }

    } catch (e) {
      // Error al conectarse o imagen no encontrada
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