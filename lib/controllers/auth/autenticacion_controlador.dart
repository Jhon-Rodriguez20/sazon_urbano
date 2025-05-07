import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AutenticacionControlador extends GetxController{
  final _storage = GetStorage();
  
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
    _esPrimeraVez.value = _storage.read('esPrimeraVez')?? true;
    _esLogueado.value = _storage.read('esLogueado')?? false;
  }

  void setFirstTimeDone() {
    _esPrimeraVez.value = false;
    _storage.write('esPrimeraVez', false);
  }

  void login(){
    _esPrimeraVez.value = true;
    _storage.write('esLogueado', true);
  }

  void logout() {
    _esPrimeraVez.value = false;
    _storage.write('esLogueado', false);
  }
}