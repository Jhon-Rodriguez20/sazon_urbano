import 'package:get_storage/get_storage.dart';

class AuthRepositorio {
  final _storage = GetStorage();

  static const String _keyIsLoggedIn = 'esLogueado';
  static const String _keyLoginTime = 'tiempoLogueo';

  void guardarInicioSesion() {
    _storage.write(_keyIsLoggedIn, true);
    _storage.write(_keyLoginTime, DateTime.now().toIso8601String());
  }

  void cerrarSesion() {
    _storage.write(_keyIsLoggedIn, false);
    _storage.remove(_keyLoginTime);
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
}