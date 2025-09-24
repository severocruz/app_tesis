import 'package:app_tesis/models/Instrumento_model.dart';
import 'package:equatable/equatable.dart';
// import 'package:tomatebnb/models/accommodation/describe_response_model.dart';


abstract class InstrumentoState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Estado inicial
class InstrumentoInitialState extends InstrumentoState {}
/// Estado de carga
class InstrumentoLoadingState extends InstrumentoState {}

/// Estado cuando la obtencion de Instrumento es exitosa
class GetInstrumentosByGeneroSuccessState extends InstrumentoState {
  final List<InstrumentoModel> instrumentos;
  GetInstrumentosByGeneroSuccessState(this.instrumentos);
  @override
  List<Object?> get props => [instrumentos];
}

/// Estado cuando la obtencion de Instrumento  falla

class GetInstrumentosByGeneroFailureState extends InstrumentoState {
  final String message;
  GetInstrumentosByGeneroFailureState(this.message);
  @override
  List<Object?> get props => [message];
}