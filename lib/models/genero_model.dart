// To parse this JSON data, do
//
//     final GeneroModel = GeneroModelFromJson(jsonString);

import 'dart:convert';

class GenerosModel {
  List<GeneroModel> items = [];
  GenerosModel();
  GenerosModel.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final describeResponse = GeneroModel.fromJson(item);
        items.add(describeResponse);
      } 
    }
  }
}

GeneroModel generoModelFromJson(String str) => GeneroModel.fromJson(json.decode(str));

String generoModelToJson(GeneroModel data) => json.encode(data.toJson());

class GeneroModel {
    int? id;
    String? nombre;
    String? nombrePrediccion;
    String? descripcion;
    String? imagen;
    String? videoLink;
    DateTime? createdAt;
    DateTime? updatedAt;
    GeneroModel({
         this.id,
         this.nombre,
         this.nombrePrediccion,
         this.descripcion,
         this.imagen,
         this.videoLink,
         this.createdAt,
         this.updatedAt
    });

    factory GeneroModel.fromJson(Map<String, dynamic> json) => GeneroModel(    
         id: json["id"]??0,
         nombre: json["nombre"]??'',
         nombrePrediccion: json["nombre_prediccion"]??'',
         descripcion: json["descripcion"]??'',
         imagen: json["imagen"]??'',
         videoLink: json["video_link"]??'',
         createdAt: DateTime.parse(json["created_at"]??'2000-01-01'),
         updatedAt: DateTime.parse(json["updated_at"]??'2000-01-01'),
    );

    Map<String, dynamic> toJson() => {
         "id": id,
         "nombre": nombre,
         "nombrePrediccion": nombrePrediccion,
         "descripcion": descripcion,
         "imagen": imagen,
         "video_link": videoLink,
         "created_at": createdAt?.toIso8601String(),
         "updated_at": updatedAt?.toIso8601String(),
    };
}
