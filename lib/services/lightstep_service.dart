import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ligth_step_app/models/configuracion_model.dart';
import 'package:ligth_step_app/models/dispositivos_model.dart';
import 'package:ligth_step_app/models/historial_model.dart';

class LightstepService {
  static final LightstepService _instance = LightstepService._internal();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  factory LightstepService() {
    return _instance;
  }

  LightstepService._internal();

  Stream<List<ConfiguracionModel>> getConfiguracion(String collection) {
    return _firestore.collection(collection).snapshots().map((snapshot) {
      final configuracion = snapshot.docs
          .map((doc) {
            try {
              final config = ConfiguracionModel.fromDocumentSnapshot(doc);
              print(
                  'Configuración recibida: ${config.nombre}, Color: ${config.color}, dispositivo_ref ${config.dispositivoRef}, efecto ${config.efecto}, opacidad ${config.opacidad}, usuario_ref ${config.usuarioRef}');
              return config;
            } catch (e) {
              print('Error al procesar documento: ${doc.id}, Error: $e');
              return null;
            }
          })
          .where((config) => config != null)
          .cast<ConfiguracionModel>()
          .toList();

      print('Total configuraciones: ${configuracion.length}');
      return configuracion;
    });
  }

  Stream<List<HistorialModel>> getHistorial(String collection) {
    return _firestore.collection(collection).snapshots().map((snapshot) {
      final historial = snapshot.docs
          .map((doc) {
            try {
              final storage = HistorialModel.fromDocumentSnapshot(doc);
              print(
                  'Historial recibido fecha: ${storage.fecha}, Tiempo: ${storage.tiempoTotal}, dispositivo_ref: ${storage.dispositivoRef}');
              return storage;
            } catch (e) {
              print('Error al procesar documento: ${doc.id}, Error: $e');
              return null;
            }
          })
          .where((storage) => storage != null)
          .cast<HistorialModel>()
          .toList();

      print('Total historial: ${historial.length}');
      return historial;
    });
  }

  Stream<List<DispositivosModel>> getDispositivo(String collection) {
    return _firestore.collection(collection).snapshots().map((snapshot) {
      final dispositivos = snapshot.docs
          .map((doc) {
            try {
              final disp = DispositivosModel.fromDocumentSnapshot(doc);
              print(
                  'Dispositivo recibido; nombre: ${disp.nombre}, ubicacion: ${disp.ubicacion}');
              return disp;
            } catch (e) {
              print('Error al procesar documento: ${doc.id}, Error: $e');
              return null;
            }
          })
          .where((disp) => disp != null)
          .cast<DispositivosModel>()
          .toList();

      print('Total dispositivos: ${dispositivos.length}');
      return dispositivos;
    });
  }
}

// // COMPROBAR SI CONFIGURACION ESTA TRAYENDOSE CORRECTAMENTE
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  LightstepService service = LightstepService();

  service.getConfiguracion('configuracion').listen((configuracion) {
    print('Recibidas ${configuracion.length} configuraciones');
    for (var config in configuracion) {
      print(
          'ID: ${config.id}, Nombre: ${config.nombre}, Color: ${config.color}');
    }
  });
}

// // // COMPROBAR SI HISTORIAL ESTA TRAYENDOSE CORRECTAMENTE
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();

//   LightstepService service = LightstepService();

//   service.getHistorial('historial').listen((historial) {
//     print('Recibidas ${historial.length} historial');
//     for (var storage in historial) {
//       print(
//           'ID: ${storage.id}, Fecha: ${storage.fecha}, Tiempo: ${storage.tiempoTotal}');
//     }
//   });
// }
// // COMPROBAR SI DISPOSITIVOS ESTA TRAYENDOSE CORRECTAMENTE
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();

//   LightstepService service = LightstepService();

//   service.getDispositivo('dispositivos').listen((dispositivos) {
//     print('Recibidas ${dispositivos.length} dispositivos');
//     for (var dispo in dispositivos) {
//       print(
//           'ID: ${dispo.id}, nombre: ${dispo.nombre}, ubicacion: ${dispo.ubicacion}');
//     }
//   });
// }