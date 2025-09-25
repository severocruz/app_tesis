import 'package:app_tesis/config/constants/environment.dart';
import 'package:flutter/material.dart';
import 'package:app_tesis/models/Instrumento_model.dart';

class InstrumentoCard extends StatelessWidget {
  final InstrumentoModel instrumento;
  final String _imgUrl = Environment.urlImg;
  InstrumentoCard({super.key, required this.instrumento});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      shadowColor: Theme.of(context).brightness == Brightness.dark
      ? Theme.of(context).colorScheme.secondary   // sombra clara en modo oscuro
      : Theme.of(context).colorScheme.primary,  // sombra oscura en modo claro
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen de cabecera
          if (instrumento.imagen != null && instrumento.imagen!.isNotEmpty)
            SizedBox(
              width: double.infinity,
              height: 180,
              child: Image.network(
                 "$_imgUrl/${instrumento.imagen!}" ,
                fit: BoxFit.cover,
              ),
            )
          else
            Container(
              height: 180,
              color: Colors.grey.shade300,
              alignment: Alignment.center,
              child: const Icon(Icons.image_not_supported, size: 60, color: Colors.grey),
            ),

          // Contenido
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nombre
                Text(
                  instrumento.nombre ?? "Sin nombre",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 6),

                // Descripción
                if (instrumento.descripcion != null)
                  Text(
                    instrumento.descripcion!,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),

                const SizedBox(height: 8),

                // Fecha de creación (opcional)
                // if (Instrumento.createdAt != null)
                //   Text(
                //     "Creado: ${Instrumento.createdAt!.toLocal().toString().split(' ')[0]}",
                //     style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                //   ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
