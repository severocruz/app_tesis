import 'package:app_tesis/models/grabacion_model.dart';
import 'package:equatable/equatable.dart';
// import 'package:tomatebnb/models/accommodation/describe_response_model.dart';

abstract class GrabacionState extends Equatable {
  @override
  List<Object> get props => [];
}

class GrabacionInitialState extends GrabacionState {}

class GrabacionLoadingState extends GrabacionState {}


/// Estado grabaciones listadas
class GrabacionesListadaState extends GrabacionState {
  final List<GrabacionModel> grabaciones;

  GrabacionesListadaState(this.grabaciones);

  @override
  List<Object> get props => [grabaciones];
}



/// Estado de error
class GrabacionErrorState extends GrabacionState {
  final String message;
  GrabacionErrorState(this.message);

  @override
  List<Object> get props => [message];
}

/// Estado durante la reproducción
class GrabacionPlayingState extends GrabacionState {
  final String path;

  GrabacionPlayingState(this.path);

  @override
  List<Object> get props => [path];
}

// estado cuando la grabación se detiene
class GrabacionStoppedState extends GrabacionState {}