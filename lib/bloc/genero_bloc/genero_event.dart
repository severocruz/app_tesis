import 'package:equatable/equatable.dart';

abstract class GeneroEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// obtener genero por nombre
class GetGeneroByNameEvent extends GeneroEvent {
  final String name;
  GetGeneroByNameEvent(this.name);
  @override
  List<Object?> get props => [name];
}
