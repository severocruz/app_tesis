import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_tesis/config/constants/environment.dart';
import 'package:app_tesis/models/genero_model.dart';
import 'package:app_tesis/models/response/api_response.dart';

class GeneroRepository {
  final String _baseUrl = Environment.UrlApi;

Future<void> setGeneroData(GeneroModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', user.id!);
    await prefs.setString('nombre', user.nombre!);
    await prefs.setString('nombrePrediccion', user.nombrePrediccion!);
    await prefs.setString('imagen', user.imagen??"");
    await prefs.setString('videoLink', user.videoLink??"");
  }


Future<ApiResponse<GeneroModel>> predecirGenero(File file) async {
  try{
    var request = http.MultipartRequest('POST', Uri.parse('$_baseUrl/predict_audio'));
    
    // request.headers['Authorization'] = 'Bearer $token';
    request.headers['Accept'] = 'application/json';
    // request.fields['column'] = column;
    // request.files.add(http.MultipartFile.fromPath('file',file.path, contentType: MediaType('audio', 'wav')));
     // Adjuntar archivo de audio
      request.files.add(await http.MultipartFile.fromPath(
        'file',       // <-- nombre del campo esperado en la API
        file.path,
        contentType: MediaType('audio', 'wav'),
      ));

    final response = await request.send();

    if (response.statusCode == 200) {
      final data = json.decode((await http.Response.fromStream(response)).body); 
      return ApiResponse<GeneroModel>(
        status: true,
        message: data['nombre'],
        data: GeneroModel.fromJson(data),
      ); 
    } else {
      final data = json.decode((await http.Response.fromStream(response)).body); 
      return ApiResponse<GeneroModel>(
        status: false,
        message: data['detail'].toString()
        
      ); 
    }
  } catch (e) {
    return ApiResponse<GeneroModel>(
      status: false, 
      message: e.toString()
    );
  }
}

}