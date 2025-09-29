
import 'package:equatable/equatable.dart';
abstract class GrabacionEvent extends Equatable {
  const GrabacionEvent();
  @override
  List<Object?> get props => [];
}

class LoadGrabacionesEvent extends GrabacionEvent {}

class AddGrabacionEvent extends GrabacionEvent {
  final String nombre;
  final String path;

  const AddGrabacionEvent({required this.nombre, required this.path});

  @override
  List<Object?> get props => [nombre, path];
}

class PlayGrabacionEvent extends GrabacionEvent {
  final String path;

 const PlayGrabacionEvent(this.path);

  @override
  List<Object?> get props => [path];
}

// grabacion_event.dart stop event
class StopGrabacionEvent extends GrabacionEvent {}

class DeleteGrabacionEvent extends GrabacionEvent {
  final int id;

 const DeleteGrabacionEvent(this.id);

  @override
  List<Object?> get props => [id];
}
