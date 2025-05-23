import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sazon_urbano/DB/repositories/auth/iniciar_sesion_repositorio.dart';
import 'package:sazon_urbano/controllers/navigation/navegacion_controlador.dart';

class AutenticacionControlador extends GetxController {
  final AuthRepositorio _authRepositorio = AuthRepositorio();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final RxBool _esPrimeraVez = true.obs;
  final RxBool _esLogueado = false.obs;

  bool get esPrimeraVez => _esPrimeraVez.value;
  bool get esLogueado => _esLogueado.value;

  @override
  void onInit() {
    super.onInit();
    _loadInitialState();
  }

  void _loadInitialState() {
    _esPrimeraVez.value = GetStorage().read('esPrimeraVez') ?? true;
    _esLogueado.value = _authRepositorio.estaLogueado();
  }

  void setFirstTimeDone() {
    _esPrimeraVez.value = false;
    GetStorage().write('esPrimeraVez', false);
  }

  Future<bool> loginConFirebase(String email, String password) async {
    try {
      final cred = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final snapshot = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(cred.user!.uid)
          .get();
      final idRol = snapshot.data()?['idRol'] ?? '3';

      _authRepositorio.guardarInicioSesion(idRol: idRol);
      _esLogueado.value = true;

      // 🔥 IMPORTANTE: Asegúrate de limpiar el controlador previo
      if (Get.isRegistered<NavegacionControlador>()) {
        Get.delete<NavegacionControlador>(force: true);
      }

      // ✅ Registrar uno nuevo
      Get.put(NavegacionControlador());

      return true;
    } on FirebaseAuthException {
      return false;
    }
  }

  Future<bool> registrarUsuarioFirebase(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException {
      return false;
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    _authRepositorio.cerrarSesion();
    _esLogueado.value = false;

    // Solo eliminar el controlador
    if (Get.isRegistered<NavegacionControlador>()) {
      Get.delete<NavegacionControlador>();
    }
  }

  bool sesionExpirada() {
    final loginTime = _authRepositorio.obtenerTiempoLogueo();
    if (loginTime == null) return true;
    final now = DateTime.now();
    final difference = now.difference(loginTime);
    return difference.inHours >= 24;
  }
}