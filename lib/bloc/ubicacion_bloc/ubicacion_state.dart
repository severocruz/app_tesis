import 'package:app_tesis/models/ubicacion_model.dart';
import 'package:equatable/equatable.dart';
// import 'package:tomatebnb/models/accommodation/describe_response_model.dart';


abstract class UbicacionState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Estado inicial
class UbicacionInitialState extends UbicacionState {}
/// Estado de carga
class UbicacionLoadingState extends UbicacionState {}

/// Estado cuando la obtencion de Ubicacion es exitosa
class GetUbicacionesByGeneroSuccessState extends UbicacionState {
  final List<UbicacionModel> ubicaciones;
  GetUbicacionesByGeneroSuccessState(this.ubicaciones);
  @override
  List<Object?> get props => [ubicaciones];
}

/// Estado cuando la obtencion de Ubicacion  falla

class GetUbicacionesByGeneroFailureState extends UbicacionState {
  final String message;
  GetUbicacionesByGeneroFailureState(this.message);
  @override
  List<Object?> get props => [message];
}