import 'package:app_tesis/repository/ubicacion_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_tesis/bloc/export_blocs.dart';

class UbicacionBloc extends Bloc<UbicacionEvent, UbicacionState> {
  final UbicacionRepository ubicacionRepository;

  UbicacionBloc(this.ubicacionRepository) : super(UbicacionInitialState()) {
    on<GetUbicacionesByGeneroEvent>(_onGetUbicacionesByGenero);
  }

  Future<void> _onGetUbicacionesByGenero(
      GetUbicacionesByGeneroEvent event, Emitter<UbicacionState> emit) async {
    emit(UbicacionLoadingState());
    try{
      final response = await ubicacionRepository.getByGenero(event.generoId);
      if(response.status){
        //await DescribeRepository.setUserData(response.data!);
        emit(GetUbicacionesByGeneroSuccessState(response.data!));
      } else {
        emit(GetUbicacionesByGeneroFailureState(response.message));
      }
    } catch(e){
      emit(GetUbicacionesByGeneroFailureState(e.toString()));
    }
    
  }
}
