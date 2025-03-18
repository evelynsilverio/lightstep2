import 'package:flutter/material.dart';
import 'package:ligth_step_app/screens/consumo.dart';
import 'package:ligth_step_app/screens/iniciar_sesion.dart';
import 'package:ligth_step_app/screens/inicio.dart';
import 'package:ligth_step_app/screens/perfil.dart';
import 'package:ligth_step_app/screens/personalizacion.dart';
import 'package:ligth_step_app/widgets/tabbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto Mono',
        scaffoldBackgroundColor: Colors.transparent,
      ),
      initialRoute: '/', // Ruta inicial
      routes: {
        '/': (context) => const LoginScreen(), // TabBar principal
        '/personalizacion': (context) => const Personalizacion(),
        '/consumo': (context) => const ConsumoScreen(),
        '/perfil': (context) => const Perfil(),
      },
    );
  }
}
