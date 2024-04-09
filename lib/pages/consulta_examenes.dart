// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lab/api/get_paciente.dart';
import 'package:lab/functions/show_toast.dart';
import 'package:lab/models/examenes.dart';

class ConsultaExamenes extends StatefulWidget {
  final String paciente;
  final String nombres;

  const ConsultaExamenes(
      {super.key, required this.paciente, required this.nombres});

  @override
  State<ConsultaExamenes> createState() => _ConsultaExamenesState();
}

class _ConsultaExamenesState extends State<ConsultaExamenes> {
  List<Examenes> examenes = [];
  List<Examenes> examenesFilter = [];
  List<String> listaFechas = [];
  FToast fToast = FToast();
  String fechae = '';
  late final List<DropdownMenuItem> _fechas;
  @override
  void initState() {
    super.initState();
    fToast.init(context);
    //  pacientes = await getPacientes(context) as List<Paciente>;
    examenesPaciente(context, criterio: widget.paciente).then((value) {
      if (value != null) {
        examenes = value;
        examenesFilter = examenes;
        Set<String> listafechas =
            Set.from(examenes.map((Examenes examen) => examen.fecha));
        print(listafechas);
        listaFechas.addAll(listafechas);
        listaFechas = ['Fecha del o de los examenes', 'Todos'] + listaFechas;
        _fechas = listaFechas
            .map((e) => DropdownMenuItem(
                  value: e.contains('Fecha') ? '' : e,
                  enabled: e != '',
                  child: Text(
                    e,
                    style: TextStyle(
                        color:
                            e.contains('Fecha') ? Colors.grey : Colors.green),
                  ),
                ))
            .toList();
      } else {
        showToastB(fToast, 'Error en el sevidor');
      }
      setState(() {});
    });
  }

  String imageLab(String examen) {
    String result = '';
    if (examen.toLowerCase().contains('hema')) {
      result = 'images/hemat.png';
      // ignore: curly_braces_in_flow_control_structures
    } else if (examen.toLowerCase().contains('coles') ||
        examen.toLowerCase().contains('trigli') ||
        examen.toLowerCase().contains('lipi'))
    // ignore: curly_braces_in_flow_control_structures
    {
      result = 'images/colesterol.png';
    } else {
      result = 'images/lab.png';
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        title: Text(
          widget.nombres,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
      ),
      body: examenes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: examenesFilter.length + 1,
              itemBuilder: (context, index) {
                late String examen;
                late String fecha;
                late String bacteriologo;
                late String doctor;
                int indexx = index - 1;
                if (index == 0) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: DropdownButton(
                        value: fechae,
                        items: _fechas,
                        onChanged: (value) {
                          fechae = value;
                          examenesFilter = examenes
                              .where((element) => value.contains('-')
                                  ? element.fecha == fechae
                                  : element.fecha != '')
                              .toList();
                          setState(() {});
                        },
                      ),
                    ),
                  );
                } else {
                  examen = examenes[indexx].examen;
                  fecha = examenes[indexx].fecha;
                  bacteriologo = examenes[indexx].bacteriologo;
                  doctor = examenes[indexx].doctor;
                }
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25, // Ajusta el tamaño del avatar
                        backgroundImage: AssetImage(imageLab(examen)),
                      ),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.remove_red_eye,
                          color: Colors.blue,
                        ),
                      ),
                      title: Text(
                        examen,
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fecha,
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Bacteriólogo: $bacteriologo',
                            style: const TextStyle(fontStyle: FontStyle.italic),
                          ),
                          Text(
                            'C.C.: $doctor',
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
}
