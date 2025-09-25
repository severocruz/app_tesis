// To parse this JSON data, do
//
//     final ubicacionModel = ubicacionModelFromJson(jsonString);

import 'dart:convert';

class UbicacionesModel {
  List<UbicacionModel> items = [];
  UbicacionesModel();
  UbicacionesModel.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final describeResponse = UbicacionModel.fromJson(item);
        items.add(describeResponse);
      } 
    }
  }
}

UbicacionModel ubicacionModelFromJson(String str) => UbicacionModel.fromJson(json.decode(str));

String ubicacionModelToJson(UbicacionModel data) => json.encode(data.toJson());

class UbicacionModel {
    String? nombre;
    String? descripcion;
    double? latitud;
    double? longitud;
    String? imagen;
    int? idGenero;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? id;

    UbicacionModel({
        this.nombre,
        this.descripcion,
        this.latitud,
        this.longitud,
        this.imagen,
        this.idGenero,
        this.createdAt,
        this.updatedAt,
        this.id,
    });

    factory UbicacionModel.fromJson(Map<String, dynamic> json) => UbicacionModel(
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        latitud: double.parse((json["latitud"]??0).toString()),
        longitud:double.parse((json["longitud"]??0).toString()) ,
        imagen: json["imagen"],
        idGenero: json["id_genero"],
        createdAt: DateTime.parse(json["created_at"]??'2000-01-01'),
        updatedAt: DateTime.parse(json["updated_at"]??'2000-01-01'),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "descripcion": descripcion,
        "latitud": latitud,
        "longitud": longitud,
        "imagen": imagen,
        "id_genero": idGenero,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "id": id,
    };
}
