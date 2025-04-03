import 'package:flutter/material.dart';
import 'package:ligth_step_app/widgets/appbar.dart';
import 'package:ligth_step_app/widgets/scaffold_con_degradado.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:ligth_step_app/services/lightstep_service.dart';

class ConsumoScreen extends StatefulWidget {
  const ConsumoScreen({super.key});

  @override
  State<ConsumoScreen> createState() => _ConsumoScreenState();
}

class _ConsumoScreenState extends State<ConsumoScreen> {
  final LightstepService _service = LightstepService();
  late Stream<Map<String, double>> _streamHoras;

  List<Color> colorList = [
    const Color.fromARGB(255, 244, 6, 165),
    const Color.fromARGB(255, 193, 206, 8),
    const Color.fromARGB(255, 90, 120, 228),
    const Color.fromARGB(255, 240, 123, 80),
  ];

@override
void initState() {
  super.initState();
  _streamHoras = _service.getConsumoAgrupadoPorDia();
}

  @override
  Widget build(BuildContext context) {
    return ScaffoldConDegradado(
      appBar: AppbarStyle(title: 'Consumo por Día'),
      body: SingleChildScrollView(
        child: StreamBuilder<Map<String, double>>(
          stream: _streamHoras,
          builder: (context, snapshot) {
  if (snapshot.connectionState == ConnectionState.waiting) {
    return const Center(child: CircularProgressIndicator());
  }
  if (snapshot.hasError) {
    return const Center(child: Text("Error al cargar los datos"));
  }
  if (!snapshot.hasData || snapshot.data!.isEmpty) {
    return const Center(child: Text("No hay datos disponibles"));
  }

  final dataMap = snapshot.data!;
  print("Datos agrupados que llegan al gráfico: $dataMap"); // Debug para confirmar datos




            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  _buildSectionTitle("Consumo por Día"),
                  const SizedBox(height: 30),
                  _buildContainerWithTransparentBackground(
                    child: Column(
                      children: [
                        PieChart(
                          dataMap: dataMap, // Ahora se usan los datos por día
                          colorList: colorList,
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: false,
                            decimalPlaces: 0,
                            chartValueStyle: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          legendOptions: const LegendOptions(showLegends: true),
                          chartType: ChartType.ring,
                          ringStrokeWidth: 32,
                          chartRadius: MediaQuery.of(context).size.width / 2,
                        ),
                        const SizedBox(height: 30),
                        _buildLegend(dataMap),
                      ],
                    ),
                  ),  
                ],
              ),
            );
          },
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
                color: const Color.fromARGB(255, 0, 0, 0),
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
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildContainerWithTransparentBackground({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }

  Widget _buildLegend(Map<String, double> dataMap) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(57, 0, 0, 0).withOpacity(0.6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: dataMap.entries.map((entry) {
          final colorIndex = dataMap.keys.toList().indexOf(entry.key) % colorList.length;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: colorList[colorIndex],
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "Fecha: ${entry.key}, Segundos: ${entry.value.toInt()}",
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
} 
