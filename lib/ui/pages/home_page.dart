import 'package:app_tesis/provider/color_notifire.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: const Center(child: Text("Hola, tesis!") )
    );
  }
}