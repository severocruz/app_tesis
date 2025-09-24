import 'package:app_tesis/models/caracteristica_model.dart';
import 'package:equatable/equatable.dart';
// import 'package:tomatebnb/models/accommodation/describe_response_model.dart';


abstract class CaracteristicaState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Estado inicial
class CaracteristicaInitialState extends CaracteristicaState {}
/// Estado de carga
class CaracteristicaLoadingState extends CaracteristicaState {}

/// Estado cuando la obtencion de caracteristica es exitosa
class GetCaracteristicasByGeneroSuccessState extends CaracteristicaState {
  final List<CaracteristicaModel> caracteristicas;
  GetCaracteristicasByGeneroSuccessState(this.caracteristicas);
  @override
  List<Object?> get props => [caracteristicas];
}

/// Estado cuando la obtencion de caracteristica  falla

class GetCaracteristicasByGeneroFailureState extends CaracteristicaState {
  final String message;
  GetCaracteristicasByGeneroFailureState(this.message);
  @override
  List<Object?> get props => [message];
}