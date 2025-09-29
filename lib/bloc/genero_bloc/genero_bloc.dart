import 'package:app_tesis/repository/genero_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_tesis/bloc/export_blocs.dart';

class GeneroBloc extends Bloc<GeneroEvent, GeneroState> {
  final GeneroRepository generoRepository;

  GeneroBloc(this.generoRepository) : super(GeneroInitialState()) {
    on<GetGeneroByNameEvent>(_onGetGeneroByName);
  }

  Future<void> _onGetGeneroByName(
      GetGeneroByNameEvent event, Emitter<GeneroState> emit) async {
    emit(GeneroLoadingState());
    try{
      final response = await generoRepository.generoByNombre(event.name);
      if(response.status){
        //await DescribeRepository.setUserData(response.data!);
        emit(GetGeneroByNameSuccessState(response.data!));
      } else {
        emit(GetGeneroByNameFailureState(response.message));
      }
    } catch(e){
      emit(GetGeneroByNameFailureState(e.toString()));
    }
    
  }
}
