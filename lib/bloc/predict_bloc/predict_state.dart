import 'package:app_tesis/models/genero_model.dart';
import 'package:equatable/equatable.dart';
// import 'package:tomatebnb/models/accommodation/describe_response_model.dart';


abstract class PredictState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Estado inicial
class PredictInitialState extends PredictState {}
/// Estado de carga
class PredictLoadingState extends PredictState {}

/// Estado cuando la predicción es exitosa
class PredictSuccessState extends PredictState {
  final GeneroModel genero;
  PredictSuccessState(this.genero);
  @override
  List<Object?> get props => [genero];
}

/// Estado cuando la predicción falla

class PredictFailureState extends PredictState {
  final String message;
  PredictFailureState(this.message);
  @override
  List<Object?> get props => [message];
}