import 'estudiante.dart';

class GestorCalificaciones {
  List<Estudiante> estudiantes = [];

  // Añadir un nuevo estudiante con sus respectivas calificaciones
  void agregarEstudiante(String nombre, List<double> calificaciones) {
    estudiantes.add(Estudiante(nombre, calificaciones));
  }

  // Calcular y devolver el promedio de calificaciones de cada estudiante
  double promedioCalificaciones(Estudiante estudiante) {
    return estudiante.calificaciones.reduce((a, b) => a + b) /
        estudiante.calificaciones.length;
  }

  // Determinar la calificación más alta y más baja para cada asignatura
  Map<String, List<double>> calificacionesAltasBajas() {
    Map<String, List<double>> resultados = {};
    for (var estudiante in estudiantes) {
      for (var i = 0; i < estudiante.calificaciones.length; i++) {
        resultados.putIfAbsent('Asignatura ${i + 1}', () => []);
        resultados['Asignatura ${i + 1}']!.add(estudiante.calificaciones[i]);
      }
    }

    // Calcular máximos y mínimos
    Map<String, List<double>> maxMin = {};
    resultados.forEach((asignatura, calificaciones) {
      maxMin[asignatura] = [
        calificaciones.reduce((a, b) => a > b ? a : b), // Máximo
        calificaciones.reduce((a, b) => a < b ? a : b) // Mínimo
      ];
    });
    return maxMin;
  }

  // Mostrar estudiantes con promedio superior a un valor dado
  List<Estudiante> estudiantesConPromedioSuperior(double valor) {
    return estudiantes
        .where((estudiante) => promedioCalificaciones(estudiante) > valor)
        .toList();
  }

  // Ordenar la lista de estudiantes por promedio de calificaciones
  List<Estudiante> ordenarPorPromedio(bool ascendente) {
    estudiantes.sort((a, b) {
      double promedioA = promedioCalificaciones(a);
      double promedioB = promedioCalificaciones(b);
      return ascendente
          ? promedioA.compareTo(promedioB)
          : promedioB.compareTo(promedioA);
    });
    return estudiantes;
  }
}
