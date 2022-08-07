class carrera {
  final String id;
  final String usuario;
  final String direccion;
  final String encargado;
  final bool activo;
  final double precio;

  carrera(
      {required this.id,
      required this.encargado,
      required this.usuario,
      required this.direccion,
      required this.activo,
      required this.precio});

  Map<String, Object> toJson() {
    return {
      "id":id,
      "encargado": encargado,
      "usuario": usuario,
      "direccion": direccion,
      "activo": activo,
      "precio": precio
    };
  }

  static carrera fromJson(Map<String, Object> json) {
    return carrera(
        id: json["id"] as String,
        encargado: json["encargado"] as String,
        usuario: json["usuario"] as String,
        direccion: json["direccion"] as String,
        activo: json["activo"] as bool,
        precio: json["precio"] as double
        );
  }
}
