class Restaurante {
  final String idRestaurante;
  final String razonSocial;
  final String nit;
  final String direccion;
  final String telefono;
  final String urlImagen;
  final String idGerente;

  Restaurante({
    required this.idRestaurante,
    required this.razonSocial,
    required this.nit,
    required this.direccion,
    required this.telefono,
    required this.urlImagen,
    required this.idGerente,
  });

  factory Restaurante.fromMap(Map<String, dynamic> data) {
    return Restaurante(
      idRestaurante: data['idRestaurante'] ?? '',
      razonSocial: data['razonSocial'] ?? '',
      nit: data['nit'] ?? '',
      direccion: data['direccion'] ?? '',
      telefono: data['telefono'] ?? '',
      urlImagen: data['urlImagen'] ?? '',
      idGerente: data['idGerente'] ?? '',
    );
  }
}