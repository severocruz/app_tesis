import 'package:app_tesis/bloc/export_blocs.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RecordsPage extends StatefulWidget {
  const RecordsPage({super.key});

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  String? playingPath; // ruta del audio que se está reproduciendo

  @override
  Widget build(BuildContext context) {
    context.read<GrabacionBloc>().add(LoadGrabacionesEvent());
    return Scaffold(
        appBar: AppBar(
          title: const Text('Historial de Grabaciones'),
        ),
        body: BlocConsumer<GrabacionBloc, GrabacionState>(
          listener: (context, state) {
            // Mostrar mensajes o manejar estados específicos
            if (state is GrabacionPlayingState ) {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(content: Text('Reproduciendo: ${state.}')),
              // );
              setState(() {
                
                playingPath = state.path;
              });
            }
          },
          builder: (context, state) {
            if (state is GrabacionLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is GrabacionesListadaState) {
              final grabaciones = state.grabaciones;
              if (grabaciones.isEmpty) {
                return const Center(child: Text("No hay grabaciones"));
              }
              return ListView.builder(
                itemCount: grabaciones.length,
                itemBuilder: (context, index) {
                  final grabacion = grabaciones[index];
                  var isPlaying = grabacion.path == playingPath;
                  return ListTile(
                    title: Text(grabacion.nombre ?? 'Sin nombre'),
                    // subtitle: Text(grabacion.path?? 'Sin ruta'),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    leading: IconButton(
                      icon:
                          const Icon(EvaIcons.trash2Outline, color: Colors.red),
                      onPressed: () {
                        // Eliminar la grabación
                        context
                            .read<GrabacionBloc>()
                            .add(DeleteGrabacionEvent(grabacion.id!));
                        if (isPlaying) {
                          setState(() {
                            playingPath = null;
                          });
                        }
                      },
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(isPlaying ? Icons.stop : Icons.play_arrow),
                          onPressed: () {
                            if (isPlaying) {
                              // Detener la reproducción
                              setState(() {
                                playingPath = null;
                                isPlaying = false;
                                // context
                                //     .read<GrabacionBloc>()
                                //     .add(StopGrabacionEvent());
                              });
                            } else {
                              // Reproducir la grabación
                              context
                                  .read<GrabacionBloc>()
                                  .add(PlayGrabacionEvent(grabacion.path!));
                            }
                          },
                        ),
                        BlocConsumer<GeneroBloc, GeneroState>(
                          listener: (context, state) {
                            
                            if (state is GetGeneroByNameSuccessState) {
                              context.push('/showGender',
                                  extra: state.genero);
                            }
                          },
                          builder: (context, state) {
                            if (state is GeneroLoadingState) {
                              return const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(),
                              );
                            }
                             if (state is GetGeneroByNameFailureState) {
                              return IconButton(
                                icon: const Icon(
                                  EvaIcons.alertCircleOutline,
                                  color: Colors.orange,
                                  size: 40.0,
                                ),
                                onPressed: () {
                                  // Eliminar la grabación
                                  // context.read<GrabacionBloc>().add(DeleteGrabacionEvent(grabacion.id!));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Error: ${state.message}")),
                                  );
                                },
                              );
                            }
                            return IconButton(
                              icon: Icon(
                                EvaIcons.arrowCircleRightOutline,
                                color: Theme.of(context).colorScheme.primary,
                                size: 40.0,
                              ),
                              onPressed: () {
                                // Eliminar la grabación
                                // context.read<GrabacionBloc>().add(DeleteGrabacionEvent(grabacion.id!));
                                context.read<GeneroBloc>().add(
                                    GetGeneroByNameEvent(
                                        grabacion.nombre ?? 'Desconocido'));
                                if (isPlaying) {
                                  setState(() {
                                    playingPath = null;
                                  });
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            if (state is GrabacionErrorState) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ));
  }
}
