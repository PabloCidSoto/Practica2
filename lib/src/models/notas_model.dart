class NotasModel {
  int? id;
  String? titulo;
  String? detalle;

  NotasModel({this.id, this.titulo, this.detalle});
  
  // map -> object
  factory NotasModel.fromJson(Map<String, dynamic> json) => NotasModel(
      id: json['id'], 
      titulo: json['titulo'], 
      detalle: json['detalle']
  );

  //object -> map
  Map<String, dynamic> toJson() => {
        'id': id,
        'titulo': titulo,
        'detalle': detalle
  };
}
