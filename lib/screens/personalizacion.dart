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
  double opacity = 0.8;
  int selectedEffect = 0;
  int apagadoEn = 10;
  TimeOfDay apagadoALas = TimeOfDay.now();

  List<Color> presetColors = [
    Colors.purple,
    Colors.green,
    Colors.blue,
    Colors.yellow
  ];

  List<Color> customColors = [
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey
  ];

  @override
  Widget build(BuildContext context) {
    return ScaffoldConDegradado(
      appBar: AppbarStyle(title: 'Personalización'),
      body: Container(
        color: const Color.fromARGB(0, 73, 19, 79),
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Selecciona un color'),
              SizedBox(height: 10),

              // Contenedor principal con fondo opaco y bordes redondeados
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Círculo RGB más grande y centrado
                    Center(
                      child: GestureDetector(
                        onTap: () async {
                          Color? pickedColor = await showDialog(
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
                                    pickerAreaHeightPercent: 0.7,
                                    enableAlpha: false,
                                    displayThumbColor: true,
                                    paletteType: PaletteType.hsvWithHue,
                                    labelTypes: [],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cerrar'),
                                  ),
                                ],
                              );
                            },
                          );
                          if (pickedColor != null) {
                            setState(() {
                              selectedColor = pickedColor;
                            });
                          }
                        },
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(125),
                            border: Border.all(
                              color: selectedColor,
                              width: 5,
                            ),
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
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Primera hilera de 4 colores predefinidos con tamaño pequeño
                    Text('Colores Estándar',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(presetColors.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedColor = presetColors[index];
                            });
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: presetColors[index],
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 5,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 20),

                    // Segunda hilera de colores personalizables (más pequeños)
                    Text('Colores Personalizados',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(customColors.length, (index) {
                        return GestureDetector(
                          onTap: () async {
                            Color? pickedColor = await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Selecciona un color'),
                                  content: SingleChildScrollView(
                                    child: ColorPicker(
                                      pickerColor: customColors[index],
                                      onColorChanged: (color) {
                                        setState(
                                            () => customColors[index] = color);
                                      },
                                      pickerAreaHeightPercent: 0.7,
                                      enableAlpha: false,
                                      displayThumbColor: true,
                                      paletteType: PaletteType.hsvWithHue,
                                      labelTypes: [],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Cerrar'),
                                    ),
                                  ],
                                );
                              },
                            );
                            if (pickedColor != null) {
                              setState(() {
                                customColors[index] = pickedColor;
                              });
                            }
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: customColors[index],
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 5,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 10),

                    // Botones de cancelar y aplicar con bordes degradados
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _gradientButton('Cancelar', () {}, Colors.purpleAccent,
                            Colors.redAccent),
                        _gradientButton('Aplicar', () {}, Colors.greenAccent,
                            Colors.blueAccent),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),

              // Efectos
              _buildSectionTitle('Efectos'),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _efectoBoton(
                      0, 'Estático', Colors.purple, Colors.purple, Colors.pink),
                  _efectoBoton(
                      1, 'Ciclo', Colors.purple, Colors.purple, Colors.pink),
                  _efectoBoton(2, 'Arcoíris', Colors.purple, Colors.purple,
                      Colors.pink, Colors.pink),
                ],
              ),

              SizedBox(height: 20),

              // Opacidad
              _buildSectionTitle('Opacidad'),
              Slider(
                value: opacity,
                min: 0,
                max: 1,
                divisions: 10,
                label: (opacity * 100).toInt().toString() + '%',
                onChanged: (val) => setState(() => opacity = val),
              ),

              SizedBox(height: 20),

              // Tiempo de Apagado
              _buildSectionTitle('Tiempo de Apagado'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => setState(
                        () => apagadoEn = (apagadoEn - 5).clamp(0, 120)),
                    icon: Icon(Icons.remove, color: Colors.white),
                  ),
                  Text('$apagadoEn minutos',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  IconButton(
                    onPressed: () => setState(
                        () => apagadoEn = (apagadoEn + 5).clamp(0, 120)),
                    icon: Icon(Icons.add, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: apagadoALas,
                    );
                    if (picked != null) setState(() => apagadoALas = picked);
                  },
                  child: Text('Apagar a las: ${apagadoALas.format(context)}'),
                ),
              ),
            ],
          ),
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

  // Botón con fondo degradado para "Cancelar" y "Aplicar"
  Widget _gradientButton(
      String label, VoidCallback onPressed, Color startColor, Color endColor) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: startColor,
            width: 2,
          ),
        ),
        side: BorderSide(
          color: Colors.transparent,
          width: 0,
        ),
      ),
    );
  }

  Widget _efectoBoton(int index, String label, Color startColor,
      [Color? midColor, Color? endColor, Color? additionalColor]) {
    bool isSelected = selectedEffect == index;

    List<Color> gradientColors = [];
    if (midColor != null && endColor != null) {
      gradientColors = [startColor, midColor, endColor];
    } else if (additionalColor != null) {
      gradientColors = [startColor, midColor!, endColor!, additionalColor];
    } else {
      gradientColors = [startColor];
    }

    return GestureDetector(
      onTap: () => setState(() => selectedEffect = index),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: gradientColors,
                )
              : null,
          color: isSelected ? null : Colors.white10,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(color: Colors.white),
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
      padding: EdgeInsets.all(3),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 90, 8, 88),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}