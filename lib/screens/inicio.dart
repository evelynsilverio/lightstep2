import 'package:flutter/material.dart';
import 'package:ligth_step_app/screens/consumo.dart';
import 'package:ligth_step_app/screens/perfil.dart';
import 'package:ligth_step_app/screens/personalizacion.dart';
import 'package:ligth_step_app/widgets/appbar.dart';
import 'package:ligth_step_app/widgets/scaffold_con_degradado.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldConDegradado(
      appBar: AppbarStyle(
        title: "Iniciar Sesión",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                _buildGradientButton(
                  context,
                  "Personaliza",
                  [
                    const Color.fromARGB(255, 168, 240, 73),
                    const Color.fromARGB(255, 47, 177, 228)
                  ],
                  () {
                    Navigator.pushNamed(context, '/personalizacion');
                  },
                ),
                _buildGradientButton(
                  context,
                  "Mira tu consumo",
                  [
                    const Color.fromARGB(255, 158, 181, 251),
                    const Color.fromARGB(255, 240, 84, 157)
                  ],
                  () {
                    Navigator.pushNamed(context, '/consumo');
                  },
                ),
                _buildGradientButton(
                  context,
                  "Perfil",
                  [
                    const Color.fromARGB(255, 240, 87, 41),
                    const Color.fromARGB(255, 249, 201, 43)
                  ],
                  () {
                    Navigator.pushNamed(context, '/perfil');
                  },
                ),
                const SizedBox(height: 120), // Espacio para que no tape el TabBar
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Material(
        color: Colors.black,
        child: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.home), text: "Inicio"),
            Tab(icon: Icon(Icons.palette), text: "Personalización"),
            Tab(icon: Icon(Icons.bar_chart), text: "Consumo"),
            Tab(icon: Icon(Icons.person), text: "Perfil"),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientButton(
    BuildContext context,
    String text,
    List<Color> gradientColors,
    VoidCallback onPressed,
  ) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Transform.translate(
        offset: const Offset(-40, 0),
        child: Container(
          width: MediaQuery.of(context).size.width * 1,
          height: 240,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(120),
              bottomRight: Radius.circular(120),
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: Offset(3, 3),
              ),
            ],
          ),
          child: InkWell(
            onTap: onPressed,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(120),
              bottomRight: Radius.circular(120),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
