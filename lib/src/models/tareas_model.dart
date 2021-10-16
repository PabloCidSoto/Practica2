class TareasModel {
  int? id;
  String? nombreTarea;
  String? descTarea;
  String? fechaEntrega;
  int? entregada;

  TareasModel({
    this.id,
    this.nombreTarea,
    this.descTarea,
    this.fechaEntrega,
    this.entregada
  });

  factory TareasModel.fromJson(Map<String, dynamic> json) => TareasModel(
    id: json['id'],
    nombreTarea: json['nombreTarea'],
    descTarea: json['descTarea'],
    fechaEntrega: json['fechaEntrega'],
    entregada: json['entregada']
  );

  Map<String, dynamic> toJson() =>{
    'id': id,
    'nombreTarea': nombreTarea,
    'descTarea': descTarea,
    'fechaEntrega': fechaEntrega,
    'entregada': entregada,
  };
}