import 'package:get/get.dart';
import 'package:sazon_urbano/DB/repositories/auth/crear_cuenta_repositorio.dart';
import 'package:sazon_urbano/view/iniciar_sesion_pantalla.dart';
import 'package:sazon_urbano/view/widgets/snacbar_personalizado.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UsuarioControlador extends GetxController {
  final UsuarioRepositorio _usuarioRepositorio = UsuarioRepositorio();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  var cargando = false.obs;

  Future<void> crearCuenta({
    required String nombre,
    required String celular,
    required String email,
    String? ocupacion, // <-- ya no required, por seguridad
    required String password,
    required String urlImagen,
    required String idRol,
    String? idGerente,
  }) async {
    try {
      cargando.value = true;

      // Verificar si ya existe un usuario con ese email en Firestore
      final existeUsuario = await _usuarioRepositorio.existeUsuarioConEmail(email);
      if (existeUsuario) {
        cargando.value = false;
        SnackbarPersonalizado.mostrarError('El correo ya está registrado.');
        return;
      }

      // Crear usuario en FirebaseAuth
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user?.uid;
      if (uid == null) {
        cargando.value = false;
        SnackbarPersonalizado.mostrarError('Error: UID no válido.');
        return;
      }

      // Si ocupacion no se pasó, se pone 'Cliente'
      final ocupacionFinal = (ocupacion?.trim().isEmpty ?? true) ? 'Cliente' : ocupacion!.trim();

      // Crear usuario en Firestore usando el UID de FirebaseAuth
      await _usuarioRepositorio.crearUsuario(
        idUsuario: uid,
        nombre: nombre,
        celular: celular,
        email: email,
        ocupacion: ocupacionFinal,
        urlImagen: urlImagen,
        idRol: idRol,
        idGerente: idGerente,
      );

      cargando.value = false;
      SnackbarPersonalizado.mostrarExito('Cuenta creada correctamente');
      Get.offAll(() => IniciarSesionPantalla());

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
      SnackbarPersonalizado.mostrarError('Error inesperado: ${e.toString()}');
    }
  }
}