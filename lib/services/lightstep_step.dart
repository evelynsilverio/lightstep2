import 'package:flutter/material.dart';
import 'package:ligth_step_app/services/lightstep_service.dart';
import 'package:firebase_database/firebase_database.dart';

class Encendido extends StatelessWidget {
  final LightstepService lightstepService = LightstepService();

  // Método para obtener los datos desde Firebase y mostrarlos en consola
  void fetchConfiguracion() {
    lightstepService.getConfiguracion().listen((event) {
      // Extraemos el valor de event y lo convertimos en un Map<String, dynamic>
      Map<String, dynamic> configData = Map<String, dynamic>.from(event as Map);
      print("Datos obtenidos de Firebase: $configData");
    }, onError: (e) {
      print("Error al obtener configuración: $e");
    });
  }

  // Método para crear un nuevo nodo con datos únicos
  void createNewConfig() {
    // Creamos un identificador único para el nuevo nodo con `push()`
    final newConfigRef = FirebaseDatabase.instance.ref().child('config').push();

    // Datos a guardar en el nuevo nodo
    Map<String, dynamic> newConfigData = {
      "efecto": "FadeOut",
      "estado": "encendido",
      "fecha": "2025-12-31",
      "opacidad": 90,
      "id": "002",
      "color": "azul"
    };

    // Guardamos los datos en el nuevo nodo
    newConfigRef.set(newConfigData).then((_) {
      print("Nuevo documento creado exitosamente con ID: ${newConfigRef.key}");
    }).catchError((e) {
      print("Error al crear nuevo documento: $e");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Prueba de Escritura y Lectura")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Llamada a updateConfiguracion para escribir en Firebase
                lightstepService
                    .updateConfiguracion(
                        efecto: "FadeIn",
                        estado: "encendido",
                        fecha: "2025-12-30",
                        opacidad: 80,
                        color: "verde")
                    .then((_) {
                  print("Configuración actualizada exitosamente.");
                }).catchError((e) {
                  print("Error al actualizar configuración: $e");
                });
              },
              child: Text('Actualizar Configuración'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Llamada al método createNewConfig para crear un nuevo documento
                createNewConfig();
              },
              child: Text('Crear Nuevo Documento'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Llamada al método fetchConfiguracion para obtener los datos
                fetchConfiguracion();
              },
              child: Text('Obtener Configuración'),
            ),
          ],
        ),
      ),
    );
  }
}