import 'package:app_tesis/models/genero_model.dart';
import 'package:equatable/equatable.dart';
// import 'package:tomatebnb/models/accommodation/describe_response_model.dart';


abstract class GeneroState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Estado inicial
class GeneroInitialState extends GeneroState {}
/// Estado de carga
class GeneroLoadingState extends GeneroState {}

/// Estado cuando la obtencion de Genero es exitosa
class GetGeneroByNameSuccessState extends GeneroState {
  final GeneroModel genero;
  GetGeneroByNameSuccessState(this.genero);
  @override
  List<Object> get props => [genero];
}

/// Estado cuando la obtencion de Genero  falla

class GetGeneroByNameFailureState extends GeneroState {
  final String message;
  GetGeneroByNameFailureState(this.message);
  @override
  List<Object?> get props => [message];
}