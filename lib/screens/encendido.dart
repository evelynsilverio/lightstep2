import 'package:flutter/material.dart';
import 'package:ligth_step_app/widgets/scaffold_con_degradado.dart';
import 'package:ligth_step_app/widgets/tabbar.dart';  // Asegúrate de importar la pantalla TabBarScreen

class Encendido extends StatefulWidget {
  const Encendido({super.key});

  @override
  State<Encendido> createState() => _EncendidoState();
}

class _EncendidoState extends State<Encendido> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldConDegradado(
      body: Container(
        decoration: const BoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 80), 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 15),
                  Text(
                    "LightStep",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF0080), Color(0xFF8000FF)],
                ),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  color: Colors.purple.shade900,
                ),
                child: const Text(
                  "Bienvenido, usuario",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 120),
            GestureDetector(
              onTap: () {
                // Acción del botón para navegar al TabBarScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TabBarScreen()),
                );
              },
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8000FF), Color(0xFFFF0080)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    width: 220,
                    height: 220,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF300048),
                    ),
                    child: Center(
                      child: Container(
                        width: 170,
                        height: 170,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.1),
                              blurRadius: 15,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(Icons.power_settings_new,
                              size: 80, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Material(
        color: Colors.purple, // Fondo para que se vea mejor
        child: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.home), text: "Inicio"),
            Tab(icon: Icon(Icons.settings), text: "Personalización"),
            Tab(icon: Icon(Icons.battery_charging_full), text: "Consumo"),
            Tab(icon: Icon(Icons.person), text: "Perfil"),
          ],
        ),
      ),
    );
  }
}
