import 'package:equatable/equatable.dart';
import 'dart:io';

abstract class PredictEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Cuando el usuario decide subir el audio grabado
class PredictingEvent extends PredictEvent {
  final File audioFile;

  PredictingEvent(this.audioFile);

  @override
  List<Object?> get props => [audioFile];
}
