import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ligth_step_app/screens/consumo.dart';
import 'package:ligth_step_app/screens/iniciar_sesion.dart';
import 'package:ligth_step_app/screens/perfil.dart';
import 'package:ligth_step_app/screens/personalizacion.dart';
import 'package:ligth_step_app/services/lightstep_service.dart';
import 'package:ligth_step_app/services/lightstep_step.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  print('Firebase inicializado correctamente');

  LightstepService service = LightstepService();

  // MANDAR A LLAMAR LOS SERVICIOS
  // SIRVE PARA CONFIGURACIÓN
  // service.getConfiguracion('configuracion').listen((configuracion) {
  //   print('Recibidas ${configuracion.length} configuraciones');
  // });

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
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/personalizacion': (context) => const Personalizacion(),
        '/consumo': (context) => ConsumoScreen(),
        '/perfil': (context) => const Perfil(),
      },
    );
  }
}