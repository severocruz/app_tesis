import 'package:app_tesis/repository/instrumento_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_tesis/bloc/export_blocs.dart';

class InstrumentoBloc extends Bloc<InstrumentoEvent, InstrumentoState> {
  final InstrumentoRepository instrumentoRepository;

  InstrumentoBloc(this.instrumentoRepository) : super(InstrumentoInitialState()) {
    on<GetInstrumentosByGeneroEvent>(_onGetInstrumentoByGenero);
  }

  Future<void> _onGetInstrumentoByGenero(
      GetInstrumentosByGeneroEvent event, Emitter<InstrumentoState> emit) async {
    emit(InstrumentoLoadingState());
    try{
      final response = await instrumentoRepository.getByGenero(event.generoId);
      if(response.status){
        //await DescribeRepository.setUserData(response.data!);
        emit(GetInstrumentosByGeneroSuccessState(response.data!));
      } else {
        emit(GetInstrumentosByGeneroFailureState(response.message));
      }
    } catch(e){
      emit(GetInstrumentosByGeneroFailureState(e.toString()));
    }
    
  }
}
