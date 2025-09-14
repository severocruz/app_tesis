
import 'package:equatable/equatable.dart';
abstract class RecorderEvent extends Equatable {
  const RecorderEvent();
  @override
  List<Object?> get props => [];
}

/// Iniciar grabación
class StartRecorderEvent extends RecorderEvent {
  const StartRecorderEvent();
  // @override
  // List<Object?> get props => [];
}

/// Detener grabación
class StopRecorderEvent extends RecorderEvent {
  // final String path;
   const StopRecorderEvent();
  @override
   List<Object> get props => [];
}

/// Reproducir última grabación
class PlayRecordingEvent extends RecorderEvent {}

/// Detener reproducción
class StopPlayingEvent extends RecorderEvent {}

/// Evento de tick para actualizar la duración
class TickEvent extends RecorderEvent {}