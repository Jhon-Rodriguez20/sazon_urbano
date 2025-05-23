import 'package:get_storage/get_storage.dart';

class AuthRepositorio {
  final _storage = GetStorage();

  static const String _keyIsLoggedIn = 'esLogueado';
  static const String _keyLoginTime = 'tiempoLogueo';
  static const String _keyRol = 'idRol';

  void guardarInicioSesion({required String idRol}) {
    _storage.write(_keyIsLoggedIn, true);
    _storage.write(_keyLoginTime, DateTime.now().toIso8601String());
    _storage.write(_keyRol, idRol);
  }

  void cerrarSesion() {
    _storage.remove(_keyIsLoggedIn);
    _storage.remove(_keyLoginTime);
    _storage.remove(_keyRol);
  }

  bool estaLogueado() {
    return _storage.read(_keyIsLoggedIn) ?? false;
  }

  DateTime? obtenerTiempoLogueo() {
    final timeString = _storage.read(_keyLoginTime);
    if (timeString != null) {
      return DateTime.tryParse(timeString);
    }
    return null;
  }

  String? obtenerRol() {
    return _storage.read(_keyRol);
  }
}