import 'package:equatable/equatable.dart';

abstract class UbicacionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// obtener características por género
class GetUbicacionesByGeneroEvent extends UbicacionEvent {
  final int generoId;

  GetUbicacionesByGeneroEvent(this.generoId);

  @override
  List<Object?> get props => [generoId];
}
