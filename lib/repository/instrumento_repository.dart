
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_tesis/config/constants/environment.dart';
import 'package:app_tesis/models/Instrumento_model.dart';
import 'package:app_tesis/models/response/api_response_list.dart' as api_response_list;

class InstrumentoRepository {
  // Implementação do repositório de características
   final String _baseUrl = Environment.UrlApi;

  Future<api_response_list.ApiResponse<InstrumentoModel>> getByGenero(int generoId) async {
    try{
      
      final response = await http.get(
        Uri.parse('$_baseUrl/generos/$generoId/instrumentos'),
        headers: <String, String>{
          'Content-Service': 'application/json',
          'Accept' : 'application/json'
        }
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body); 
        return api_response_list.ApiResponse<InstrumentoModel>(
          status: true,
          message: 'Instrumentos obtenidos con éxito',
          data: InstrumentosModel.fromJsonList(data).items,
        ); 
      } else {
        // final data = json.decode(response.body); 
        return api_response_list.ApiResponse<InstrumentoModel>(
          status: false,
          message: 'no se pudo obtener los instrumentos'
        ); 
      }
    } catch (e) {
      return api_response_list.ApiResponse<InstrumentoModel>(
        status: false, 
        message: e.toString()
      );
    }
  }

}