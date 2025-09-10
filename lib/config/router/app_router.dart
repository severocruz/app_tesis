import 'package:flutter/material.dart';
import 'package:app_tesis/ui/pages/home_page.dart';
import 'package:go_router/go_router.dart';
// import 'package:tomatebnb/models/reserve/reserve_response_model.dart';
// import 'package:tomatebnb/ui/pages/accommodation/accommodation_detail_page.dart';


// Simulación de estado de autentificación
bool isAuthenticated = false;

final GoRouter appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
   
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage()
    ),
   
  ]
);