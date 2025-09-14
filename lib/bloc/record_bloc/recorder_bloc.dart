import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_tesis/bloc/export_blocs.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';

class RecorderBloc extends Bloc<RecorderEvent, RecorderState> {
  // final RecorderRepository RecorderRepository;
    final _recorder = AudioRecorder();
    Timer? _timer;
    Duration _duration = Duration.zero;
    String? _filePath;
    final AudioPlayer _audioPlayer = AudioPlayer();
  RecorderBloc() : super(RecorderInitialState()){
    on<StartRecorderEvent>(_onStartRecording);
    on<StopRecorderEvent>(_onStopRecording);
    on<PlayRecordingEvent>(_onPlayRecording);
    on<StopPlayingEvent>(_onStopPlaying);
    on<TickEvent>(_onTick);
  }

///evento de bloc para iniciar grabacion
  Future<void> _onStartRecording(StartRecorderEvent event, Emitter<RecorderState> emit) async {
    
    try{
      if (await _recorder.hasPermission()) {
        // Obtiene directorio interno de la app
        //final dir = await getApplicationDocumentsDirectory();
        final dir = await getExternalStorageDirectory(); //getApplicationDocumentsDirectory();
        _filePath =
            '${dir!.path}/grabacion_${DateTime.now().millisecondsSinceEpoch}.wav';

      const config = RecordConfig(
        encoder: AudioEncoder.wav, // WAV
        sampleRate: 44100,         // 44.1 kHz
        numChannels: 1,            // Mono
      );

      await _recorder.start(config, path: _filePath!);
      _duration = Duration.zero;
      _timer = Timer.periodic(const Duration(seconds: 1), (t) {
       add(TickEvent());
      // emit(RecorderRecordingState(duration: _duration));
    });
      // _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      //   _duration += Duration(seconds: 1);
      //   emit(RecorderRecordingState(duration: _duration));
      // });
      
      emit(RecorderRecordingState());
    } else {
      // Handle the case when permission is not granted
      emit(RecorderErrorState("Permisos de grabación no concedidos"));
    }
    } catch(e){
      emit(RecorderErrorState(e.toString()));
    } 
  }
///evento de bloc para detener grabacion
  Future<void> _onStopRecording(
      StopRecorderEvent event, Emitter<RecorderState> emit) async {
    try {
      final path = await _recorder.stop();
      _timer?.cancel();
      emit(RecorderStoppedState(path!));
    } catch (e) {
      emit(RecorderErrorState("Error al detener grabación: $e"));
    }
  }

  ///evento de bloc para reproducir grabacion
  // Future<void> _onPlayRecording(
  //     PlayRecordingEvent event, Emitter<RecorderState> emit) async {
  //   if (_filePath != null) {
  //     await _audioPlayer.play(DeviceFileSource(_filePath!));
  //     emit(PlayingState(_filePath!));
  //   }
  // }

  Future<void> _onPlayRecording(
      PlayRecordingEvent event, Emitter<RecorderState> emit) async {
    try {
      if (_filePath != null && File(_filePath!).existsSync()) {
        // Setea el archivo en el player
        await _audioPlayer.setFilePath(_filePath!);

        // Reproducir desde el inicio
        await _audioPlayer.seek(Duration.zero);
        await _audioPlayer.play();

        emit(PlayingState(_filePath!));

        // Espera hasta que termine la reproducción
    await _audioPlayer.processingStateStream
        .firstWhere((state) => state == ProcessingState.completed);
     // Emitir STOP solo después de que termine
    if (!emit.isDone) {
      emit(RecorderStoppedState( _filePath!));
    }
        // Cuando termina la reproducción, volvemos a stopped
        // _audioPlayer.playerStateStream.listen((state) {
        //   if (state.processingState == ProcessingState.completed) {
        //     emit(RecorderStoppedState(_filePath!));
        //   }
        // });
      } else {
        emit(RecorderErrorState("No hay grabación disponible"));
      }
    } catch (e) {
      emit(RecorderErrorState("Error reproduciendo: $e"));
    }
  }
  ///evento de bloc para detener reproduccion
  Future<void> _onStopPlaying(
      StopPlayingEvent event, Emitter<RecorderState> emit) async {
    await _audioPlayer.stop();
    emit(RecorderStoppedState( _filePath!));
    // emit(StoppedPlayingState());
  }

  void _onTick(TickEvent event, Emitter<RecorderState> emit) {
    _duration = Duration(seconds: _duration.inSeconds + 1);
    emit(RecorderRecordingState(duration: _duration));
  }

   // ------------------- CLEANUP -------------------
  @override
  Future<void> close() {
    _timer?.cancel();
    _audioPlayer.dispose();
    return super.close();
  }
}