// To parse this JSON data, do
//
//     final instrumentoModel = instrumentoModelFromJson(jsonString);

import 'dart:convert';

class InstrumentosModel {
  List<InstrumentoModel> items = [];
  InstrumentosModel();
  InstrumentosModel.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final describeResponse = InstrumentoModel.fromJson(item);
        items.add(describeResponse);
      } 
    }
  }
}

InstrumentoModel instrumentoModelFromJson(String str) => InstrumentoModel.fromJson(json.decode(str));

String instrumentoModelToJson(InstrumentoModel data) => json.encode(data.toJson());

class InstrumentoModel {
    String? nombre;
    String? tipo;
    String? descripcion;
    String? imagen;
    int? idGenero;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? id;

    InstrumentoModel({
        this.nombre,
        this.tipo,
        this.descripcion,
        this.imagen,
        this.idGenero,
        this.createdAt,
        this.updatedAt,
        this.id,
    });

    factory InstrumentoModel.fromJson(Map<String, dynamic> json) => InstrumentoModel(
        nombre: json["nombre"],
        tipo: json["tipo"],
        descripcion: json["descripcion"],
        imagen: json["imagen"],
        idGenero: json["id_genero"],
        createdAt: DateTime.parse(json["created_at"]??'2000-01-01'),
        updatedAt: DateTime.parse(json["updated_at"]??'2000-01-01'),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "tipo": tipo,
        "descripcion": descripcion,
        "imagen": imagen,
        "id_genero": idGenero,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "id": id,
    };
}
