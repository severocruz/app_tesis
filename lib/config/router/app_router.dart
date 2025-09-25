import 'package:app_tesis/models/genero_model.dart';
import 'package:app_tesis/ui/pages/caracteristicas_page.dart';
import 'package:app_tesis/ui/pages/instrumentos_page.dart';
import 'package:app_tesis/ui/pages/show_gender_page.dart';

import 'package:app_tesis/ui/pages/menu_page.dart';
import 'package:app_tesis/ui/pages/home_page.dart';
import 'package:app_tesis/ui/pages/ubicaciones_page.dart';
import 'package:go_router/go_router.dart';
// import 'package:tomatebnb/models/reserve/reserve_response_model.dart';
// import 'package:tomatebnb/ui/pages/accommodation/accommodation_detail_page.dart';


// Simulación de estado de autentificación
bool isAuthenticated = false;

final GoRouter appRouter = GoRouter(
  initialLocation: '/menu',
  routes: [
   
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage()
    ),
    GoRoute(
        path: '/menu',
        builder: (context, state) => const MenuPage()
      ),
    GoRoute(
      path: '/showGender',
      builder: (context, state) {
      final genero = state.extra as GeneroModel;
      return ShowGenderPage(genero: genero);
        },
      ),
    GoRoute(
      path: '/caracteristics',
      builder: (context, state) {
      final genero = state.extra as GeneroModel;
      return CaracteristicasPage(genero: genero);
        },
      ), 
    GoRoute(
      path: '/instruments',
      builder: (context, state) {
      final genero = state.extra as GeneroModel;
      return InstrumentosPage(genero: genero);
        },
      ), 
    GoRoute(
      path: '/ubications',
      builder: (context, state) {
      final genero = state.extra as GeneroModel;
      return UbicacionesPage(genero: genero);
        },
      ),  
  ]
);