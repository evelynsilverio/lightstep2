import 'package:cloud_firestore/cloud_firestore.dart';

class DispositivosModel {
  final String id;
  final String nombre;
  final String ubicacion;

  DispositivosModel({
    required this.id,
    required this.nombre,
    required this.ubicacion,
  });

  // convertir un model a un map
  // cuando se inserta informacion desde la app
  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'ubicacion': ubicacion,
    };
  }

  // crear un model desde un documentoSnapshot
  // cuando se trae la info de Firebase
  factory DispositivosModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    return DispositivosModel(
      id: doc.id,
      nombre: data['nombre'] ?? 'Sin nombre',
      ubicacion: data['ubicacion'] ?? 'Sin ubicacion',
    );
  }
}