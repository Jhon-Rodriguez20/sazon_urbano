class Plato {
  final String idPlato;
  final String nombrePlato;
  final String precio;
  final String descripcion;
  final String historial;
  final String urlImagen;
  final String idRestaurante;

  Plato({
    required this.idPlato,
    required this.nombrePlato,
    required this.precio,
    required this.descripcion,
    required this.historial,
    required this.urlImagen,
    required this.idRestaurante,
  });

  factory Plato.fromMap(Map<String, dynamic> data) {
    return Plato(
      idPlato: data['idPlato'] ?? '',
      nombrePlato: data['nombrePlato'] ?? '',
      precio: data['precio'] ?? '',
      descripcion: data['descripcion'] ?? '',
      historial: data['historial'] ?? '',
      urlImagen: data['urlImagen'] ?? '',
      idRestaurante: data['idRestaurante'] ?? '',
    );
  }
}