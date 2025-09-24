import 'package:equatable/equatable.dart';

abstract class CaracteristicaEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// obtener características por género
class GetCaracteristicasByGeneroEvent extends CaracteristicaEvent {
  final int generoId;

  GetCaracteristicasByGeneroEvent(this.generoId);

  @override
  List<Object?> get props => [generoId];
}
