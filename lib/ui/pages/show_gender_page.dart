import 'package:app_tesis/config/constants/environment.dart';
import 'package:app_tesis/models/genero_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
class ShowGenderPage extends StatefulWidget {
  final GeneroModel genero;
  const ShowGenderPage({super.key, required this.genero});
  @override
  State<ShowGenderPage> createState() => _ShowGenderPageState();
}

class _ShowGenderPageState extends State<ShowGenderPage> {
  final String _imgUrl = Environment.urlImg;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.genero.porcentaje?.toStringAsFixed(1) }%  es ${widget.genero.nombre} '),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column( 
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.genero.imagen != null && widget.genero.imagen!.isNotEmpty)
              Image.network(
                "$_imgUrl/${widget.genero.imagen!}",
                fit: BoxFit.cover,
                height: 250,
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.genero.nombre ?? 'Género Desconocido',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  
                  const SizedBox(height: 8),
                  Text(
                    widget.genero.descripcion ?? 'No hay descripción disponible.',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  if (widget.genero.videoLink != null && widget.genero.videoLink!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                             ElevatedButton.icon(
                                  onPressed: (){
                                    context.push('/caracteristics', extra: widget.genero);
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: Theme.of(context).colorScheme.primary  , width: 2), // contorno
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30), // bordes redondeados
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                                  ),
                                  icon: const Icon(Icons.info, color: Colors.purple, size: 32),
                                  iconAlignment: IconAlignment.end,
                                  label: Text("Conocer mas ", style: const TextStyle(fontSize: 18),)
                                ),
                              const SizedBox(height: 12,width: double.infinity,),
                               ElevatedButton.icon(
                                  onPressed: (){
                                    
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: Theme.of(context).colorScheme.primary  , width: 2), // contorno
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30), // bordes redondeados
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                                  ),
                                  icon: const Icon(Icons.map, color: Colors.purple, size: 32),
                                  iconAlignment: IconAlignment.end,
                                  label: Text("¿Donde se lo practica? ", style: const TextStyle(fontSize: 18),)
                                ),
                              
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                         const Text(
                          'Video Relacionado:',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {
                            // Aquí podrías abrir el enlace en un navegador o reproductor de video
                            // launchUrl(Uri.parse(widget.genero.videoLink!));
                            abrirLink(widget.genero.videoLink!);
                          },
                          child: Text(
                            widget.genero.videoLink!,
                            style: const TextStyle(fontSize: 16, color: Colors.blue, decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> abrirLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'No se pudo abrir el link $url';
    }
  }
}