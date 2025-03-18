import 'package:flutter/material.dart';
import 'package:ligth_step_app/widgets/appbar.dart';
import 'package:ligth_step_app/widgets/scaffold_con_degradado.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ConsumoScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ConsumoScreen extends StatefulWidget {
  const ConsumoScreen({super.key});

  @override
  State<ConsumoScreen> createState() => _ConsumoScreenState();
}

class _ConsumoScreenState extends State<ConsumoScreen> {
  String todayUsageTime = "03h : 30m : 50s";
  String deviceOnCount = "5 veces";
  double bar1Height = 150;
  double bar2Height = 120;

  String todayStats = "03h 30m";
  String weekStats = "03h 00m";

  void updateStats() {
    setState(() {
      todayStats = "21h 00m";
      weekStats = "03h 00m";
      bar1Height = 180;
      bar2Height = 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldConDegradado(
      appBar: AppbarStyle(title: 'Personalización'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              _buildSectionTitle("Consumo"),
              const SizedBox(height: 10),
              _buildInfoBox(
                  "Hoy has utilizado el dispositivo:", todayUsageTime),
              const SizedBox(height: 10),
              _buildInfoBox("El dispositivo ha sido encendido:", deviceOnCount),
              const SizedBox(height: 20),
              _buildSectionTitle("Estadísticas"),
              const SizedBox(height: 10),
              _buildBarChart(),
              const SizedBox(height: 20),
              _buildBottomButtons(),
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: updateStats,
                  child: _buildButton("Actualizar Estadísticas",
                      Colors.purple.shade600, Colors.pink.shade400),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Material(
        color: Colors.purple,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.white,
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.pushNamed(context, '/seccion1');
                },
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pinkAccent, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(3),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 90, 8, 88),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildInfoBox(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(height: 5),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white.withOpacity(0.2),
          ),
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildBarChart() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.purple.shade700,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildBar(Colors.greenAccent, bar1Height, todayStats),
          _buildBar(Colors.orangeAccent, bar2Height, weekStats),
        ],
      ),
    );
  }

  Widget _buildBar(Color color, double height, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: 40,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, Colors.deepOrange],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildBottomButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButton("Hoy", Colors.yellow.shade600, Colors.orange.shade700),
        _buildButton(
            "Semana Anterior", Colors.blue.shade400, Colors.green.shade400),
      ],
    );
  }

  Widget _buildButton(String text, Color startColor, Color endColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [startColor, endColor],
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}