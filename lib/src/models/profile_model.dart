class ProfileModel {
  int? id;
  String? nombre;
  String? apaterno;
  String? amaterno;
  String? telefono;
  String? email;
  String? image;

  ProfileModel({
    this.id,
    this.nombre,
    this.apaterno,
    this.amaterno,
    this.telefono,
    this.email,
    this.image
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    id: json['id'],
    nombre: json['nombre'],
    apaterno: json['apaterno'],
    amaterno: json['amaterno'],
    telefono: json['telefono'],
    email: json['email'],
    image: json['image']
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': nombre,
    'apaterno': apaterno,
    'amaterno': amaterno,
    'telefono': telefono,
    'email': email,
    'image': image
  };

  
}