import 'package:cloud_firestore/cloud_firestore.dart';

class ConfiguracionModel {
  final Map<String, dynamic> color; // Guardamos como {r, g, b}
  final String efecto;
  final int opacidad;
  final String estado;
  final DateTime fecha;

  ConfiguracionModel({
    required this.color,
    required this.efecto,
    required this.opacidad,
    required this.estado,
    required this.fecha,
  });

  // Convertir modelo a mapa para Firestore
  Map<String, dynamic> toMap() {
    return {
      'color': color, // Se guarda como { "r": 255, "g": 87, "b": 51 }
      'efecto': efecto,
      'opacidad': opacidad,
      'estado': estado,
      'fecha': Timestamp.fromDate(fecha),
    };
  }

  // Crear un modelo desde un documento de Firestore
  factory ConfiguracionModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    return ConfiguracionModel(
      color: data['color'] as Map<String, dynamic>? ??
          {"r": 255, "g": 255, "b": 255}, // Blanco por defecto
      efecto: data['efecto'] ?? 'Sin efecto',
      estado: data['estado'] ?? 'Sin estado',
      fecha: (data['fecha'] is Timestamp)
          ? (data['fecha'] as Timestamp).toDate()
          : DateTime.now(),
      opacidad: (data['opacidad'] is int)
          ? data['opacidad'] as int
          : int.tryParse(data['opacidad']?.toString() ?? '0') ?? 0,
    );
  }
}