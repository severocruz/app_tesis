// To parse this JSON data, do
//
//     final caracteristaModel = caracteristaModelFromJson(jsonString);

import 'dart:convert';

class CaracteristicasModel {
  List<CaracteristicaModel> items = [];
  CaracteristicasModel();
  CaracteristicasModel.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final describeResponse = CaracteristicaModel.fromJson(item);
        items.add(describeResponse);
      } 
    }
  }
}

CaracteristicaModel caracteristicaModelFromJson(String str) => CaracteristicaModel.fromJson(json.decode(str));

String caracteristicaModelToJson(CaracteristicaModel data) => json.encode(data.toJson());

class CaracteristicaModel {
    String? nombre;
    int? idGenero;
    String? descripcion;
    String? imagen;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? id;

    CaracteristicaModel({
         this.nombre,
         this.idGenero,
         this.descripcion,
         this.imagen,
         this.createdAt,
         this.updatedAt,
         this.id,
    });

    factory CaracteristicaModel.fromJson(Map<String, dynamic> json) => CaracteristicaModel(
        nombre: json["nombre"],
        idGenero: json["id_genero"],
        descripcion: json["descripcion"],
        imagen: json["imagen"],
        createdAt: DateTime.parse(json["created_at"]??'2000-01-01'),
        updatedAt: DateTime.parse(json["updated_at"]??'2000-01-01'),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "id_genero": idGenero,
        "descripcion": descripcion,
        "imagen": imagen,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "id": id,
    };
}
