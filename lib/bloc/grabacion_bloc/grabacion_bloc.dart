import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_tesis/models/grabacion_model.dart';
import 'package:app_tesis/services/db_service.dart';
import 'package:app_tesis/services/audio_service.dart';
import 'package:app_tesis/bloc/export_blocs.dart';
class GrabacionBloc extends Bloc<GrabacionEvent, GrabacionState> {
  final AudioService _audioService = AudioService();

  GrabacionBloc() : super(GrabacionInitialState()) {
    on<LoadGrabacionesEvent>(_onLoadGrabaciones);
    on<AddGrabacionEvent>(_onAddGrabacion);
    on<PlayGrabacionEvent>(_onPlayGrabacion);
    on<DeleteGrabacionEvent>(_onDeleteGrabacion);
    on<StopGrabacionEvent>(_onStopPlaying);
  }

  Future<void> _onLoadGrabaciones(
      LoadGrabacionesEvent event, Emitter<GrabacionState> emit) async {
    emit(GrabacionLoadingState());
    try {
      final grabaciones = await DBService.getGrabaciones();
      emit(GrabacionesListadaState(grabaciones));
    } catch (e) {
      emit(GrabacionErrorState(e.toString()));
    }
  }

  Future<void> _onAddGrabacion(
      AddGrabacionEvent event, Emitter<GrabacionState> emit) async {
    final grabacion = GrabacionModel(
      nombre: event.nombre,
      path: event.path,
      fecha: DateTime.now(),
    );
    await DBService.insertGrabacion(grabacion);
    add(LoadGrabacionesEvent());
  }

  Future<void> _onPlayGrabacion(
      PlayGrabacionEvent event, Emitter<GrabacionState> emit) async {
    await _audioService.play(event.path);
    emit(GrabacionPlayingState(event.path));
  }

  Future<void> _onStopPlaying(
      StopGrabacionEvent event, Emitter<GrabacionState> emit) async {
     await _audioService.stop(); // detiene la reproducción
    //  emit(GrabacionStoppedState());   // opcional: para actualizar UI
    //  playingPath = null;  
  }

  Future<void> _onDeleteGrabacion(
      DeleteGrabacionEvent event, Emitter<GrabacionState> emit) async {
    await DBService.deleteGrabacion(event.id);
    add(LoadGrabacionesEvent());
  }
}
