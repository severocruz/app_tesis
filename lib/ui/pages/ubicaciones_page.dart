import 'package:app_tesis/bloc/export_blocs.dart';
import 'package:app_tesis/config/constants/environment.dart';
import 'package:app_tesis/models/genero_model.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';

import 'package:app_tesis/repository/ubicacion_repository.dart';

final String _imgUrl = Environment.urlImg;
class UbicacionesPage extends StatefulWidget {
  final GeneroModel genero;
  const UbicacionesPage({super.key, required this.genero});

  @override
  State<UbicacionesPage> createState() => _UbicacionesPageState();
}

class _UbicacionesPageState extends State<UbicacionesPage> {
  late final PopupController _popupController;

  @override
  void initState() {
    super.initState();
    _popupController = PopupController();
  }

  @override
  void dispose() {
    _popupController.dispose(); // importante según changelog
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UbicacionBloc(UbicacionRepository())
        ..add(GetUbicacionesByGeneroEvent(widget.genero.id!)),
      child: Scaffold(
        appBar: AppBar(title: Text(widget.genero.nombre ?? 'Sin nombre')),
        body: BlocBuilder<UbicacionBloc, UbicacionState>(
          builder: (context, state) {
            if (state is UbicacionLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetUbicacionesByGeneroSuccessState) {
              final ubicaciones = state.ubicaciones;
              if (ubicaciones.isEmpty) {
                return const Center(child: Text("No se encontraron ubicaciones"));
              }

              // marcadores alineados con la lista (mismo orden)
              final markers = ubicaciones.map((u) {
                return Marker(
                  point: LatLng(
                    (u.latitud ?? 0).toDouble(),
                    (u.longitud ?? 0).toDouble(),
                  ),
                  width: 40,
                  height: 40,
                  child: Icon(EvaIcons.pin, color: Theme.of(context).colorScheme.error, size: 40  ),
                );
              }).toList();

              return FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(
                    (ubicaciones.first.latitud ?? 0).toDouble(),
                    (ubicaciones.first.longitud ?? 0).toDouble(),
                  ),
                  initialZoom: 7.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: const ['a', 'b', 'c'],
                  ),

                  // <-- usa PopupMarkerLayer + PopupMarkerLayerOptions + PopupDisplayOptions(builder: ...)
                  PopupMarkerLayer(
                    options: PopupMarkerLayerOptions(
                      markers: markers,
                      popupController: _popupController,
                      popupDisplayOptions: PopupDisplayOptions(
                        builder: (BuildContext context, Marker marker) {
                          // Encontrar el índice del marcador y tomar la ubicación correspondiente
                          final idx = markers.indexOf(marker);
                          final ubicacion = ubicaciones[idx];

                          return Card(
                            margin: const EdgeInsets.all(8),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    radius: 50, // tamaño
                                    backgroundImage: NetworkImage(
                                      "$_imgUrl/${ubicacion.imagen!}",
                                    ),
                                    backgroundColor: Colors.grey[200], // color de fondo por si falla la carga
                                  ),
                                  Text(
                                    ubicacion.nombre ?? "Sin nombre",
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(ubicacion.descripcion ?? "Sin descripción"),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is GetUbicacionesByGeneroFailureState) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
