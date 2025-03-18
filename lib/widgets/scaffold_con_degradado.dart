import 'package:flutter/material.dart';

class ScaffoldConDegradado extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar; // Permitir personalizar la AppBar

  const ScaffoldConDegradado({
    super.key,
    required this.body,
    this.appBar,
    required Material bottomNavigationBar, // La AppBar es opcional
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Fondo degradado
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 44, 1, 51),
                Color.fromARGB(255, 106, 11, 100),
                Color.fromARGB(255, 122, 7, 113),
              ],
            ),
          ),
        ),
        // Contenido principal con Scaffold
        Scaffold(
          backgroundColor: Colors.transparent, // Fondo transparente
          appBar: appBar, // Recibe una AppBar personalizada
          body: body, // Recibe el contenido de la pantalla
        ),
      ],
    );
  }
}