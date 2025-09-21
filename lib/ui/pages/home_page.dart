import 'dart:io';

import 'package:app_tesis/provider/color_notifire.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_tesis/bloc/export_blocs.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }
  String _duracionText = "00:00";
  File _file = File('');
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
            title: const Text("Mi App"),
            actions: [
              Consumer<ColorNotifire>(
                builder: (context, colorNotifire, _) {
                  return Switch(
                    value: colorNotifire.isDark,
                    onChanged: (value) {
                      colorNotifire.toggleTheme();
                    },
                  );
                },
              ),
            ],
          ), 
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity),

          // BlocConsumer<RecorderBloc, RecorderState>(
          //   listener: (context,state){}, 
          //   builder: (context, state) {
          //      if (state is RecorderRecordingState) {
          //       return ElevatedButton(
          //         onPressed: () => context.read<RecorderBloc>().add(StopRecorderEvent()),
          //         child: Column(
          //           children: [
          //             Icon(EvaIcons.mic, color: Colors.red, size: 64),
          //             Text("Grabando... ${state.duration.inSeconds}s"),
          //           ],
          //         ),
          //       );
          //     }
          //      return ElevatedButton(
          //       onPressed: () => context.read<RecorderBloc>().add(StartRecorderEvent()),
          //       child: const Text("Grabar"),
          //     );
          //   }  
          // ),
          const SizedBox(height: 20),
          BlocConsumer<RecorderBloc, RecorderState>(
            listener: (context,state){
              if(state is RecorderStoppedState){
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(content: Text('Grabación guardada en: ${state.path}')),
                // );
                setState(() {
                  _file = File(state.path);
                  
                });
              }
            }, 
            builder: (context, state) {
              final bloc = context.read<RecorderBloc>();
              String durationText = "00:00";
              bool isRecording = false;
              bool isPlaying = false;
      
              if (state is RecorderRecordingState) {
                isRecording = true;
                durationText = _formatDuration(state.duration);
                _duracionText = durationText;
              } else if (state is PlayingState) {
                isPlaying = true;
              } else if (state is RecorderStoppedState) {
                 durationText = "00:00";
              }     
               return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text(
            durationText=="00:00"
            ?_duracionText
            :durationText,
            style: const TextStyle(fontSize: 28),
          ),
          const SizedBox(height: 50),
          !isRecording 
             ?OutlinedButton(
                onPressed: isRecording
                    ? null
                    : () => bloc.add(StartRecorderEvent()),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Theme.of(context).colorScheme.primary  , width: 2), // contorno
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(150), // bordes redondeados
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
                child: Column(
                    children: [
                      Icon(EvaIcons.mic, color: Colors.green, size: 200),
                      Text("Grabar"),
                    ],
                  ),
              )
              : OutlinedButton(
                onPressed: isRecording
                    ? () => bloc.add(StopRecorderEvent())
                    : null,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Theme.of(context).colorScheme.primary  , width: 2), // contorno
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(150), // bordes redondeados
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
                child: Column(
                    children: [
                      Icon(Icons.stop, color: Colors.red, size: 200),
                      Text("Detener"),
                    ],
                  ),
                
              ),
              const SizedBox(height: 50),
          !isPlaying
              ?ElevatedButton.icon(
                onPressed: (!isRecording && !isPlaying)
                    ? () => bloc.add(PlayRecordingEvent())
                    : null,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Theme.of(context).colorScheme.primary  , width: 2), // contorno
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // bordes redondeados
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                ),
                icon: const Icon(Icons.play_arrow, color: Colors.blue, size: 52),
                label: const Text("Reproducir"),
              )
              :ElevatedButton.icon(
                onPressed: isPlaying
                    ? () => bloc.add(StopPlayingEvent())
                    : null,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Theme.of(context).colorScheme.primary  , width: 2), // contorno
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // bordes redondeados
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                ),
                icon: const Icon(Icons.stop, color: Colors.red, size: 52),
                label: const Text("Detener"),
              )
              ,
          
          const SizedBox(height: 24),
          if (state is RecorderErrorState)
            Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
        ],
      );
            }  
          ),
          BlocConsumer<PredictBloc, PredictState>(
            listener: (context,state){
              if(state is PredictSuccessState){
                  context.push('/showGender', extra: state.genero);
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(content: Text('Predicción: ${state.genero.nombre}')),
                // );
              } else if(state is PredictFailureState){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.message}'),backgroundColor: Theme.of(context).colorScheme.error,),
                );
              }
            }, 
            builder: (context, state) {
              final bloc = context.read<PredictBloc>();
               return ElevatedButton.icon(
                onPressed: (state is PredictLoadingState || _file.path.isEmpty)
                    ? null
                    : () => bloc.add(PredictingEvent(_file)),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Theme.of(context).colorScheme.primary  , width: 2), // contorno
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // bordes redondeados
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                ),
                icon: const Icon(Icons.analytics, color: Colors.purple, size: 32),
                label: state is PredictLoadingState
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text("Predecir Género"),
              );
            }  
          ),
        ],
      )
    );
  }
}