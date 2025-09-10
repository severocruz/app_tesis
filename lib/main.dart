import 'package:app_tesis/bloc/blocs.dart';
import 'package:app_tesis/config/app_colors.dart';
import 'package:app_tesis/config/router/app_router.dart';
import 'package:app_tesis/provider/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'provider/color_notifire.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
       providers: [
        ChangeNotifierProvider(create: (context) => ColorNotifire()),
        ChangeNotifierProvider(create: (_) => NavigationProvider())
      ], 
      child:const MyApp())
    );
    
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final colorNotifire = context.watch<ColorNotifire>();

    return MultiBlocProvider(
      providers: Blocs.blocsProviders,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        theme: _lightTheme,
        darkTheme: _darkTheme,
        themeMode: colorNotifire.isDark ? ThemeMode.dark : ThemeMode.light, // se alterna dinámicamente
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('es', ''),
          Locale('en', ''),
        ],
        locale: const Locale('es', ''),
      ),
      
    );
  }
}
// ✅ Tema claro
final ThemeData _lightTheme = ThemeData(
  fontFamily: 'SofiaRegular',
  colorScheme: ColorScheme.light(
    primary: AppColors.primaryLightColor,
    secondary: AppColors.accentColor,
    surface: AppColors.bgColor,
  ),
  useMaterial3: true,
  splashColor: Colors.transparent,
  hoverColor: Colors.transparent,
  highlightColor: Colors.transparent,
  dividerColor: Colors.transparent,
);

// ✅ Tema oscuro
final ThemeData _darkTheme = ThemeData(
  fontFamily: 'SofiaRegular',
  colorScheme: ColorScheme.dark(
    primary: AppColors.primaryDarkColor,
    secondary: AppColors.accentColor,
    surface: Colors.black,
  ),
  useMaterial3: true,
  splashColor: Colors.transparent,
  hoverColor: Colors.transparent,
  highlightColor: Colors.transparent,
  dividerColor: Colors.transparent,
);

