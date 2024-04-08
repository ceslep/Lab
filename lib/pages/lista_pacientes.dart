// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:lab/api/get_paciente.dart';
import 'package:lab/functions/show_toast.dart';
import 'package:lab/models/paciente.dart';

class ListaPacientes extends StatefulWidget {
  const ListaPacientes({super.key});

  @override
  State<ListaPacientes> createState() => _ListaPacientesState();
}

class _ListaPacientesState extends State<ListaPacientes> {
  List<Paciente> pacientes = [];
  FToast fToast = FToast();
  bool cargado = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    fToast.init(context);
    //  pacientes = await getPacientes(context) as List<Paciente>;
    getPacientes(context).then((value) {
      if (value != null) {
        pacientes = value;
      } else {
        showToastB(fToast, 'Error en el sevidor');
      }
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
              itemCount: pacientes.length + 1,
              itemBuilder: (context, index) {
                late final String? identificacion;
                late final String? nombres;
                late final String? apellidos;
                late final String? fecnac;
                late final String? sexo;
                late final String? telefono;
                late final String? correo;
                late int edad;
                int iindex = index - 1;
                if (index > 0) {
                  identificacion = pacientes[iindex].identificacion;
                  nombres = pacientes[iindex].nombres;
                  apellidos =
                      pacientes[iindex].apellidos?.replaceAll('\ufffd', 'Ñ');
                  fecnac = pacientes[iindex].fecnac;
                  sexo = pacientes[iindex].genero;
                  telefono = pacientes[iindex].telefono;
                  correo = pacientes[iindex].correo;
                  edad = calcularEdad(fecnac!);
                }
                return index == 0
                    ? SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0, right: 18),
                          child: TextField(
                            controller: _controller,
                            autofocus: true,
                            onChanged: buscarChanged,
                            decoration: InputDecoration(
                              labelText: 'Buscar...',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  _controller.clear();
                                  buscarChanged('');
                                },
                                icon: const Icon(Icons.clear),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(left: 18.0, right: 18),
                        child: Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Icon(sexo == 'Masculino'
                                  ? Icons.male
                                  : Icons.female),
                            ),
                            trailing: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.medical_information,
                                  color: Colors.blueAccent),
                            ),
                            title: Text(
                              "${apellidos!} ${nombres!}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
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
                                  correo != null ? "Correo: $correo" : "",
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
              },
            ),
    );
  }

  void buscarChanged(value) async {
    if (value.length < 6) {
      if (value.isEmpty) {
        setState(() => cargado = !cargado);
        pacientes = await getPacientes(context) as List<Paciente>;
        setState(() => cargado = !cargado);
      }
      setState(() {});
    } else {
      //  setState(() => pacientes = []);
      pacientes =
          await getPacientes(context, criterio: value) as List<Paciente>;
      setState(() => cargado = !cargado);
    }
  }
}
