import 'package:app_tesis/repository/caracteristica_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_tesis/bloc/export_blocs.dart';

class CaracteristicaBloc extends Bloc<CaracteristicaEvent, CaracteristicaState> {
  final CaracteristicaRepository caracteristicaRepository;

  CaracteristicaBloc(this.caracteristicaRepository) : super(CaracteristicaInitialState()) {
    on<GetCaracteristicasByGeneroEvent>(_onGetCaracteristicaByGenero);
  }

  Future<void> _onGetCaracteristicaByGenero(
      GetCaracteristicasByGeneroEvent event, Emitter<CaracteristicaState> emit) async {
    emit(CaracteristicaLoadingState());
    try{
      final response = await caracteristicaRepository.getByGenero(event.generoId);
      if(response.status){
        //await DescribeRepository.setUserData(response.data!);
        emit(GetCaracteristicasByGeneroSuccessState(response.data!));
      } else {
        emit(GetCaracteristicasByGeneroFailureState(response.message));
      }
    } catch(e){
      emit(GetCaracteristicasByGeneroFailureState(e.toString()));
    }
    
  }
}
