import 'package:equatable/equatable.dart';

abstract class InstrumentoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// obtener instumentos musicales por género
class GetInstrumentosByGeneroEvent extends InstrumentoEvent {
  final int generoId;

  GetInstrumentosByGeneroEvent(this.generoId);

  @override
  List<Object?> get props => [generoId];
}
