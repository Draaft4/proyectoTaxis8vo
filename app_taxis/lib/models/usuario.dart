class usuario {
  final String id;
  final String correo;
  final String nombre;
  final bool taxista;

  usuario({required this.id,required this.correo, required this.nombre, required this.taxista});

  Map<String, Object> toJson() {
    return {"correo": correo, "nombre": nombre, "taxista": taxista};
  }

  static usuario fromJson(Map<String, Object> json) {
    return usuario(
      id: json["id"] as String,
      correo: json["correo"] as String,
      nombre: json["nombre"] as String,
      taxista: json["taxista"] as bool
    );
  }
}