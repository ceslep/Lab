import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab/pages/lista_pacientes.dart';

import '../widgets/home/home_fl.dart';

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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListaPacientes(),
                    ));
              },
              icon: const Icon(Icons.group, color: Colors.white),
            ),
          ),
        ],
      ),
      body: BodyHome(fechaController: _fechaController),
      floatingActionButton: const FloatingActionButtonHome(),
    );
  }
}
