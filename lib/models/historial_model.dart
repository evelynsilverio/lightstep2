import 'package:cloud_firestore/cloud_firestore.dart';

class HistorialModel {
  final String id;
  final DocumentReference? dispositivoRef;
  final DateTime fecha;
  final int tiempoTotal;

  HistorialModel({
    required this.id,
    required this.dispositivoRef,
    required this.fecha,
    required this.tiempoTotal,
  });

  // convertir un model a un map
  // cuando se inserta informacion desde la app
  Map<String, dynamic> toMap() {
    return {
      'dispositivo_ref': dispositivoRef,
      'fecha': Timestamp.fromDate(fecha),
      'tiempo_total': tiempoTotal,
    };
  }

  // crear un model desde un documentoSnapshot
  // cuando se trae la info de Firebase
  factory HistorialModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    return HistorialModel(
      id: doc.id,
      dispositivoRef: data['dispositivo_ref'] as DocumentReference?,
      fecha: (data['fecha'] as Timestamp).toDate(),
      tiempoTotal: (data['tiempo_total'] is int)
          ? data['tiempo_total'] as int
          : int.tryParse(data['tiempo_total'].toString()) ?? 0,
    );
  }
}