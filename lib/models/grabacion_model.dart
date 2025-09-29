// To parse this JSON data, do
//
//     final GrabacionModel = GrabacionModelFromJson(jsonString);

import 'dart:convert';
// Removed 'dart:ffi' as it is unnecessary for this use case.

class GrabacionsModel {
  List<GrabacionModel> items = [];
  GrabacionsModel();
  GrabacionsModel.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final describeResponse = GrabacionModel.fromJson(item);
        items.add(describeResponse);
      } 
    }
  }
}

GrabacionModel grabacionModelFromJson(String str) => GrabacionModel.fromJson(json.decode(str));

String grabacionModelToJson(GrabacionModel data) => json.encode(data.toJson());

class GrabacionModel {
    int? id;
    String? nombre;
    String? path;
    DateTime? fecha;
    
    GrabacionModel({
         this.id,
         this.nombre,
         this.path,
         this.fecha,
    });

    factory GrabacionModel.fromJson(Map<String, dynamic> json) => GrabacionModel(    
         id: json["id"]??0,
         nombre: json["nombre"]??'',
         path: json["path"]??'',
         fecha: DateTime.parse(json["fecha"]??'2000-01-01')
    );

    Map<String, dynamic> toJson() => {
         "id": id,
         "nombre": nombre,
         "path": path,
         "updated_at": fecha?.toIso8601String(),
    };

     /// Convierte el modelo a un Map para insertar en SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'path': path,
      'fecha': fecha?.toIso8601String(),
    };
  }

  /// Crea el modelo a partir del Map devuelto por SQLite
  factory GrabacionModel.fromMap(Map<String, dynamic> map) {
    return GrabacionModel(
      id: map['id'] as int?,
      nombre: map['nombre'] as String,
      path: map['path'] as String,
      fecha: DateTime.parse(map['fecha'] as String),
    );
  }

}
