
import 'package:app_tesis/repository/caracteristica_repository.dart';
import 'package:app_tesis/repository/genero_repository.dart';
import 'package:app_tesis/repository/instrumento_repository.dart';
import 'package:app_tesis/repository/ubicacion_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tomatebnb/bloc/accommodation_type_bloc/accommodation_type_bloc.dart';
import 'package:app_tesis/bloc/export_blocs.dart';
import 'package:provider/single_child_widget.dart';
// import 'auth_bloc/auth_bloc.dart';
// import 'package:tomatebnb/bloc/accommodation_bloc/accommodation_bloc.dart';
// import 'package:tomatebnb/bloc/describe_bloc/describe_bloc.dart';

class Blocs {
  // Declaramos el bloc
   static final DescribeBloc describeBloc = DescribeBloc();
   static final RecorderBloc recorderBloc = RecorderBloc();
   static final PredictBloc predictBloc = PredictBloc(GeneroRepository());
   static final CaracteristicaBloc caracteristicaBloc = CaracteristicaBloc(CaracteristicaRepository());
   static final InstrumentoBloc instrumentoBloc = InstrumentoBloc(InstrumentoRepository());
   static final UbicacionBloc ubicacionBloc = UbicacionBloc(UbicacionRepository());

  // Lista de blocs Providers para proveer a toda la aplicación
  static final List<SingleChildWidget>blocsProviders = [

    BlocProvider<DescribeBloc>(create: (context) => describeBloc),
    BlocProvider<RecorderBloc>(create: (context) => recorderBloc),
    BlocProvider<PredictBloc>(create: (context) => predictBloc),
    BlocProvider<CaracteristicaBloc>(create: (context) => caracteristicaBloc),
    BlocProvider<InstrumentoBloc>(create: (context) => instrumentoBloc),
    BlocProvider<UbicacionBloc>(create: (context) => ubicacionBloc),
  ];

  // Metodos para cerrar el bloc cuando no se necesite
  static void dispose() {
    describeBloc.close();
    recorderBloc.close();
    predictBloc.close();
    caracteristicaBloc.close();
    instrumentoBloc.close();
    ubicacionBloc.close();
  }


  static final Blocs _instance = Blocs._internal();

  factory Blocs() {
    return _instance;
  }

  Blocs._internal();
}