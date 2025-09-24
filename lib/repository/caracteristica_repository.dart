
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:app_tesis/config/constants/environment.dart';
import 'package:app_tesis/models/caracteristica_model.dart';
import 'package:app_tesis/models/response/api_response_list.dart' as api_response_list;


class CaracteristicaRepository {
  // Implementação do repositório de características
   final String _baseUrl = Environment.UrlApi;

  Future<api_response_list.ApiResponse<CaracteristicaModel>> getByGenero(int generoId) async {
    try{
      
      final response = await http.get(
        Uri.parse('$_baseUrl/generos/$generoId/caracteristicas'),
        headers: <String, String>{
          'Content-Service': 'application/json',
          'Accept' : 'application/json'
        }
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body); 
        return api_response_list.ApiResponse<CaracteristicaModel>(
          status: true,
          message: data['nombre'],
          data: CaracteristicasModel.fromJsonList(data['data']).items,
        ); 
      } else {
        // final data = json.decode(response.body); 
        return api_response_list.ApiResponse<CaracteristicaModel>(
          status: false,
          message: 'no se pudo obtener las características'
        ); 
      }
    } catch (e) {
      return api_response_list.ApiResponse<CaracteristicaModel>(
        status: false, 
        message: e.toString()
      );
    }
  }

}