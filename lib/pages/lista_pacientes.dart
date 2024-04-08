import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:lab/api/get_paciente.dart';
import 'package:lab/models/paciente.dart';

class ListaPacientes extends StatefulWidget {
  const ListaPacientes({super.key});

  @override
  State<ListaPacientes> createState() => _ListaPacientesState();
}

class _ListaPacientesState extends State<ListaPacientes> {
  List<Paciente> pacientes = [];
  bool cargado = false;

  @override
  void initState() {
    super.initState();
    getPacientes(context).then((value) {
      List<Map<String, dynamic>> fpacientes =
          value.cast<Map<String, dynamic>>();
      pacientes =
          fpacientes.map((paciente) => Paciente.fromJson(paciente)).toList();
      setState(() {});
    });
  }

  int calcularEdad(String fecnac) {
    DateTime fechaNacimiento = DateFormat("yyyy-MM-dd").parse(fecnac);
    DateTime ahora = DateTime.now();
    int diferenciaAnios = ahora.year - fechaNacimiento.year;
    int diferenciaMeses = ahora.month - fechaNacimiento.month;
    int diferenciaDias = ahora.day - fechaNacimiento.day;

    if (diferenciaMeses < 0 || (diferenciaMeses == 0 && diferenciaDias < 0)) {
      diferenciaAnios--;
    }

    return diferenciaAnios;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Lista de Pacientes'),
      ),
      body: pacientes.isEmpty
          ? const Center(
              child: SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                strokeWidth: 4,
              ),
            ))
          : ListView.builder(
              itemBuilder: (context, index) {
                final String? identificacion = pacientes[index].identificacion;
                final String? nombres = pacientes[index].nombres;
                final String? apellidos = pacientes[index].apellidos;
                final String? fecnac = pacientes[index].fecnac;
                final String? sexo = pacientes[index].genero;
                final String? telefono = pacientes[index].telefono;
                final String? correo = pacientes[index].correo;
                int edad = calcularEdad(fecnac!);
                return Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Icon(
                            sexo == 'Masculino' ? Icons.male : Icons.female),
                      ),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.medical_information,
                            color: Colors.blueAccent),
                      ),
                      title: Text(
                        "${apellidos!} ${nombres!}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Identificación: $identificacion"),
                          Text("Fecha de Nacimiento: $fecnac"),
                          Row(
                            children: [
                              Text(
                                "Edad: $edad.",
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                "Sexo: $sexo",
                              ),
                            ],
                          ),
                          Text(
                            "Telefono: $telefono",
                            style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Correo: $correo",
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: pacientes.length),
    );
  }
}
