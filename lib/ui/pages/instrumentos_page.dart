import 'package:app_tesis/bloc/intrumento_bloc/instrumento_bloc.dart';
import 'package:app_tesis/bloc/intrumento_bloc/instrumento_event.dart';
import 'package:app_tesis/bloc/intrumento_bloc/instrumento_state.dart';
import 'package:app_tesis/models/genero_model.dart';
import 'package:app_tesis/ui/widgets/instrumento_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class InstrumentosPage extends StatefulWidget {
  final GeneroModel genero;
  const InstrumentosPage({super.key, required this.genero});

  @override
  State<InstrumentosPage> createState() => _InstrumentosPageState();
}

class _InstrumentosPageState extends State<InstrumentosPage> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<InstrumentoBloc>();
    bloc.add(GetInstrumentosByGeneroEvent(widget.genero.id!));
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.genero.nombre??"Desconocido"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          BlocBuilder<InstrumentoBloc, InstrumentoState>(
            builder: (context, state) {
              if (state is InstrumentoLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetInstrumentosByGeneroSuccessState) {
                return Expanded(
                  child: ListView.builder(
                  itemCount: state.instrumentos.length,
                  padding: const EdgeInsets.all(12),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: InstrumentoCard(instrumento: state.instrumentos[index]),
                    );
                  },
                                ),
                );
              } else if (state is GetInstrumentosByGeneroFailureState) {
                return Center(child: Text("Error: ${state.message}"));
              }
              return const Center(child: Text("Esperando datos..."));
            },
          ),
          const SizedBox(height: 12,width: double.infinity,),
         
        ],
      ),
      
    );
  }
}