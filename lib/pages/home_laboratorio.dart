import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab/pages/crear_examen.dart';
import 'package:lab/pages/pacientes.dart';
import 'package:lab/widgets/date_picker.dart';

class HomeLaboratorio extends StatefulWidget {
  const HomeLaboratorio({super.key, required this.title});

  final String title;

  @override
  State<HomeLaboratorio> createState() => _HomeLaboratorioState();
}

class _HomeLaboratorioState extends State<HomeLaboratorio> {
  final TextEditingController _fechaController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: buildDatePicker(context, _fechaController)),
            ]),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 0,
            backgroundColor: Colors.amber,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CrearExamen(),
                  ));
            },
            tooltip: 'Agregar Examen',
            child: const Icon(
              Icons.health_and_safety,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          FloatingActionButton(
            heroTag: 1,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Pacientes(),
                  ));
            },
            tooltip: 'Agregar Paciente',
            child: const Icon(Icons.add),
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
