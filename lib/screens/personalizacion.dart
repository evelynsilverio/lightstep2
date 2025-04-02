import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:ligth_step_app/widgets/appbar.dart';
import 'package:ligth_step_app/widgets/scaffold_con_degradado.dart';

class Personalizacion extends StatefulWidget {
  const Personalizacion({super.key});

  @override
  State<Personalizacion> createState() => _PersonalizacionState();
}

class _PersonalizacionState extends State<Personalizacion> {
  Color selectedColor = Colors.red;
  final DatabaseReference dbRef = FirebaseDatabase.instance.ref("config");
  double opacity = 1.0;
  int selectedEffect = 0;

  String colorToRgbString(Color color) {
    return "${color.red},${color.green},${color.blue}";
  }

  void guardarConfiguracion() {
    Map<String, dynamic> data = {
      'color': colorToRgbString(selectedColor),
      'efecto': selectedEffect,
      'estado': 'activo',
      'fecha': DateTime.now().toIso8601String(),
      'opacidad': (opacity * 100).toInt(),
    };

    dbRef
        .push()
        .set(data)
        .then((_) {
          print('✅ Configuración guardada en Realtime Database');
        })
        .catchError((error) {
          print('❌ Error al guardar en Firebase Realtime: $error');
        });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: ScaffoldConDegradado(
        appBar: AppbarStyle(title: 'Personalización'),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Textos alineados a la izquierda
            children: [
              _buildSectionTitle('Selecciona un color'),
              SizedBox(height: 20),
              Text(
                'Haz clic para cambiar el color de la luz',
                textAlign: TextAlign.left, // Alineación del texto a la izquierda
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 3,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Center( // Mantener el círculo de cambio de color centrado
                child: GestureDetector(
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Selecciona un color'),
                          content: SingleChildScrollView(
                            child: ColorPicker(
                              pickerColor: selectedColor,
                              onColorChanged: (color) {
                                setState(() => selectedColor = color);
                              },
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                guardarConfiguracion();
                                Navigator.pop(context);
                              },
                              child: Text('Guardar'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [selectedColor.withOpacity(0.6), selectedColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: selectedColor, width: 5),
                    ),
                    child: Center(
                      child: Text(
                        'RGB\n${selectedColor.red}, ${selectedColor.green}, ${selectedColor.blue}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selectedColor.computeLuminance() > 0.5
                              ? Colors.black
                              : Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildSectionTitle('Opacidad'),
              SizedBox(height: 20),
              Text(
                'Ajusta el brillo a tu preferencia',
                textAlign: TextAlign.left, // Alineación del texto a la izquierda
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 3,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(95, 134, 133, 133).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Slider(
                  value: opacity,
                  min: 0,
                  max: 1,
                  divisions: 10,
                  label: '${(opacity * 100).toInt()}%',
                  activeColor: const Color.fromARGB(255, 237, 14, 193),
                  inactiveColor: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                  onChanged: (val) => setState(() => opacity = val),
                  onChangeEnd: (val) => guardarConfiguracion(),
                ),
              ),
              SizedBox(height: 20),
              _buildSectionTitle('Efectos'),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _efectoBoton(0, 'Estático', Colors.purple, Colors.pink),
                  _efectoBoton(1, 'Ciclo', Colors.purple, Colors.blue),
                  _efectoBoton(2, 'Arcoíris', Colors.purple, Colors.orange),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Material(
          color: Colors.purple,
          child: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: "Inicio"),
              Tab(icon: Icon(Icons.settings), text: "Personalización"),
              Tab(icon: Icon(Icons.battery_charging_full), text: "Consumo"),
              Tab(icon: Icon(Icons.person), text: "Perfil"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _efectoBoton(
    int index,
    String label,
    Color startColor,
    Color endColor,
  ) {
    bool isSelected = selectedEffect == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedEffect = index;
          guardarConfiguracion();
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(colors: [startColor, endColor])
              : null,
          color: isSelected ? null : Colors.white10,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pinkAccent, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
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
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}