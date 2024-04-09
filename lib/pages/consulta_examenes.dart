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
  FToast fToast = FToast();
  @override
  void initState() {
    super.initState();
    fToast.init(context);
    //  pacientes = await getPacientes(context) as List<Paciente>;
    examenesPaciente(context, criterio: widget.paciente).then((value) {
      if (value != null) {
        examenes = value;
      } else {
        showToastB(fToast, 'Error en el sevidor');
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        title: Text(widget.nombres),
      ),
      body: examenes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: examenes.length,
              itemBuilder: (context, index) {
                String examen = examenes[index].codexamen;
                String fecha = examenes[index].fecha;
                String bacteriologo = examenes[index].bacteriologo;
                String doctor = examenes[index].doctor;
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Card(
                    child: ListTile(
                      leading: Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.health_and_safety,
                              color: Colors.green,
                            ),
                          ),
                        ],
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
