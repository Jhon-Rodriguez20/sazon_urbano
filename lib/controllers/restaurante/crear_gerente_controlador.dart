import 'package:get/get.dart';
import 'package:sazon_urbano/DB/repositories/auth/crear_cuenta_repositorio.dart';
import 'package:sazon_urbano/view/widgets/snacbar_personalizado.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CrearGerenteControlador extends GetxController {
  final UsuarioRepositorio _usuarioRepositorio = UsuarioRepositorio();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  var cargando = false.obs;

  Future<void> crearGerente({
    required String nombre,
    required String email,
    String? ocupacion,
    required String password,
    required String urlImagen,
    required String idRol,
    String? idGerente,
    
  }) async {
    try {
      cargando.value = true;

      final existeUsuario = await _usuarioRepositorio.existeUsuarioConEmail(email);
      if (existeUsuario) {
        cargando.value = false;
        SnackbarPersonalizado.mostrarError('correo_ya_registrado'.tr);
        return;
      }

      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user?.uid;
      if (uid == null) {
        cargando.value = false;
        return;
      }

      final ocupacionFinal = (ocupacion?.trim().isEmpty ?? true) ? 'Gerente' : ocupacion!.trim();

      await _usuarioRepositorio.crearUsuario(
        idUsuario: uid,
        nombre: nombre,
        email: email,
        ocupacion: ocupacionFinal,
        urlImagen: urlImagen,
        idRol: idRol,
        idGerente: idGerente,
      );

      cargando.value = false;
      SnackbarPersonalizado.mostrarExito('mensaje_gerente_exito'.tr);

    } on FirebaseAuthException catch (e) {
      cargando.value = false;
      String mensaje = 'Error al registrar usuario.';
      if (e.code == 'weak-password') {
        mensaje = 'La contraseña es muy débil.';
      } else if (e.code == 'email-already-in-use') {
        mensaje = 'El correo ya está registrado.';
      }
      SnackbarPersonalizado.mostrarError(mensaje);
    } catch (e) {
      cargando.value = false;
    }
  }
}