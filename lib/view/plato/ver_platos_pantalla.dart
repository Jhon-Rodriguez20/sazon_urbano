import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sazon_urbano/controllers/accesibilidad/accesibilidad_controlador.dart';
import 'package:sazon_urbano/controllers/plato/plato_controlador.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';
import 'package:sazon_urbano/view/widgets/barra_busqueda_personalizado.dart';
import 'package:sazon_urbano/view/plato/plato_grid.dart';
import 'package:sazon_urbano/view/plato/crear_plato_pantalla.dart';

class VerPlatosPantalla extends StatefulWidget {
  final String idRestaurante;
  const VerPlatosPantalla({super.key, required this.idRestaurante});

  @override
  State<VerPlatosPantalla> createState() => _VerPlatosPantallaState();
}

class _VerPlatosPantallaState extends State<VerPlatosPantalla> {
  bool _esGerente = false;
  bool _cargando = true;
  final PlatoControlador platoControlador = Get.put(PlatoControlador());

  @override
  void initState() {
    super.initState();
    _verificarRolUsuario();
  }

  Future<void> _verificarRolUsuario() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('usuarios').doc(user.uid).get();
      final data = doc.data();
      if (data != null && data['idRol'] == '2') {
        setState(() {
          _esGerente = true;
        });
      }
    }

    setState(() {
      _cargando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accesibilidadCtrl = Get.find<AccesibilidadControlador>();

    if (_cargando) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Obx(() {
      final agrandar = accesibilidadCtrl.agrandarTexto.value;
      final espaciado = accesibilidadCtrl.espaciadoTexto.value;
      final desaturar = accesibilidadCtrl.activarDesaturacion.value;

      return ColorFiltered(
        colorFilter: desaturar
            ? const ColorFilter.matrix(<double>[
                0.2126, 0.7152, 0.0722, 0, 0,
                0.2126, 0.7152, 0.0722, 0, 0,
                0.2126, 0.7152, 0.0722, 0, 0,
                0, 0, 0, 1, 0,
              ])
            : const ColorFilter.mode(Colors.transparent, BlendMode.dst),
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            title: Text(
              'platos'.tr,
              style: AppEstilosTexto.withAccesibilidad(
                AppEstilosTexto.h3,
                agrandar: agrandar,
                espaciado: espaciado,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ),
          body: Column(
            children: [
              BarraBusquedaPersonalizado(
                hintText: 'buscador_personalizado_plato'.tr,
                onChanged: (valor) => platoControlador.terminoBusqueda.value = valor,
              ),
              Expanded(
                child: PlatoGrid(idRestaurante: widget.idRestaurante),
              ),
            ],
          ),
          floatingActionButton: _esGerente
              ? SizedBox(
                  width: 72,
                  height: 72,
                  child: FloatingActionButton(
                    onPressed: () {
                      Get.to(() => CrearPlatoPantalla(idRestaurante: widget.idRestaurante));
                    },
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: const CircleBorder(),
                    child: const Icon(
                      Icons.add,
                      size: 36,
                      color: Colors.white,
                    ),
                  ),
                )
              : null,
        ),
      );
    });
  }
}