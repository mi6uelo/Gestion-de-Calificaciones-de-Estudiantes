import 'dart:io';
import 'package:gestion_escuela/gestor_calificaciones.dart';
import 'package:gestion_escuela/estudiante.dart';

void main() {
  GestorCalificaciones gestor = GestorCalificaciones();
  int opcion;

  do {
    print("\n--- Menú de Gestión de Calificaciones ---");
    print("1. Añadir un nuevo estudiante");
    print("2. Calcular y mostrar el promedio de un estudiante");
    print("3. Mostrar calificaciones más altas y más bajas por asignatura");
    print("4. Mostrar estudiantes con promedio superior a un valor dado");
    print("5. Ordenar estudiantes por promedio");
    print("6. Salir");
    print("Seleccione una opción:");

    // Leer la opción del usuario
    // el símbolo ? se utiliza para indicar que una variable puede tener un valor o ser null
    String? input = stdin.readLineSync();
    //Operador de "fusión nula" (??)  "si el valor de la izquierda es null, usa el valor de la derecha".
    opcion = int.tryParse(input ?? '') ?? 0;

    switch (opcion) {
      case 1:
        // Añadir un nuevo estudiante
        print("Ingrese el nombre del estudiante:");
        String? nombre = stdin.readLineSync();
        print("Ingrese las calificaciones (separadas por espacio):");
        List<String> calificacionesInput = stdin.readLineSync()!.split(' ');
        // convertir una lista de cadenas de texto (que representan números) en una lista de números de tipo double
        // El operador => se utiliza en lugar return, cuando solo se necesita una expresión.
        List<double> calificaciones =
            calificacionesInput.map((s) => double.tryParse(s) ?? 0.0).toList();

        gestor.agregarEstudiante(nombre ?? '', calificaciones);
        print("El estudiante se agrego exitosamente.");
        break;

      case 2:
        // Calcular y mostrar el promedio de un estudiante
        print("Ingrese el nombre del estudiante:");
        String? nombreEstudiante = stdin.readLineSync();
        Estudiante? estudianteEncontrado = gestor.estudiantes.firstWhere(
          (e) => e.nombre == nombreEstudiante,
          orElse: () => Estudiante("No Encontrado",
              []), // Proporcionar un Estudiante ficticio en caso de no encontrar
        );

        if (estudianteEncontrado.nombre == "No Encontrado") {
          print("Estudiante no encontrado.");
        } else {
          double promedio = gestor.promedioCalificaciones(estudianteEncontrado);
          //El símbolo $ en una cadena de texto permite interpolar variables o expresiones dentro de esa cadena.
          //Envolver una expresión print("El promedio de ${nombreEstudiante.toUpperCase()} es: ${promedio * 100}%");
          print("El promedio de $nombreEstudiante es: $promedio");
        }
        break;

      case 3:
        // Mostrar calificaciones más altas y más bajas por asignatura
        var maxMin = gestor.calificacionesAltasBajas();
        print("Calificaciones más altas y más bajas por asignatura:");
        maxMin.forEach((asignatura, calificaciones) {
          print(
              "$asignatura - Máximo: ${calificaciones[0]}, Mínimo: ${calificaciones[1]}");
        });
        break;

      case 4:
        // Mostrar estudiantes con promedio superior a un valor dado
        print("Ingrese el valor umbral:");
        double valorUmbral = double.parse(stdin.readLineSync()!);
        var estudiantesSuperiores =
            gestor.estudiantesConPromedioSuperior(valorUmbral);
        print("Estudiantes con promedio superior a $valorUmbral:");
        if (estudiantesSuperiores.isNotEmpty) {
          estudiantesSuperiores.forEach((estudiante) {
            print(estudiante.nombre);
          });
        } else {
          print("No hay estudiantes con un promedio superior a $valorUmbral.");
        }
        break;

      case 5:
        // Ordenar estudiantes por promedio
        print("Seleccione el orden (1: Ascendente, 2: Descendente):");
        int orden = int.parse(stdin.readLineSync()!);
        bool ascendente = orden == 1;
        var estudiantesOrdenados = gestor.ordenarPorPromedio(ascendente);
        print(
            "Estudiantes ordenados por promedio (${ascendente ? "ascendente" : "descendente"}):");
        estudiantesOrdenados.forEach((estudiante) {
          print(
              "${estudiante.nombre} - Promedio: ${gestor.promedioCalificaciones(estudiante)}");
        });
        break;

      case 6:
        // Salir del programa
        print("Saliendo del programa...");
        break;

      default:
        print("Opción no válida. Por favor, seleccione una opción del menú.");
    }
  } while (opcion != 6);
}
