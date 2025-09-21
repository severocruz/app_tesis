import 'package:app_tesis/repository/genero_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_tesis/bloc/export_blocs.dart';

class PredictBloc extends Bloc<PredictEvent, PredictState> {
  final GeneroRepository generoRepository;

  PredictBloc(this.generoRepository) : super(PredictInitialState()) {
    on<PredictingEvent>(_onPredict);
  }

  Future<void> _onPredict(
      PredictingEvent event, Emitter<PredictState> emit) async {
    emit(PredictLoadingState());

    final response = await generoRepository.predecirGenero(event.audioFile);

    if (response.status) {
      emit(PredictSuccessState(response.data!));
    } else {
      emit(PredictFailureState(response.message));
    }
  }
}
