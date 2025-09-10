import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_tesis/bloc/export_blocs.dart';
// import 'package:tomatebnb/repository/describe_repository.dart';

class DescribeBloc extends Bloc<DescribeEvent, DescribeState> {
  // final DescribeRepository describeRepository;

  DescribeBloc() : super(DescribeInitial()){
    on<DescribeGetEvent>(_onDescribeGet);
  }

  Future<void> _onDescribeGet(DescribeGetEvent event, Emitter<DescribeState> emit) async {
    emit(DescribeGetLoading());
    try{
      final response = true;
      if(response){
        //await DescribeRepository.setUserData(response.data!);
        emit(DescribeGetSuccess(response));
      } else {
        emit(DescribeGetError('false error'));
      }
    } catch(e){
      emit(DescribeGetError(e.toString()));
    }
  }
}