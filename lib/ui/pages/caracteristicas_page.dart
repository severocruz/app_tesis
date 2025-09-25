import 'package:app_tesis/bloc/caracteristica_bloc/caracteristica_bloc.dart';
import 'package:app_tesis/bloc/caracteristica_bloc/caracteristica_event.dart';
import 'package:app_tesis/bloc/caracteristica_bloc/caracteristica_state.dart';
import 'package:app_tesis/models/genero_model.dart';
import 'package:app_tesis/ui/widgets/caracteristica_card.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
class CaracteristicasPage extends StatefulWidget {
  final GeneroModel genero;
  const CaracteristicasPage({super.key, required this.genero});

  @override
  State<CaracteristicasPage> createState() => _CaracteristicasPageState();
}

class _CaracteristicasPageState extends State<CaracteristicasPage> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CaracteristicaBloc>();
    bloc.add(GetCaracteristicasByGeneroEvent(widget.genero.id!));
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.genero.nombre??"Desconocido"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          BlocBuilder<CaracteristicaBloc, CaracteristicaState>(
            builder: (context, state) {
              if (state is CaracteristicaLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetCaracteristicasByGeneroSuccessState) {
                return Expanded(
                  child: ListView.builder(
                  itemCount: state.caracteristicas.length,
                  padding: const EdgeInsets.all(12),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: CaracteristicaCard(caracteristica: state.caracteristicas[index]),
                    );
                  },
                                ),
                );
              } else if (state is GetCaracteristicasByGeneroFailureState) {
                return Center(child: Text("Error: ${state.message}"));
              }
              return const Center(child: Text("Esperando datos..."));
            },
          ),
          const SizedBox(height: 12,width: double.infinity,),
            ElevatedButton.icon(
                                  onPressed: (){
                                     context.push('/instruments', extra: widget.genero);
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: Theme.of(context).colorScheme.primary  , width: 2), // contorno
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30), // bordes redondeados
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                                  ),
                                  icon: const Icon(EvaIcons.music, color: Colors.purple, size: 32),
                                  iconAlignment: IconAlignment.end,
                                  label: Text("Conoce sus instrumentos Musicales ", style: const TextStyle(fontSize: 16),)
                                ),
        ],
      ),
      
    );
  }
}