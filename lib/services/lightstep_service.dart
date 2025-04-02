import 'package:firebase_database/firebase_database.dart';

class LightstepService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  // Obtener la configuración en tiempo real desde Realtime Database
  Stream<DatabaseEvent> getConfiguracion() {
    return _database.child("config").onValue;
  }

  // Obtener las horas de consumo en tiempo real, agrupadas por día
  Stream<Map<String, double>> getConsumoEnHoras() {
    return _database.child("config").onValue.map((event) {
      final snapshot = event.snapshot;
      final data = snapshot.value as Map<dynamic, dynamic>? ?? {};

      Map<String, double> horasPorDia = {};

      data.forEach((key, value) {
        final item = value as Map<dynamic, dynamic>;
        final estado = item["estado"] ?? "";
        final fecha = item["fecha"] ?? "Sin fecha";
        final horasUtilizadas = (item["opacidad"] as int?)?.toDouble() ?? 0.0;

        if (estado == "activo") {
          // Agrupa las horas de cada día
          horasPorDia[fecha] = (horasPorDia[fecha] ?? 0.0) + horasUtilizadas;
        }
      });

      return horasPorDia;
    });
  }

  // Obtener las horas de consumo filtradas por día
  Stream<Map<String, double>> getConsumoPorDia(DateTime dia) {
    // Formatear la fecha para comparaciones, solo manteniendo YYYY-MM-DD
    final String diaFiltrado =
        "${dia.year}-${dia.month.toString().padLeft(2, '0')}-${dia.day.toString().padLeft(2, '0')}";

    return _database.child("config").onValue.map((event) {
      final snapshot = event.snapshot;
      final data = snapshot.value as Map<dynamic, dynamic>? ?? {};

      Map<String, double> horasPorDia = {};

      data.forEach((key, value) {
        final item = value as Map<dynamic, dynamic>;
        final estado = item["estado"] ?? "";
        final fechaCompleta = item["fecha"] ?? "";
        final horasUtilizadas = (item["opacidad"] as int?)?.toDouble() ?? 0.0;

        // Convertir la fecha completa a solo YYYY-MM-DD
        DateTime fechaObjeto = DateTime.tryParse(fechaCompleta) ?? DateTime(2000);
        String fechaSoloDia =
            "${fechaObjeto.year}-${fechaObjeto.month.toString().padLeft(2, '0')}-${fechaObjeto.day.toString().padLeft(2, '0')}";

        // Filtrar por el día específico
        if (estado == "activo" && fechaSoloDia == diaFiltrado) {
          horasPorDia[fechaSoloDia] = (horasPorDia[fechaSoloDia] ?? 0.0) + horasUtilizadas;
        }
      });

      return horasPorDia;
    });
  }

  // Actualizar la configuración en Realtime Database
  Future<void> updateConfiguracion({
    required String efecto,
    required String estado,
    required String fecha,
    required int opacidad,
    required String color,
  }) async {
    try {
      await _database.child("config").set({
        "efecto": efecto,
        "estado": estado,
        "fecha": fecha,
        "opacidad": opacidad,
        "color": color,
      });
      print("Configuración actualizada en Firebase.");
    } catch (e) {
      print("Error al actualizar configuración: $e");
    }
  }
}