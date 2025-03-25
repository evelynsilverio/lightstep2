import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ConfiguracionModel {
  final String id;
  final DocumentReference? dispositivoRef;
  final String color;
  final String efecto;
  final String nombre;
  final int opacidad;
  final DocumentReference? usuarioRef;

  ConfiguracionModel({
    required this.id,
    required this.dispositivoRef,
    required this.color,
    required this.efecto,
    required this.nombre,
    required this.opacidad,
    required this.usuarioRef,
  });

  // convertir un model a un map
  // cuando se inserta informacion desde la app
  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'dispositivo_ref': dispositivoRef,
      'color': color,
      'efecto': efecto,
      'nombre': nombre,
      'opacidad': opacidad,
      'usuario_ref': usuarioRef,
    };
  }

  // crear un model desde un documentoSnapshot
  // cuando se trae la info de Firebase
  factory ConfiguracionModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    return ConfiguracionModel(
      id: doc.id,
      dispositivoRef: data['dispositivo_ref'] as DocumentReference?,
      color: data['color'] ?? 'Sin color',
      efecto: data['efecto'] ?? 'Sin efecto',
      nombre: data['nombre'] ?? 'Sin nombre',
      opacidad: (data['opacidad'] is int)
          ? data['opacidad'] as int
          : int.tryParse(data['opacidad'].toString()) ?? 0,
      usuarioRef: data['usuario_ref'] as DocumentReference?,
    );
  }
}