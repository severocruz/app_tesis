import 'package:equatable/equatable.dart';
// import 'package:tomatebnb/models/accommodation/describe_response_model.dart';

abstract class RecorderState extends Equatable {
  @override
  List<Object> get props => [];
}
class RecorderInitialState extends RecorderState {}

/// Estado durante la grabación
class RecorderRecordingState extends RecorderState {
  final Duration duration;
  RecorderRecordingState({this.duration = Duration.zero});
   @override
  List<Object> get props => [duration];
}

/// Estado cuando la grabación se ha detenido
class RecorderStoppedState extends RecorderState {
  final String path;
  RecorderStoppedState(this.path);
   @override
  List<Object> get props => [path];
}

/// Estado de error
class RecorderErrorState extends RecorderState {
  final String message;
  RecorderErrorState(this.message);

  @override
  List<Object> get props => [message];
}

/// Estado durante la reproducción
class PlayingState extends RecorderState {
  final String path;
  PlayingState(this.path);

  @override
  List<Object> get props => [path];
}

/// Estado cuando la reproducción se ha detenido
class StoppedPlayingState extends RecorderState {}
// class DescribeGetError extends DescribeState {
//   final String message;
//   DescribeGetError(
//     this.message
//   );
//   @override
//   List<Object> get props => [message];
// }